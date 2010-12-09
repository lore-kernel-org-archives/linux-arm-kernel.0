From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:41:46 +0100
Subject: [PATCH v2 09/15] ARM: mxs: Add clock support
In-Reply-To: <1291739523-25077-8-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-8-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101209084146.GP17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> +static unsigned long name##_get_rate(struct clk *clk)			\
> +{									\
> +	unsigned long parent_rate;					\
> +	u32 reg, div;							\
> +									\
> +	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##sr);		\
> +	div = (reg >> BP_CLKCTRL_##sr##_##ss##FRAC) & 0x3f;		\
> +	parent_rate = clk_get_rate(clk->parent);			\
> +									\
> +	return parent_rate / 1000 * 18 / div * 1000;			\
> +}
1000 isn't the most clever choice.  It might be for a human, but not for
a machine.

I'd suggest (untested):

	return SH_DIV((parent_rate >> 8) * 18, div, 8);

(don't know if 8 is a good value).  What is the range of div here?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
