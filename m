From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Nov 2010 17:36:46 +0100
Subject: [PATCH 03/11] ARM: imx: Add reset routine for i.MX28
In-Reply-To: <1289831795-4373-4-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101115163646.GK8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:36:27PM +0800, Shawn Guo wrote:
> 1. The wdog reset is implemented in RTC block on MX28.
> 2. Implement the common reset routine for most blocks on MX28,
>    so that the blocks can call it to get a software reset.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/plat-mxc/system.c |  104 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 101 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> index c3972c5..257b426 100644
> --- a/arch/arm/plat-mxc/system.c
> +++ b/arch/arm/plat-mxc/system.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (C) 1999 ARM Limited
>   * Copyright (C) 2000 Deep Blue Solutions Ltd
> - * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2006-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
>   * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
>   *
> @@ -36,6 +36,7 @@ static void __iomem *wdog_base;
>  void arch_reset(char mode, const char *cmd)
>  {
>  	unsigned int wcr_enable;
> +	struct clk *clk;
>  
>  #ifdef CONFIG_ARCH_MXC91231
>  	if (cpu_is_mxc91231()) {
> @@ -52,9 +53,18 @@ void arch_reset(char mode, const char *cmd)
>  
>  	if (cpu_is_mx1()) {
>  		wcr_enable = (1 << 0);
> -	} else {
> -		struct clk *clk;
> +	} else if (cpu_is_mx28()) {
> +		clk = clk_get_sys("rtc", NULL);
> +		if (!IS_ERR(clk))
> +			clk_enable(clk);
>  
> +		/* set wdog count */
> +		__raw_writel(1, wdog_base + 0x50);
> +		/* wdog enbable bit */
s/enbable/enable/

> +		wcr_enable = (1 << 4);
> +		/* shift to SET address */
> +		wdog_base += 0x4;
> +	} else {
>  		clk = clk_get_sys("imx-wdt.0", NULL);
>  		if (!IS_ERR(clk))
>  			clk_enable(clk);
> @@ -80,3 +90,91 @@ void mxc_arch_reset_init(void __iomem *base)
>  {
>  	wdog_base = base;
>  }
> +
> +#ifdef CONFIG_ARCH_MX28
> +int mxc_reset_block(void __iomem *reg_addr)
> +{
> +	u32 reg;
> +	int timeout;
> +
> +	/*
> +	 * The process of software reset of IP block is done
> +	 * in several steps:
> +	 *
> +	 * 1) clear SFTRST and wait it cleared;
> +	 * 2) clear CLKGATE, set SFTRST, wait CLKGATE set;
> +	 * 3) clear SFTRST and wait it cleared;
> +	 * 4) clear CLKGATE and wait it cleared.
> +	 */
> +
> +	/* Clear SFTRST */
> +	reg = __raw_readl(reg_addr);
> +	reg &= ~(1 << 31);
> +	__raw_writel(reg, reg_addr);
> +	/* Wait SFTRST cleared */
> +	timeout = 1000;
> +	do {
> +		mdelay(1);
> +		if ((__raw_readl(reg_addr) & (1 << 31)) == 0)
> +			break;
> +	} while (--timeout > 0);
Does the mdelay make sence here?

> +	if (timeout <= 0) {
> +		pr_err("%s(%p): clear SFTRST timeout\n", __func__, reg_addr);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Clear CLKGATE */
> +	reg = __raw_readl(reg_addr);
> +	reg &= ~(1 << 30);
> +	__raw_writel(reg, reg_addr);
> +	/* Set SFTRST to reset the block */
> +	reg = __raw_readl(reg_addr);
> +	reg |= (1 << 31);
Can we have #defines here instead of constants?

> +	__raw_writel(reg, reg_addr);
> +	/* Poll CLKGATE set */
> +	timeout = 1000;
> +	do {
> +		mdelay(1);
> +		if (__raw_readl(reg_addr) & (1 << 30))
> +			break;
> +	} while (--timeout > 0);
> +	if (timeout <= 0) {
> +		pr_err("%s(%p): poll CLKGATE timeout\n", __func__, reg_addr);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Clear SFTRST */
> +	reg = __raw_readl(reg_addr);
> +	reg &= ~(1 << 31);
> +	__raw_writel(reg, reg_addr);
> +	/* Wait SFTRST cleared */
> +	timeout = 1000;
> +	do {
> +		mdelay(1);
> +		if ((__raw_readl(reg_addr) & (1 << 31)) == 0)
> +			break;
> +	} while (--timeout > 0);
> +	if (timeout <= 0) {
> +		pr_err("%s(%p): clear SFTRST timeout\n", __func__, reg_addr);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Clear CLKGATE */
> +	reg = __raw_readl(reg_addr);
> +	reg &= ~(1 << 30);
> +	__raw_writel(reg, reg_addr);
> +	/* Wait CLKGATE cleared */
> +	timeout = 1000;
> +	do {
> +		mdelay(1);
> +		if ((__raw_readl(reg_addr) & (1 << 30)) == 0)
> +			break;
> +	} while (--timeout > 0);
> +	if (timeout <= 0) {
> +		pr_err("%s(%p): clear CLKGATE timeout\n", __func__, reg_addr);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +#endif
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
