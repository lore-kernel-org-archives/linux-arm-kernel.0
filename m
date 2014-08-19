From: jhs@mojatatu.com (Jamal Hadi Salim)
Date: Tue, 19 Aug 2014 07:38:55 -0400
Subject: [PATCH v2 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <1408115562-22487-3-git-send-email-santosh.shilimkar@ti.com>
References: <1408115562-22487-1-git-send-email-santosh.shilimkar@ti.com>
 <1408115562-22487-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <53F3374F.1000808@mojatatu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/14 11:12, Santosh Shilimkar wrote:


I am curious about these two calls below(netcp_process_one_rx_packet
and netcp_tx_submit_skb):
On tx you seem to be broadcasting to all "sub-modules" and on receive
you seem to be invoking from all as well.
I couldnt find the code for any of the sub-modules but i suspect
things like switching/bridging or ipsec etc could be sub-modules.
If yes, have you thought about integrating these features into
Linux proper instead?

cheers,
jamal

> +
> +static inline int netcp_process_one_rx_packet(struct netcp_intf *netcp)
> +{


> +
> +	/* Call each of the RX hooks */
> +	p_info.skb = skb;
> +	p_info.rxtstamp_complete = false;
> +	list_for_each_entry(rx_hook, &netcp->rxhook_list_head, list) {
> +		int ret;
> +
> +		ret = rx_hook->hook_rtn(rx_hook->order, rx_hook->hook_data,
> +					&p_info);
> +		if (unlikely(ret)) {
> +			dev_err(netcp->ndev_dev, "RX hook %d failed: %d\n",
> +				rx_hook->order, ret);
> +			netcp->ndev->stats.rx_errors++;
> +			dev_kfree_skb(skb);
> +			return 0;
> +		}
> +	}
..
....
> +	return 0;
> +}

[..]

> +static inline int netcp_tx_submit_skb(struct netcp_intf *netcp,
> +				      struct sk_buff *skb,
> +				      struct knav_dma_desc *desc)
> +{
> +	struct netcp_tx_pipe *tx_pipe = NULL;

> +
> +	p_info.netcp = netcp;
> +	p_info.skb = skb;
> +	p_info.tx_pipe = NULL;
> +	p_info.psdata_len = 0;
> +	p_info.ts_context = NULL;
> +	p_info.txtstamp_complete = NULL;
> +	p_info.epib = desc->epib;
> +	p_info.psdata = desc->psdata;
> +	memset(p_info.epib, 0, KNAV_DMA_NUM_EPIB_WORDS * sizeof(u32));
> +
> +	/* Find out where to inject the packet for transmission */
> +	list_for_each_entry(tx_hook, &netcp->txhook_list_head, list) {
> +		ret = tx_hook->hook_rtn(tx_hook->order, tx_hook->hook_data,
> +					&p_info);
> +		if (unlikely(ret != 0)) {
> +			dev_err(netcp->ndev_dev, "TX hook %d rejected the packet with reason(%d)\n",
> +				tx_hook->order, ret);
> +			ret = (ret < 0) ? ret : NETDEV_TX_OK;
> +			goto out;
> +		}
> +	}
> +
