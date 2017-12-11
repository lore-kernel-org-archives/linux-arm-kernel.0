From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 11 Dec 2017 15:32:20 -0800
Subject: [PATCH net-next v5 2/2] net: thunderx: add timestamping support
In-Reply-To: <20171211141435.2915-3-aleksey.makarov@cavium.com>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-3-aleksey.makarov@cavium.com>
Message-ID: <20171211233220.d72rys7nci4lqqd5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:14:31PM +0300, Aleksey Makarov wrote:
> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 4a02e618e318..204b234beb9d 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic.h
> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> @@ -263,6 +263,8 @@ struct nicvf_drv_stats {
>  	struct u64_stats_sync   syncp;
>  };
>  
> +struct cavium_ptp;
> +
>  struct nicvf {
>  	struct nicvf		*pnicvf;
>  	struct net_device	*netdev;
> @@ -312,6 +314,12 @@ struct nicvf {
>  	struct tasklet_struct	qs_err_task;
>  	struct work_struct	reset_task;
>  
> +	/* PTP timestamp */
> +	struct cavium_ptp	*ptp_clock;
> +	bool			hw_rx_tstamp;
> +	struct sk_buff		*ptp_skb;
> +	atomic_t		tx_ptp_skbs;

It is disturbing that the above two fields are set in different
places.  Shouldn't they be unified into one logical lock?

Here you clear them together:

> +static void nicvf_snd_ptp_handler(struct net_device *netdev,
> +				  struct cqe_send_t *cqe_tx)
> +{
> +	struct nicvf *nic = netdev_priv(netdev);
> +	struct skb_shared_hwtstamps ts;
> +	u64 ns;
> +
> +	nic = nic->pnicvf;
> +
> +	/* Sync for 'ptp_skb' */
> +	smp_rmb();
> +
> +	/* New timestamp request can be queued now */
> +	atomic_set(&nic->tx_ptp_skbs, 0);
> +
> +	/* Check for timestamp requested skb */
> +	if (!nic->ptp_skb)
> +		return;
> +
> +	/* Check if timestamping is timedout, which is set to 10us */
> +	if (cqe_tx->send_status == CQ_TX_ERROP_TSTMP_TIMEOUT ||
> +	    cqe_tx->send_status == CQ_TX_ERROP_TSTMP_CONFLICT)
> +		goto no_tstamp;
> +
> +	/* Get the timestamp */
> +	memset(&ts, 0, sizeof(ts));
> +	ns = cavium_ptp_tstamp2time(nic->ptp_clock, cqe_tx->ptp_timestamp);
> +	ts.hwtstamp = ns_to_ktime(ns);
> +	skb_tstamp_tx(nic->ptp_skb, &ts);
> +
> +no_tstamp:
> +	/* Free the original skb */
> +	dev_kfree_skb_any(nic->ptp_skb);
> +	nic->ptp_skb = NULL;
> +	/* Sync 'ptp_skb' */
> +	smp_wmb();
> +}
> +

but here you set the one:

> @@ -657,7 +697,12 @@ static void nicvf_snd_pkt_handler(struct net_device *netdev,
>  		prefetch(skb);
>  		(*tx_pkts)++;
>  		*tx_bytes += skb->len;
> -		napi_consume_skb(skb, budget);
> +		/* If timestamp is requested for this skb, don't free it */
> +		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> +		    !nic->pnicvf->ptp_skb)
> +			nic->pnicvf->ptp_skb = skb;
> +		else
> +			napi_consume_skb(skb, budget);
>  		sq->skbuff[cqe_tx->sqe_ptr] = (u64)NULL;
>  	} else {
>  		/* In case of SW TSO on 88xx, only last segment will have

here you clear one:

> @@ -1319,12 +1382,28 @@ int nicvf_stop(struct net_device *netdev)
>  
>  	nicvf_free_cq_poll(nic);
>  
> +	/* Free any pending SKB saved to receive timestamp */
> +	if (nic->ptp_skb) {
> +		dev_kfree_skb_any(nic->ptp_skb);
> +		nic->ptp_skb = NULL;
> +	}
> +
>  	/* Clear multiqset info */
>  	nic->pnicvf = nic;
>  
>  	return 0;
>  }

here you clear both:

> @@ -1394,6 +1473,12 @@ int nicvf_open(struct net_device *netdev)
>  	if (nic->sqs_mode)
>  		nicvf_get_primary_vf_struct(nic);
>  
> +	/* Configure PTP timestamp */
> +	if (nic->ptp_clock)
> +		nicvf_config_hw_rx_tstamp(nic, nic->hw_rx_tstamp);
> +	atomic_set(&nic->tx_ptp_skbs, 0);
> +	nic->ptp_skb = NULL;
> +
>  	/* Configure receive side scaling and MTU */
>  	if (!nic->sqs_mode) {
>  		nicvf_rss_init(nic);

here you set the other:

> @@ -1385,6 +1388,29 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
>  		hdr->inner_l3_offset = skb_network_offset(skb) - 2;
>  		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
>  	}
> +
> +	/* Check if timestamp is requested */
> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> +		skb_tx_timestamp(skb);
> +		return;
> +	}
> +
> +	/* Tx timestamping not supported along with TSO, so ignore request */
> +	if (skb_shinfo(skb)->gso_size)
> +		return;
> +
> +	/* HW supports only a single outstanding packet to timestamp */
> +	if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
> +		return;
> +
> +	/* Mark the SKB for later reference */
> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +	/* Finally enable timestamp generation
> +	 * Since 'post_cqe' is also set, two CQEs will be posted
> +	 * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
> +	 */
> +	hdr->tstmp = 1;
>  }

and so it is completely non-obvious whether this is race free or not.

Thanks,
Richard
