From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 2 Jun 2011 15:09:11 +0100
Subject: [PATCH] arm: vexpress: move v2m clock init to init_early
In-Reply-To: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
References: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110602140904.GA2156@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 05:30:53PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Commit 7ff550de99141cbd3be0129d563cc4554fdde9f6 breaks vexpress booting. The
> v2m clock table needs to be setup in init_early before the timer
> initialization occurs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-vexpress/v2m.c |   15 +++++++--------
>  include/linux/libata.h       |    4 ++--
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 9d9d4af..cded33c 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -46,12 +46,6 @@ static struct map_desc v2m_io_desc[] __initdata = {
>  	},
>  };
>  
> -static void __init v2m_init_early(void)
> -{
> -	ct_desc->init_early();
> -	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
> -}
> -
>  static void __init v2m_timer_init(void)
>  {
>  	u32 scctrl;
> @@ -379,6 +373,13 @@ static struct clk_lookup v2m_lookups[] = {
>  	},
>  };
>  
> +static void __init v2m_init_early(void)
> +{
> +	ct_desc->init_early();
> +	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
> +	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
> +}
> +
>  static void v2m_power_off(void)
>  {
>  	if (v2m_cfg_write(SYS_CFG_SHUTDOWN | SYS_CFG_SITE_MB, 0))
> @@ -432,8 +433,6 @@ static void __init v2m_init(void)
>  {
>  	int i;
>  
> -	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
> -
>  	platform_device_register(&v2m_pcie_i2c_device);
>  	platform_device_register(&v2m_ddc_i2c_device);
>  	platform_device_register(&v2m_flash_device);

Disregarding the libata stuff, 

Tested-by: Dave Martin <dave.martin@linaro.org>

Cheers
---Dave

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 04f32a3..df6af22 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -53,8 +53,8 @@
>   * compile-time options: to be removed as soon as all the drivers are
>   * converted to the new debugging mechanism
>   */
> -#undef ATA_DEBUG		/* debugging output */
> -#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
> +#define ATA_DEBUG		/* debugging output */
> +#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
>  #undef ATA_NDEBUG		/* define to disable quick runtime checks */
>  
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
