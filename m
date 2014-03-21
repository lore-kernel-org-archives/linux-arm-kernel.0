From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:27:26 +0100
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1395414570-25515-4-git-send-email-zhangfei.gao@linaro.org>
References: <1395414570-25515-1-git-send-email-zhangfei.gao@linaro.org>
 <1395414570-25515-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <4230433.d0bAGX3bJV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 23:09:30 Zhangfei Gao wrote:

> +
> +static void __iomem *ppebase;

Any reason why you still have this, rather than using a separate
driver for it as we discussed? If you have comments that you still
plan to address, please mention those in the introductory mail,
so you don't get the same review comments multiple times.


> +static void hip04_tx_reclaim(struct net_device *ndev, bool force)
> +{
> +	struct hip04_priv *priv = netdev_priv(ndev);
> +	unsigned tx_head = priv->tx_head;
> +	unsigned tx_tail = priv->tx_tail;
> +	struct tx_desc *desc = &priv->tx_desc[priv->tx_tail];
> +
> +	while (tx_tail != tx_head) {
> +		if (desc->send_addr != 0) {
> +			if (force)
> +				desc->send_addr = 0;
> +			else
> +				break;
> +		}
> +		if (priv->tx_phys[tx_tail]) {
> +			dma_unmap_single(&ndev->dev, priv->tx_phys[tx_tail],
> +				priv->tx_skb[tx_tail]->len, DMA_TO_DEVICE);
> +			priv->tx_phys[tx_tail] = 0;
> +		}
> +		dev_kfree_skb_irq(priv->tx_skb[tx_tail]);
> +		priv->tx_skb[tx_tail] = NULL;
> +		tx_tail = TX_NEXT(tx_tail);
> +		priv->tx_count--;
> +	}
> +	priv->tx_tail = tx_tail;
> +}

You call this function from start_xmit(), which may be too early, causing the
dma_unmap_single() and dev_kfree_skb_irq() functions to be called while the
device is still accessing the data. This is bad.

You have to ensure that you only ever clean up tx buffers that have been
successfully transmitted. Also, you should use an interrupt to notify you
of this in case there is no further xmit packet. Otherwise you may have
a user space program waiting indefinitely for a single packet to get sent
on a socket.

It's ok to also call the cleanup from start_xmit, but calling it from the
poll() function or another appropriate place is required.

> +	priv->id = of_alias_get_id(node, "ethernet");
> +	if (priv->id < 0) {
> +		dev_warn(d, "no ethernet alias\n");
> +		ret = -EINVAL;
> +		goto init_fail;
> +	}

Apparently you try to rely on the alias to refer to a specific piece
of hardware, which is not correct. The alias is meant to be selectable
to match e.g. the numbering written on the external connector, which
is totally independent of the internal hardware.

	Arnd
