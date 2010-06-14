From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 14 Jun 2010 10:51:13 +0530
Subject: [PATCH 3/5] SPEAr3xx: Rework pmx_dev code to remove conflicts
In-Reply-To: <1275717955-14545-4-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-4-git-send-email-ryan@bluewatersys.com>
Message-ID: <4C15BC49.5040105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2010 11:35 AM, Ryan Mallon wrote:
> Prefix the pmx_devs to remove naming conflicts between the three
> SPEAr3xx platforms. Also make pmx_driver static to each platform and
> rework the init code to pass the devices rather than export the
> pmx_driver structure.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>  arch/arm/mach-spear3xx/include/mach/generic.h |  135 ++++++++++++-------------
>  arch/arm/mach-spear3xx/spear300.c             |   39 ++++----
>  arch/arm/mach-spear3xx/spear300_evb.c         |   26 ++---
>  arch/arm/mach-spear3xx/spear310.c             |   29 +++---
>  arch/arm/mach-spear3xx/spear310_evb.c         |   42 ++++-----
>  arch/arm/mach-spear3xx/spear320.c             |   57 ++++++-----
>  arch/arm/mach-spear3xx/spear320_evb.c         |   36 +++----
>  arch/arm/mach-spear3xx/spear3xx.c             |   60 ++++++------
>  8 files changed, 202 insertions(+), 222 deletions(-)
> 
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index 48dfb9c..408d39f 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -60,21 +60,21 @@ void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size);
>  #define PMX_TIMER_1_2_MASK	(1 << 0)
>  
>  /* pad mux devices */
> -extern struct pmx_dev pmx_firda;
> -extern struct pmx_dev pmx_i2c;
> -extern struct pmx_dev pmx_ssp_cs;
> -extern struct pmx_dev pmx_ssp;
> -extern struct pmx_dev pmx_mii;
> -extern struct pmx_dev pmx_gpio_pin0;
> -extern struct pmx_dev pmx_gpio_pin1;
> -extern struct pmx_dev pmx_gpio_pin2;
> -extern struct pmx_dev pmx_gpio_pin3;
> -extern struct pmx_dev pmx_gpio_pin4;
> -extern struct pmx_dev pmx_gpio_pin5;
> -extern struct pmx_dev pmx_uart0_modem;
> -extern struct pmx_dev pmx_uart0;
> -extern struct pmx_dev pmx_timer_3_4;
> -extern struct pmx_dev pmx_timer_1_2;
> +extern struct pmx_dev spear3xx_pmx_firda;
> +extern struct pmx_dev spear3xx_pmx_i2c;
> +extern struct pmx_dev spear3xx_pmx_ssp_cs;
> +extern struct pmx_dev spear3xx_pmx_ssp;
> +extern struct pmx_dev spear3xx_pmx_mii;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin0;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin1;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin2;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin3;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin4;
> +extern struct pmx_dev spear3xx_pmx_gpio_pin5;
> +extern struct pmx_dev spear3xx_pmx_uart0_modem;
> +extern struct pmx_dev spear3xx_pmx_uart0;
> +extern struct pmx_dev spear3xx_pmx_timer_3_4;
> +extern struct pmx_dev spear3xx_pmx_timer_1_2;
>  

same here. I don't understand why any conflicts will be there.

[snip...]

>  
>  /* pmx driver structure */
> -struct pmx_driver pmx_driver = {
> +static struct pmx_driver pmx_driver = {
>  	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x00000007},
>  	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
>  };
> @@ -511,7 +511,8 @@ static struct spear_shirq shirq_intrcomm_ras = {
>  };
>  
>  /* spear320 routines */
> -void __init spear320_init(void)
> +void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
> +			  u8 pmx_dev_count)
>  {
>  	void __iomem *base;
>  	int ret = 0;
> @@ -540,10 +541,10 @@ void __init spear320_init(void)
>  		if (ret)
>  			printk(KERN_ERR "Error registering Shared IRQ 4\n");
>  	}
> -}
>  
> -void spear320_pmx_init(void)
> -{
> +	pmx_driver.mode = pmx_mode;
> +	pmx_driver.devs = pmx_devs;
> +	pmx_driver.devs_count = pmx_dev_count;
>  	spear_pmx_init(&pmx_driver, SPEAR320_SOC_CONFIG_BASE,
> -			SPEAR320_SOC_CONFIG_SIZE);
> +		       SPEAR320_SOC_CONFIG_SIZE);
>  }

This part looks fine.

> diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
> index 62ac685..4969fa9 100644
> --- a/arch/arm/mach-spear3xx/spear320_evb.c
> +++ b/arch/arm/mach-spear3xx/spear320_evb.c
> @@ -19,22 +19,22 @@
>  
>  static struct amba_device *amba_devs[] __initdata = {
> @@ -56,13 +56,7 @@ static void __init spear320_evb_init(void)
>  	unsigned int i;
>  
>  	/* call spear320 machine init function */
> -	spear320_init();
> -
> -	/* padmux initialization */
> -	pmx_driver.mode = &auto_net_mii_mode;
> -	pmx_driver.devs = pmx_devs;
> -	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
> -	spear320_pmx_init();
> +	spear320_init(&auto_net_mii_mode, pmx_devs, ARRAY_SIZE(pmx_devs));

this is also fine.
