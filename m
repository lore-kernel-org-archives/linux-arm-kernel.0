From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 07 Nov 2013 00:56:25 +0100
Subject: [PATCH/RFC] clk: shmobile: DT property SoC <-> CCF interface
 prototype
In-Reply-To: <20131106233952.8558.85734.sendpatchset@w520>
References: <20131106233952.8558.85734.sendpatchset@w520>
Message-ID: <461263883.GeF0HFra2n@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Thursday 07 November 2013 08:39:52 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Prototype patch to use a DT property to pass "CPG mode"
> (clock device boot time hardware configuration) from
> SoC code in arch/arm/ to CCF bits in drivers/clk/
> 
> Applies on top of the r8a7790 CCF code by Laurent.
> Mainly written to show how a property can be used
> instead of introducing a custom symbol dependency.
> 
> The SoC specific code needs to use of_update_property()
> to setup this DT property after reading out the boot
> mode from hardware during boot.

The interesting part would be the SoC specific code :-)

As I mentioned in my previous e-mail this feels like a bit of a DT abuse to 
me, but let's hear what Grant and Mike think about it.

(To help the reader, the reference e-mail thread can be found at 
http://www.spinics.net/lists/arm-kernel/msg284629.html)

> Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/clk/shmobile/clk-r8a7790.c |   15 ++++++---------
>  include/linux/clk/shmobile.h       |   19 -------------------
>  2 files changed, 6 insertions(+), 28 deletions(-)
> 
> --- 0018/drivers/clk/shmobile/clk-r8a7790.c
> +++ work/drivers/clk/shmobile/clk-r8a7790.c	2013-11-06 17:28:36.000000000
> +0900 @@ -12,7 +12,6 @@
> 
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
> -#include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -70,8 +69,6 @@ static const struct clk_div_table cpg_sd
>  	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
>  };
> 
> -static u32 cpg_mode __initdata;
> -
>  #define CPG_SDCKCR			0x00000074
> 
>  static void __init r8a7790_cpg_clocks_init(struct device_node *np)
> @@ -80,6 +77,12 @@ static void __init r8a7790_cpg_clocks_in
>  	struct r8a7790_cpg *cpg;
>  	struct clk **clks;
>  	unsigned int i;
> +	u32 cpg_mode;
> +
> +	if (of_property_read_u32(np, "cpg-mode", &cpg_mode)) {
> +		pr_err("%s: failed to determine CPG mode\n", __func__);
> +		return;
> +	}
> 
>  	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
>  	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> @@ -168,9 +171,3 @@ static void __init r8a7790_cpg_clocks_in
>  CLK_OF_DECLARE(r8a7790_cpg_clks, "renesas,r8a7790-cpg-clocks",
>  	       r8a7790_cpg_clocks_init);
> 
> -void __init r8a7790_clocks_init(u32 mode)
> -{
> -	cpg_mode = mode;
> -
> -	of_clk_init(NULL);
> -}
> --- 0018/include/linux/clk/shmobile.h
> +++ /dev/null	2013-06-03 21:41:10.638032047 +0900
> @@ -1,19 +0,0 @@
> -/*
> - * Copyright 2013 Ideas On Board SPRL
> - *
> - * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#ifndef __LINUX_CLK_SHMOBILE_H_
> -#define __LINUX_CLK_SHMOBILE_H_
> -
> -#include <linux/types.h>
> -
> -void r8a7790_clocks_init(u32 mode);
> -
> -#endif
-- 
Regards,

Laurent Pinchart
