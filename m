From: ra7055@freescale.com (Herring Robert-RA7055)
Date: Mon, 7 Dec 2009 11:06:14 -0700
Subject: [RFC][PATCH 03/10] arm: mxc: changes to common plat-mxc codeto
	add support for i.MX5
In-Reply-To: <20091204083451.GG15126@pengutronix.de>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<DE2504B3A515524BBE6934369EFDC0DA08C2A56C@az33exm20.fsl.freescale.net>
	<20091204083451.GG15126@pengutronix.de>
Message-ID: <DE2504B3A515524BBE6934369EFDC0DA08C2A8A7@az33exm20.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sasha,

> @@ -296,7 +299,7 @@ void __init mxc_timer_init(struct clk 
> *timer_clk, void __iomem *base, int irq)
>  	__raw_writel(0, timer_base + MXC_TCTL);
>  	__raw_writel(0, timer_base + MXC_TPRER); /* see 
> datasheet note */
>  
> -	if (cpu_is_mx3() || cpu_is_mx25())
> +	if (timer_is_v2())
>  		tctl_val = MX3_TCTL_CLK_IPG | MX3_TCTL_FRR | 
> MX3_TCTL_WAITEN | MXC_TCTL_TEN;

The timer clock input needs to be per_clk, not ipg_clk on MX51. It is
safe to always be set to per_clk because per_clk == ipg_clk on MX31/35
and MX27 IIRC. This makes the clock constant even with cpu and bus
scaling and allows disabling of PLLs.

#define MX3_TCTL_CLK_PER       (2 << 6)

       if (timer_is_v2())
               tctl_val = MX3_TCTL_CLK_PER | MX3_TCTL_FRR |
MX3_TCTL_WAITEN | MXC_TCTL_TEN;

Regards,
Rob
