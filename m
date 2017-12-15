From: davem@davemloft.net (David Miller)
Date: Fri, 15 Dec 2017 12:57:49 -0500 (EST)
Subject: [PATCH net-next v6 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <1513245910-15961-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1513245910-15961-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1513245910-15961-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20171215.125749.1752831437819486183.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Thu, 14 Dec 2017 19:05:10 +0900

> +static void ave_desc_write(struct net_device *ndev, enum desc_id id,
> +			   int entry, int offset, u32 val)
> +{
> +	struct ave_private *priv = netdev_priv(ndev);
> +	u32 addr = (id == AVE_DESCID_TX) ? priv->tx.daddr : priv->rx.daddr;

Please always order local variables from longest to shortest line.

Audit your entire submission for this issue, thank you.

> +	ret = register_netdev(ndev);
> +	if (ret) {
> +		dev_err(dev, "failed to register netdevice\n");
> +		goto out_del_napi;
> +	}
> +
> +	platform_set_drvdata(pdev, ndev);

You must make all software state settings before reigster_netdev() is
invoked.

At the exact moment you call register_netdev(), your device can be
brought up, interrupts processed, PHY state changes made, etc.

So you must put this platform_set_drvdata() before the
register_netdev() call.

Generally speaking, register_netdev() must always be the last state
modification done by your probe routine.
