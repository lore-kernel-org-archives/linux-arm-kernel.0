From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 18 Apr 2010 04:35:17 +0200
Subject: [RFC PATCH 08/10] imx: Add MX53 core support
In-Reply-To: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
References: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
Message-ID: <20100418023517.GC7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 02:35:22PM -0500, Rob Herring wrote:

[snip]

> +
> +void __init mx5x_init_irq(void)

What does the x stand for? Obviously not 1, so how about mx53_init_irq?

> +{
> +	void __iomem *tzic_virt;
> +
> +	tzic_virt = ioremap(MX5x_TZIC_BASE_ADDR, SZ_4K);
> +	if (!tzic_virt)
> +		panic("unable to map TZIC interrupt controller\n");
> +	tzic_init_irq(tzic_virt);
> +}
> +
> diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
> index 56f2fb5..7c4c722 100644
> --- a/arch/arm/plat-mxc/devices.c
> +++ b/arch/arm/plat-mxc/devices.c
> @@ -20,13 +20,26 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <mach/common.h>
> +#include <mach/hardware.h>
>  
>  int __init mxc_register_device(struct platform_device *pdev, void *data)
>  {
>  	int ret;
> +	int i;
>  
>  	pdev->dev.platform_data = data;
>  
> +	if (cpu_is_mx53()) {
> +		for (i = 0; i < pdev->num_resources; i++) {
> +			struct resource *r = &pdev->resource[i];
> +			if (resource_type(r) != IORESOURCE_MEM)
> +				continue;
> +
> +			r->start = MX5x_FIXUP_ADDR(r->start);
> +			r->end = MX5x_FIXUP_ADDR(r->end);
> +		}
> +	}

This MX5x_FIXUP_ADDR stuff really looks painful. Please just use proper
MX53_ defines and use them where appropriate. We can really effort a
duplicate set of resources when both i.MX51 and i.MX53 support are
compiled in. You might have a look how Uwe did this in
arch/arm/mach-mx2/devices.c.

> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index b83963f..7759df7 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -55,6 +55,7 @@
>  
>  #define MX51_TZIC_BASE_ADDR_TO1		0x8FFFC000
>  #define MX51_TZIC_BASE_ADDR		0xE0000000
> +#define MX5x_TZIC_BASE_ADDR		0x0FFFC000
>  
>  #define MX51_DEBUG_BASE_ADDR		0x60000000
>  #define MX51_DEBUG_SIZE			(36 * SZ_1K)
> @@ -170,6 +171,7 @@
>  #define MX51_PLL1_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00080000)
>  #define MX51_PLL2_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00084000)
>  #define MX51_PLL3_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00088000)
> +#define MX5x_PLL4_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x0008C000)
>  #define MX51_AHBMAX_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00094000)
>  #define MX51_IIM_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00098000)
>  #define MX51_CSU_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x0009C000)
> @@ -234,6 +236,10 @@
>  	(MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
>  	0xDEADBEEF)
>  
> +#define MX5x_FIXUP_ADDR(x) ((cpu_is_mx53() && \
> +	(MX51_IS_MODULE(x, AIPS1) || MX51_IS_MODULE(x, AIPS2) || MX51_IS_MODULE(x, SPBA0))) ? \
> +	((x) - 0x20000000) : (x))
> +
>  /*
>   * define the address mapping macros: in physical address order
>   */
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index ec85f14..b77f71e 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -31,6 +31,7 @@
>  #define MXC_CPU_MX31		31
>  #define MXC_CPU_MX35		35
>  #define MXC_CPU_MX51		51
> +#define MXC_CPU_MX53		53
>  #define MXC_CPU_MXC91231	91231
>  
>  #ifndef __ASSEMBLY__
> @@ -121,6 +122,18 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mx51()		(0)
>  #endif
>  
> +#ifdef CONFIG_ARCH_MX53
> +# ifdef mxc_cpu_type
> +#  undef mxc_cpu_type
> +#  define mxc_cpu_type __mxc_cpu_type
> +# else
> +#  define mxc_cpu_type MXC_CPU_MX53
> +# endif
> +# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
> +#else
> +# define cpu_is_mx53()		(0)
> +#endif
> +
>  #ifdef CONFIG_ARCH_MXC91231
>  # ifdef mxc_cpu_type
>  #  undef mxc_cpu_type
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
