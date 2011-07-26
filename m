From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jul 2011 09:50:59 +0200
Subject: [patch 2/3] imx51: add pata clock
In-Reply-To: <20110724184012.416899531@rtp-net.org>
References: <20110724183901.988974144@rtp-net.org>
	<20110724184012.416899531@rtp-net.org>
Message-ID: <20110726075059.GK20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 24, 2011 at 08:39:04PM +0200, Arnaud Patard wrote:
> Define the clock used by the imx51 pata device.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> 
> Index: linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/clock-mx51-mx53.c	2011-07-22 23:29:09.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c	2011-07-24 20:35:17.000000000 +0200
> @@ -1414,6 +1414,10 @@ DEFINE_CLOCK(ipu_di0_clk, 0, MXC_CCM_CCG
>  DEFINE_CLOCK(ipu_di1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG6_OFFSET,
>  		NULL, NULL, &pll3_sw_clk, NULL);
>  
> +/* PATA */
> +DEFINE_CLOCK(pata_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG0_OFFSET,
> +		NULL, NULL, &ipg_clk, &spba_clk);
> +
>  #define _REGISTER_CLOCK(d, n, c) \
>         { \
>  		.dev_id = d, \
> @@ -1466,6 +1470,7 @@ static struct clk_lookup mx51_lookups[]
>  	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
>  	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
>  	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
> +	_REGISTER_CLOCK("imx-pata", NULL, pata_clk)

First argument to _REGISTER_CLOCK must match the device name, but the
driver you posted uses pata_imx as device name. The second argument
which you correctly set to NULL here is an additional identifier which
must match if it exists. There is only one clock in the pata driver, so
you should use clk_get(&pdev->dev, NULL) in you driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
