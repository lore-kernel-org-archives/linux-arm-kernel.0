From: davem@davemloft.net (David Miller)
Date: Mon, 16 Jun 2014 21:42:47 -0700 (PDT)
Subject: [PATCH v6 4/4] drivers: net: Add APM X-Gene SoC ethernet
 driver support.
In-Reply-To: <1402964326-11147-5-git-send-email-isubramanian@apm.com>
References: <1402964326-11147-1-git-send-email-isubramanian@apm.com>
 <1402964326-11147-5-git-send-email-isubramanian@apm.com>
Message-ID: <20140616.214247.1154200670003936158.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 16 Jun 2014 17:18:46 -0700

> +static netdev_tx_t xgene_enet_start_xmit(struct sk_buff *skb,
> +					 struct net_device *ndev)
> +{
> +	struct xgene_enet_pdata *pdata = netdev_priv(ndev);
> +	struct xgene_enet_desc_ring *tx_ring = pdata->tx_ring;
> +	struct xgene_enet_desc_ring *cp_ring = tx_ring->cp_ring;
> +	u32 tx_level, cq_level;
> +
> +	tx_level = xgene_enet_ring_len(tx_ring);
> +	cq_level = xgene_enet_ring_len(cp_ring);
> +	if (unlikely(tx_level > pdata->tx_qcnt_hi ||
> +		     cq_level > pdata->cp_qcnt_hi)) {
> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	if (xgene_enet_setup_tx_desc(tx_ring, skb))
> +		return NETDEV_TX_OK;

If you return NETDEV_TX_OK, it is your responsibility to deal with the
SKB, because you own it.

In particular, you have to free the packet.
