From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2018 21:26:51 +0200
Subject: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
In-Reply-To: <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180726192651.GK10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
> +{
> +	u32 val;
> +	u32 divisor;
> +
> +	if (md->core_clk) {
> +		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;

/**
 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 * 		  This is only valid once the clock source has been enabled.
 * @clk: clock source
 */
unsigned long clk_get_rate(struct clk *clk);

It is generally good practice to call clk_prepare_enable() sometime
before clk_get_rate() to ensure the clock is ticking, and to show this
driver is making use of the clock, so it does not get turned off.

> +		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
> +		val = divisor;
> +		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
> +		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
> +		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
> +	}
> +}
