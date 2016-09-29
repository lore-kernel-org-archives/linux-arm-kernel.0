From: karl.beldan@gmail.com (Karl Beldan)
Date: Thu, 29 Sep 2016 19:07:36 +0000
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20160929190736.vgd3xylzm2nh32l4@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 29, 2016 at 06:31:55PM +0200, Bartosz Golaszewski wrote:
> Default memory settings of da850 do not meet the throughput/latency
> requirements of tilcdc. This results in the image displayed being
> incorrect and the following warning being displayed by the LCDC
> drm driver:
> 
>   tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000020): FIFO underfow
> 
> Reconfigure the LCDC priority to the highest. This is a workaround
> for the da850-lcdk board which has the LCD controller enabled in
> the device tree, but a long-term, system-wide fix is needed for
> all davinci boards.
> 
> This patch has been modified for mainline linux. It comes from a
> downstream TI release for da850[1].
> 
> Original author: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> 
> [1] http://arago-project.org/git/projects/linux-davinci.git?p=projects/linux-davinci.git;a=commitdiff;h=b9bd39a34cc02c3ba2fc15539a2f0bc2b68d25da;hp=6f6c795faa6366a4ebc1037a0235edba6018a991
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

FWIW, the quirks could be applied conditionnally depending on the lcdc
node presence in the DT, a bit like:
https://github.com/kbeldan/linux/commit/cf15572ffef8e8a0d8110b3f6b29bd401d0538be
https://github.com/kbeldan/linux/commit/07e4fff9958bc1625a96791dce284c163fbe9c43


Regards, 
Karl

>  arch/arm/mach-davinci/da8xx-dt.c           | 43 ++++++++++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/da8xx.h |  4 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index f8ecc02..9d29670 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -44,9 +44,52 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>  
> +/*
> + * Adjust the default memory settings to cope with the LCDC
> + *
> + * REVISIT: This issue occurs on other davinci boards as well. Find
> + * a proper system-wide fix.
> + */
> +static void da850_lcdc_adjust_memory_bandwidth(void)
> +{
> +	void __iomem *cfg_mstpri1_base;
> +	void __iomem *cfg_mstpri2_base;
> +	void __iomem *emifb;
> +	u32 val;
> +
> +	/*
> +	 * Default master priorities in reg 0 are all lower by default than LCD
> +	 * which is set below to 0. Hence don't need to change here.
> +	 */
> +
> +	/* set EDMA30TC0 and TC1 to lower than LCDC (4 < 0) */
> +	cfg_mstpri1_base = DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI1_REG);
> +	val = __raw_readl(cfg_mstpri1_base);
> +	val &= 0xFFFF00FF;
> +	val |= 4 << 8;             /* 0-high, 7-low priority*/
> +	val |= 4 << 12;            /* 0-high, 7-low priority*/
> +	__raw_writel(val, cfg_mstpri1_base);
> +
> +	/*
> +	 * Reconfigure the LCDC priority to the highest to ensure that
> +	 * the throughput/latency requirements for the LCDC are met.
> +	 */
> +	cfg_mstpri2_base = DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI2_REG);
> +
> +	val = __raw_readl(cfg_mstpri2_base);
> +	val &= 0x0fffffff;
> +	__raw_writel(val, cfg_mstpri2_base);
> +
> +	/* set BPRIO */
> +	emifb = ioremap(DA8XX_DDR_CTL_BASE, SZ_4K);
> +	__raw_writel(0x20, emifb + DA8XX_PBBPR_REG);
> +	iounmap(emifb);
> +}
> +
>  static void __init da850_init_machine(void)
>  {
>  	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
> +	da850_lcdc_adjust_memory_bandwidth();
>  }
>  
>  static const char *const da850_boards_compat[] __initconst = {
> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index f9f9713..5549eff 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -56,6 +56,8 @@ extern unsigned int da850_max_speed;
>  #define DA8XX_SYSCFG0_VIRT(x)	(da8xx_syscfg0_base + (x))
>  #define DA8XX_JTAG_ID_REG	0x18
>  #define DA8XX_HOST1CFG_REG	0x44
> +#define DA8XX_MSTPRI1_REG	0x114
> +#define DA8XX_MSTPRI2_REG	0x118
>  #define DA8XX_CHIPSIG_REG	0x174
>  #define DA8XX_CFGCHIP0_REG	0x17c
>  #define DA8XX_CFGCHIP1_REG	0x180
> @@ -79,6 +81,8 @@ extern unsigned int da850_max_speed;
>  #define DA8XX_AEMIF_CTL_BASE	0x68000000
>  #define DA8XX_SHARED_RAM_BASE	0x80000000
>  #define DA8XX_ARM_RAM_BASE	0xffff0000
> +#define DA8XX_DDR_CTL_BASE	0xB0000000
> +#define DA8XX_PBBPR_REG		0x00000020
>  
>  void da830_init(void);
>  void da850_init(void);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
