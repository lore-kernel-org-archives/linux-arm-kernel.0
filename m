From: davem@davemloft.net (David Miller)
Date: Mon, 07 Apr 2014 14:53:56 -0400 (EDT)
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1396672506-9296-4-git-send-email-zhangfei.gao@linaro.org>
References: <1396672506-9296-1-git-send-email-zhangfei.gao@linaro.org>
 <1396672506-9296-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140407.145356.928382660541891827.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat,  5 Apr 2014 12:35:06 +0800

> +struct tx_desc {
> +	u32 send_addr;
> +	u16 reserved_16;
> +	u16 send_size;
> +	u32 reserved_32;
> +	u32 cfg;
> +	u32 wb_addr;
> +} ____cacheline_aligned;

I do not think that ____cacheline_aligned is appropriate at all here.

First of all, this is a hardware descriptor, so it has a fixed layout
and therefore size.

Secondly, unless you declare this object statically in the data section
of the object file, the alignment doesn't matter.  These descriptors
are always dynamically allocated, rather than instantiated in the
kernel/driver image.

> +	val = (duplex) ? BIT(0) : 0;

Parenthesis around duplex is not necessary, please remove.

> +static void hip04_reset_ppe(struct hip04_priv *priv)
> +{
> +	u32 val, tmp;
> +
> +	do {
> +		regmap_read(priv->map, priv->port * 4 + PPE_CURR_BUF_CNT, &val);
> +		regmap_read(priv->map, priv->port * 4 + PPE_CFG_RX_ADDR, &tmp);
> +	} while (val & 0xfff);
> +}

This polling loop can loop forever, if the condition never triggers it will
loop forever.  You must add some kind of limit or timeout, and subsequent
error handing up the call chain to handle this.

> +	val = readl_relaxed(priv->base + PPE_CFG_STS_MODE);
> +	val |= BIT(12);			/* PPE_HIS_RX_PKT_CNT read clear */
> +	writel_relaxed(val, priv->base + PPE_CFG_STS_MODE);
 ...
> +	/* set bus ctrl */
> +	val = BIT(14);			/* buffer locally release */
> +	val |= BIT(0);			/* big endian */
> +	writel_relaxed(val, priv->base + PPE_CFG_BUS_CTRL_REG);

Instead of having to set only one bit at a time in every register and
adding comments here, just define these register values using macros
properly in a header file or similar.

Then you can go val |= PPE_CFG_BUS_CTRL_VAL_THIS | PPE_CFG_BUS_CTRL_VAL_THAT
on one line.

Document the registers where you define the macros, that way people can learn
what other bits are in these register and what they mean, even if you don't
currently use them in the driver itself.

> +static void hip04_tx_reclaim(struct net_device *ndev, bool force)
 ...
> +static void hip04_xmit_timer(unsigned long data)
> +{
> +	struct net_device *ndev = (void *) data;
> +
> +	hip04_tx_reclaim(ndev, false);
> +}
 ...
> +	mod_timer(&priv->txtimer, jiffies + RECLAIM_PERIOD);

And this is where I stop reading your driver, I've stated already that this
kind of reclaim scheme is unacceptable.

The kernel timers lack the granularity necessary to service TX reclaim
with a reasonable amount of latency.

You must use some kind of hardware notification of TX slots becomming
available, I find it totally impossible that a modern ethernet controller
was created without a TX done interrupt.
