From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Mon, 8 Jan 2018 23:12:10 +0600
Subject: [PATCH net-next v5 2/2] net: thunderx: add timestamping support
In-Reply-To: <20171211233220.d72rys7nci4lqqd5@localhost>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-3-aleksey.makarov@cavium.com>
 <20171211233220.d72rys7nci4lqqd5@localhost>
Message-ID: <94d493c9-33db-262a-269f-6ff425dd5519@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.12.2017 05:32, Richard Cochran wrote:
> On Mon, Dec 11, 2017 at 05:14:31PM +0300, Aleksey Makarov wrote:
>> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
>> index 4a02e618e318..204b234beb9d 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nic.h
>> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
>> @@ -263,6 +263,8 @@ struct nicvf_drv_stats {
>>  	struct u64_stats_sync   syncp;
>>  };
>>  
>> +struct cavium_ptp;
>> +
>>  struct nicvf {
>>  	struct nicvf		*pnicvf;
>>  	struct net_device	*netdev;
>> @@ -312,6 +314,12 @@ struct nicvf {
>>  	struct tasklet_struct	qs_err_task;
>>  	struct work_struct	reset_task;
>>  
>> +	/* PTP timestamp */
>> +	struct cavium_ptp	*ptp_clock;
>> +	bool			hw_rx_tstamp;
>> +	struct sk_buff		*ptp_skb;
>> +	atomic_t		tx_ptp_skbs;
> 
> It is disturbing that the above two fields are set in different
> places.  Shouldn't they be unified into one logical lock?

No, they should not as they are not quite related.

`tx_ptp_skbs` is set when the hardware is sending a packet that requires
timestamping.  Cavium hardware can not process more than one
such packet at once so this is set each time the driver submits
a packet that requires timestamping to the send queue and clears
each time it receives the entry on the completion queue saying
that such packet was sent.

So `tx_ptp_skbs` prevents driver from submitting more than one
packet that requires timestamping to the hardware for transmitting.

When that packet is sent, hardware inserts two entries to
the completion queue.  First is the regular CQE_TYPE_SEND entry
that signals that the packet was sent.  The second is CQE_TYPE_SEND_PTP
that contains the actual timestamp for that packet.

`ptp_skb` is initialized in the handler for the CQE_TYPE_SEND
entry and is used and zeroed in the handler for the CQE_TYPE_SEND_PTP
entry.

So `ptp_skb` is used to hold the pointer to the packet between
the calls to CQE_TYPE_SEND and CQE_TYPE_SEND_PTP handlers.

I am going to add those comments to the sources, fix other issues and
send v6 in short time.

Thank you
Aleksey Makarov

> Here you clear them together:
> 
>> +static void nicvf_snd_ptp_handler(struct net_device *netdev,
>> +				  struct cqe_send_t *cqe_tx)
>> +{
>> +	struct nicvf *nic = netdev_priv(netdev);
>> +	struct skb_shared_hwtstamps ts;
>> +	u64 ns;
>> +
>> +	nic = nic->pnicvf;
>> +
>> +	/* Sync for 'ptp_skb' */
>> +	smp_rmb();
>> +
>> +	/* New timestamp request can be queued now */
>> +	atomic_set(&nic->tx_ptp_skbs, 0);
>> +
>> +	/* Check for timestamp requested skb */
>> +	if (!nic->ptp_skb)
>> +		return;
>> +
>> +	/* Check if timestamping is timedout, which is set to 10us */
>> +	if (cqe_tx->send_status == CQ_TX_ERROP_TSTMP_TIMEOUT ||
>> +	    cqe_tx->send_status == CQ_TX_ERROP_TSTMP_CONFLICT)
>> +		goto no_tstamp;
>> +
>> +	/* Get the timestamp */
>> +	memset(&ts, 0, sizeof(ts));
>> +	ns = cavium_ptp_tstamp2time(nic->ptp_clock, cqe_tx->ptp_timestamp);
>> +	ts.hwtstamp = ns_to_ktime(ns);
>> +	skb_tstamp_tx(nic->ptp_skb, &ts);
>> +
>> +no_tstamp:
>> +	/* Free the original skb */
>> +	dev_kfree_skb_any(nic->ptp_skb);
>> +	nic->ptp_skb = NULL;
>> +	/* Sync 'ptp_skb' */
>> +	smp_wmb();
>> +}
>> +
> 
> but here you set the one:
> 
>> @@ -657,7 +697,12 @@ static void nicvf_snd_pkt_handler(struct net_device *netdev,
>>  		prefetch(skb);
>>  		(*tx_pkts)++;
>>  		*tx_bytes += skb->len;
>> -		napi_consume_skb(skb, budget);
>> +		/* If timestamp is requested for this skb, don't free it */
>> +		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
>> +		    !nic->pnicvf->ptp_skb)
>> +			nic->pnicvf->ptp_skb = skb;
>> +		else
>> +			napi_consume_skb(skb, budget);
>>  		sq->skbuff[cqe_tx->sqe_ptr] = (u64)NULL;
>>  	} else {
>>  		/* In case of SW TSO on 88xx, only last segment will have
> 
> here you clear one:
> 
>> @@ -1319,12 +1382,28 @@ int nicvf_stop(struct net_device *netdev)
>>  
>>  	nicvf_free_cq_poll(nic);
>>  
>> +	/* Free any pending SKB saved to receive timestamp */
>> +	if (nic->ptp_skb) {
>> +		dev_kfree_skb_any(nic->ptp_skb);
>> +		nic->ptp_skb = NULL;
>> +	}
>> +
>>  	/* Clear multiqset info */
>>  	nic->pnicvf = nic;
>>  
>>  	return 0;
>>  }
> 
> here you clear both:
> 
>> @@ -1394,6 +1473,12 @@ int nicvf_open(struct net_device *netdev)
>>  	if (nic->sqs_mode)
>>  		nicvf_get_primary_vf_struct(nic);
>>  
>> +	/* Configure PTP timestamp */
>> +	if (nic->ptp_clock)
>> +		nicvf_config_hw_rx_tstamp(nic, nic->hw_rx_tstamp);
>> +	atomic_set(&nic->tx_ptp_skbs, 0);
>> +	nic->ptp_skb = NULL;
>> +
>>  	/* Configure receive side scaling and MTU */
>>  	if (!nic->sqs_mode) {
>>  		nicvf_rss_init(nic);
> 
> here you set the other:
> 
>> @@ -1385,6 +1388,29 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
>>  		hdr->inner_l3_offset = skb_network_offset(skb) - 2;
>>  		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
>>  	}
>> +
>> +	/* Check if timestamp is requested */
>> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>> +		skb_tx_timestamp(skb);
>> +		return;
>> +	}
>> +
>> +	/* Tx timestamping not supported along with TSO, so ignore request */
>> +	if (skb_shinfo(skb)->gso_size)
>> +		return;
>> +
>> +	/* HW supports only a single outstanding packet to timestamp */
>> +	if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
>> +		return;
>> +
>> +	/* Mark the SKB for later reference */
>> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>> +
>> +	/* Finally enable timestamp generation
>> +	 * Since 'post_cqe' is also set, two CQEs will be posted
>> +	 * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
>> +	 */
>> +	hdr->tstmp = 1;
>>  }
> 
> and so it is completely non-obvious whether this is race free or not.
> 
> Thanks,
> Richard
> 
