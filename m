From: davem@davemloft.net (David Miller)
Date: Mon, 07 Mar 2016 11:30:54 -0500 (EST)
Subject: [PATCH V4 2/4] net-next: mediatek: add support for MT7623 ethernet
In-Reply-To: <1457340997-23116-3-git-send-email-blogic@openwrt.org>
References: <1457340997-23116-1-git-send-email-blogic@openwrt.org>
 <1457340997-23116-3-git-send-email-blogic@openwrt.org>
Message-ID: <20160307.113054.2069588355987832062.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <blogic@openwrt.org>
Date: Mon,  7 Mar 2016 09:56:35 +0100

> +static int mtk_mdio_busy_wait(struct mtk_eth *eth)
> +{
> +	unsigned long t_start = jiffies;
> +
> +	while (1) {
> +		if (!(mtk_r32(eth, MTK_PHY_IAC) & PHY_IAC_ACCESS))
> +			return 0;
> +		if (time_after(jiffies, t_start + PHY_IAC_TIMEOUT))
> +			break;
> +	}
> +
> +	dev_err(eth->dev, "mdio: MDIO timeout\n");
> +	return -1;
> +}

Busy polling in a loop for up to 5 seconds with no preemption points
is not something you can do, sorry.
