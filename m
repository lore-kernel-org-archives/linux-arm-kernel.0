From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 11 Jan 2010 14:05:32 +1300
Subject: [PATCH] ep93xx: define magic numbers for pll1 and pll2
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F622@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F622@mi8nycmail19.Mi8.com>
Message-ID: <4B4A795C.8000507@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Add defines for the pll register magic numbers that determine if
> the pll's are bypassed and if pll2 is enabled.  Rename the clock
> set registers to more closely match the datasheet.  Also, remove
> the unnecessary braces since each conditional statement is a single
> statement.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 1d0f9d8..f77c410 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -447,25 +447,29 @@ static int __init ep93xx_clock_init(void)
>  	u32 value;
>  	int i;
>  
> -	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET1);
> -	if (!(value & 0x00800000)) {			/* PLL1 bypassed?  */
> +	/* Determine the bootloader configured pll1 rate */
> +	value = __raw_readl(EP93XX_SYSCON_CLKSET1);
> +	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
>  		clk_pll1.rate = clk_xtali.rate;
> -	} else {
> +	else
>  		clk_pll1.rate = calc_pll_rate(value);
> -	}
> +
> +	/* Initialize the pll1 derived clocks */
>  	clk_f.rate = clk_pll1.rate / fclk_divisors[(value >> 25) & 0x7];
>  	clk_h.rate = clk_pll1.rate / hclk_divisors[(value >> 20) & 0x7];
>  	clk_p.rate = clk_h.rate / pclk_divisors[(value >> 18) & 0x3];
>  	ep93xx_dma_clock_init();
>  
> +	/* Determine the bootloader configured pll2 rate */
>  	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET2);
> -	if (!(value & 0x00080000)) {			/* PLL2 bypassed?  */
> +	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
>  		clk_pll2.rate = clk_xtali.rate;
> -	} else if (value & 0x00040000) {		/* PLL2 enabled?  */
> +	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
>  		clk_pll2.rate = calc_pll_rate(value);
> -	} else {
> +	else
>  		clk_pll2.rate = 0;
> -	}
> +
> +	/* Initialize the pll2 derived clocks */
>  	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
>  
>  	printk(KERN_INFO "ep93xx: PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index d55194a..cd35912 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -167,8 +167,11 @@
>  #define EP93XX_SYSCON_PWRCNT_DMA_M2P1	(1<<16)
>  #define EP93XX_SYSCON_HALT		EP93XX_SYSCON_REG(0x08)
>  #define EP93XX_SYSCON_STANDBY		EP93XX_SYSCON_REG(0x0c)
> -#define EP93XX_SYSCON_CLOCK_SET1	EP93XX_SYSCON_REG(0x20)
> -#define EP93XX_SYSCON_CLOCK_SET2	EP93XX_SYSCON_REG(0x24)
> +#define EP93XX_SYSCON_CLKSET1		EP93XX_SYSCON_REG(0x20)
> +#define EP93XX_SYSCON_CLKSET1_NBYP1	(1<<23)
> +#define EP93XX_SYSCON_CLKSET2		EP93XX_SYSCON_REG(0x24)
> +#define EP93XX_SYSCON_CLKSET2_NBYP2	(1<<19)
> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN	(1<<18)
>  #define EP93XX_SYSCON_DEVCFG		EP93XX_SYSCON_REG(0x80)
>  #define EP93XX_SYSCON_DEVCFG_SWRST	(1<<31)
>  #define EP93XX_SYSCON_DEVCFG_D1ONG	(1<<30) 

Looks okay. If the clock registers are only ever used inside clock.c
should we move them there to cut down the size of ep93xx-regs.h?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
