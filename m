From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Sep 2013 10:47:16 +0800
Subject: [PATCH] ARM: imx: i.mx6d/q: disable the double linefill feature
 of PL310
In-Reply-To: <1379058532-19843-1-git-send-email-r64343@freescale.com>
References: <1379058532-19843-1-git-send-email-r64343@freescale.com>
Message-ID: <20130916024714.GE31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Fri, Sep 13, 2013 at 03:48:52PM +0800, Jason Liu wrote:
> @@ -116,7 +116,18 @@ void __init imx_init_l2cache(void)
>  
>  	/* Configure the L2 PREFETCH and POWER registers */
>  	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
> -	val |= 0x70800000;
> +	val |= 0x30000000;
> +	/*
> +	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
> +	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
> +	 * But according to ARM PL310 errata: 752271
> +	 * ID: 752271: Double linefill feature can cause data corruption
> +	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
> +	 * Workaround: The only workaround to this erratum is to disable the
> +	 * double linefill feature. This is the default behavior.
> +	 */
> +	if (!of_machine_is_compatible("fsl,imx6q"))

Can we use cpu_is_imx6q() here?  I think we may not want to look at
device tree, if the kernel can figure this out by itself.

Shawn

> +		val |= 0x40800000;
>  	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
>  	val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
>  	writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);
> -- 
> 1.7.10.4
> 
> 
