From: rtivy@ti.com (Tivy, Robert)
Date: Tue, 22 Jan 2013 02:33:23 +0000
Subject: [PATCH v5 7/9] ARM: davinci: Remoteproc platform device
 creation data/code
In-Reply-To: <50FCFD89.2070109@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-8-git-send-email-rtivy@ti.com> <50FCFD89.2070109@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431205DEB@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Monday, January 21, 2013 12:34 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark; ohad at wizery.com;
> rob at landley.net; linux-doc at vger.kernel.org
> Subject: Re: [PATCH v5 7/9] ARM: davinci: Remoteproc platform device
> creation data/code
> 
> 
> On 1/11/2013 5:53 AM, Robert Tivy wrote:
> > Added a new remoteproc platform device for DA8XX.  Contains CMA-based
> > reservation of physical memory block.  A new kernel command-line
> > parameter has been added to allow boot-time specification of the
> > physical memory block.
> >
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> > ---
> >  Documentation/kernel-parameters.txt        |    7 +++
> >  arch/arm/mach-davinci/devices-da8xx.c      |   93
> +++++++++++++++++++++++++++-
> >  arch/arm/mach-davinci/include/mach/da8xx.h |    4 ++
> >  3 files changed, 103 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/kernel-parameters.txt
> b/Documentation/kernel-parameters.txt
> > index 363e348..e95afb1 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -44,6 +44,7 @@ parameter is applicable:
> >  	AVR32	AVR32 architecture is enabled.
> >  	AX25	Appropriate AX.25 support is enabled.
> >  	BLACKFIN Blackfin architecture is enabled.
> > +	CMA	Contiguous Memory Area support is enabled.
> >  	DRM	Direct Rendering Management support is enabled.
> >  	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
> >  	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
> > @@ -2634,6 +2635,12 @@ bytes respectively. Such letter suffixes can
> also be entirely omitted.
> >  			Useful for devices that are detected asynchronously
> >  			(e.g. USB and MMC devices).
> >
> > +	rproc_mem=nn[KMG][@address]
> > +			[KNL,ARM,CMA] Remoteproc physical memory block.
> > +			Memory area to be used by remote processor image,
> > +			managed by CMA.  Suitable defaults exist if not
> > +			specified.
> 
> There are no defaults now, right?

That's right, booter must specify rproc_mem in u-boot bootargs.

> 
> > +
> >  	rw		[KNL] Mount root device read-write on boot
> >
> >  	S		[KNL] Run init in single mode
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-
> davinci/devices-da8xx.c
> > index fb2f51b..e8016ca 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > @@ -12,10 +12,11 @@
> >   */
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/dma-mapping.h>
> > +#include <linux/dma-contiguous.h>
> >  #include <linux/serial_8250.h>
> >  #include <linux/ahci_platform.h>
> >  #include <linux/clk.h>
> > +#include <linux/platform_data/da8xx-remoteproc.h>
> >
> >  #include <mach/cputype.h>
> >  #include <mach/common.h>
> > @@ -706,6 +707,96 @@ int __init da850_register_mmcsd1(struct
> davinci_mmc_config *config)
> >  }
> >  #endif
> >
> > +static struct resource da8xx_rproc_resources[] = {
> > +	{ /* DSP boot address */
> > +		.start		= DA8XX_SYSCFG0_BASE +
> DA8XX_HOST1CFG_REG,
> > +		.end		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG + 3,
> > +		.flags		= IORESOURCE_MEM,
> > +	},
> > +	{ /* dsp irq */
> > +		.start		= IRQ_DA8XX_CHIPINT0,
> > +		.end		= IRQ_DA8XX_CHIPINT0,
> > +		.flags		= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct da8xx_rproc_pdata rproc_pdata = {
> > +	.name		= "dsp",
> > +};
> 
> Since the driver is only for da850 so the name of the remote processor
> is fixed and can probably be hardcoded in the driver itself.

In which case I wouldn't even need the da8xx_rproc_pdata at all, which would be nice.

> 
> > +
> > +static struct platform_device da8xx_dsp = {
> > +	.name	= "davinci-rproc",
> > +	.id	= 0,
> > +	.dev	= {
> > +		.platform_data		= &rproc_pdata,
> > +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > +	},
> > +	.num_resources	= ARRAY_SIZE(da8xx_rproc_resources),
> > +	.resource	= da8xx_rproc_resources,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_DAVINCI_REMOTEPROC)
> > +
> > +static phys_addr_t rproc_base __initdata;
> > +static unsigned long rproc_size __initdata;
> > +
> > +static int __init early_rproc_mem(char *p)
> > +{
> > +	char *endp;
> > +
> > +	if (p == NULL)
> > +		return 0;
> > +
> > +	rproc_size = memparse(p, &endp);
> > +	if (*endp == '@')
> > +		rproc_base = memparse(endp + 1, NULL);
> > +
> > +	return 0;
> > +}
> > +early_param("rproc_mem", early_rproc_mem);
> > +
> > +void __init da8xx_rproc_reserve_cma(void)
> > +{
> > +	int ret;
> > +
> > +	if (!rproc_base || !rproc_size) {
> > +		pr_err("%s: 'rproc_mem=nn at address' badly specified\n"
> > +		       "    'nn' and 'address' must both be non-zero\n",
> > +		       __func__);
> > +
> > +		return;
> > +	}
> > +
> > +	pr_info("%s: reserving 0x%lx @ 0x%lx...\n",
> > +		__func__, rproc_size, (unsigned long)rproc_base);
> > +
> > +	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size,
> rproc_base, 0);
> > +	if (ret)
> > +		pr_err("%s: dma_declare_contiguous failed %d\n", __func__,
> ret);
> > +}
> > +
> > +#else
> > +
> > +void __init da8xx_rproc_reserve_cma(void)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +int __init da8xx_register_rproc(void)
> > +{
> > +	int ret;
> > +
> > +	ret = platform_device_register(&da8xx_dsp);
> > +	if (ret) {
> > +		pr_err("%s: platform_device_register: %d\n", __func__,
> ret);
> > +
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +};
> > +
> >  static struct resource da8xx_rtc_resources[] = {
> >  	{
> >  		.start		= DA8XX_RTC_BASE,
> > diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h
> b/arch/arm/mach-davinci/include/mach/da8xx.h
> > index 700d311..e9295bd 100644
> > --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> > +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> > @@ -54,6 +54,7 @@ extern unsigned int da850_max_speed;
> >  #define DA8XX_SYSCFG0_BASE	(IO_PHYS + 0x14000)
> >  #define DA8XX_SYSCFG0_VIRT(x)	(da8xx_syscfg0_base + (x))
> >  #define DA8XX_JTAG_ID_REG	0x18
> > +#define DA8XX_HOST1CFG_REG	0x44
> >  #define DA8XX_CFGCHIP0_REG	0x17c
> >  #define DA8XX_CFGCHIP2_REG	0x184
> >  #define DA8XX_CFGCHIP3_REG	0x188
> > @@ -105,6 +106,9 @@ int __init da850_register_vpif_display
> >  int __init da850_register_vpif_capture
> >  			(struct vpif_capture_config *capture_config);
> >  void da8xx_restart(char mode, const char *cmd);
> > +void __init da8xx_rproc_reserve_cma(void);
> 
> No need of __init qualifier in function prototypes.
> 
> The patch looks good to me otherwise, but I will not apply it right
> away
> and instead wait for the driver to get accepted first.

Sounds like a plan.

Thanks & Regards,

- Rob

> 
> Thanks,
> Sekhar
