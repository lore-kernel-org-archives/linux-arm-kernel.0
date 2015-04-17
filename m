From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 00:04:54 +0100
Subject: [PATCH v2 5/9] ARM: imx: add msl support for imx7d
In-Reply-To: <1429211860-14438-6-git-send-email-Frank.Li@freescale.com>
References: <1429211860-14438-1-git-send-email-Frank.Li@freescale.com>
 <1429211860-14438-6-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150417230454.GC12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 03:17:36AM +0800, Frank.Li at freescale.com wrote:
> From: Anson Huang <b20788@freescale.com>
> 
> Add i.MX7D MSL support.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

I'm not happy with this.

>  void imx_anatop_pre_suspend(void)
>  {
> +	if (cpu_is_imx7d()) {
> +		/* PLL overwrite set */
> +		regmap_write(anatop, ANADIG_ARM_PLL + REG_SET, 1 << 20);
> +		regmap_write(anatop, ANADIG_DDR_PLL + REG_SET, 1 << 19);
> +		regmap_write(anatop, ANADIG_SYS_PLL + REG_SET, 1 << 17);
> +		regmap_write(anatop, ANADIG_ENET_PLL + REG_SET, 1 << 13);
> +		regmap_write(anatop, ANADIG_AUDIO_PLL + REG_SET, 1 << 24);
> +		regmap_write(anatop, ANADIG_VIDEO_PLL + REG_SET, 1 << 24);
> +		return;
> +	}
> +
>  	if (imx_mmdc_get_ddr_type() == IMX_DDR_TYPE_LPDDR2)
>  		imx_anatop_enable_2p5_pulldown(true);
>  	else
> @@ -86,6 +104,17 @@ void imx_anatop_pre_suspend(void)
>  
>  void imx_anatop_post_resume(void)
>  {
> +	if (cpu_is_imx7d()) {
> +		/* PLL overwrite clear */
> +		regmap_write(anatop, ANADIG_ARM_PLL + REG_CLR, 1 << 20);
> +		regmap_write(anatop, ANADIG_DDR_PLL + REG_CLR, 1 << 19);
> +		regmap_write(anatop, ANADIG_SYS_PLL + REG_CLR, 1 << 17);
> +		regmap_write(anatop, ANADIG_ENET_PLL + REG_CLR, 1 << 13);
> +		regmap_write(anatop, ANADIG_AUDIO_PLL + REG_CLR, 1 << 24);
> +		regmap_write(anatop, ANADIG_VIDEO_PLL + REG_CLR, 1 << 24);
> +		return;
> +	}

Shouldn't both of these be determined by the compatible string rather
than checking __mxc_cpu_type?

> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index df42c14..4e84a7a 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -11,6 +11,8 @@
>  
>  unsigned int __mxc_cpu_type;
>  EXPORT_SYMBOL(__mxc_cpu_type);
> +unsigned int __mxc_arch_type;
> +EXPORT_SYMBOL(__mxc_arch_type);
>  
>  static unsigned int imx_soc_revision;
>  
> @@ -19,6 +21,11 @@ void mxc_set_cpu_type(unsigned int type)
>  	__mxc_cpu_type = type;
>  }
>  
> +void mxc_set_arch_type(unsigned int type)
> +{
> +	__mxc_arch_type = type;
> +}

You're re-inventing the wheel here.  Please get rid of __mxc_arch_type
and mxc_set_arch_type() entirely.

> @@ -38,6 +38,8 @@
>  #define MXC_CPU_IMX6DL		0x61
>  #define MXC_CPU_IMX6SX		0x62
>  #define MXC_CPU_IMX6Q		0x63
> +#define MXC_CPU_IMX7D		0x72
> +#define MXC_ARCH_CA7		0xc07

Get rid of MXC_ARCH_CA7.

> +static inline bool arm_is_ca7(void)
> +{
> +	return __mxc_arch_type == MXC_ARCH_CA7;
> +}

And this function.

> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 7f27001..2ca4a41 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -60,11 +60,33 @@ static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  static void __init imx_smp_init_cpus(void)
>  {
>  	int i, ncores;
> +	unsigned long arch_type;
>  
> -	ncores = scu_get_core_count(scu_base);
> +	asm volatile(
> +		".align 4\n"
> +		"mrc p15, 0, %0, c0, c0, 0\n"
> +		: "=r" (arch_type)
> +	);
> +
> +	/* MIDR[15:4] defines ARCH type */
> +	mxc_set_arch_type((arch_type >> 4) & 0xfff);
> +
> +	if (arm_is_ca7()) {

Rather than the above, use:

	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A7) {

here.

Even better would be to _not_ re-use imx_smp_init_cpus(), but instead
declare a separate smp_operations structure for the CA7 iMX7 which
takes account of this difference by calling a seperate .smp_init_cpus
function.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
