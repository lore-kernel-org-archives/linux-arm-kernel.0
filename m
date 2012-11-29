From: rtivy@ti.com (Tivy, Robert)
Date: Thu, 29 Nov 2012 01:38:44 +0000
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50AB76FA.1050505@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Please see comments and noob questions below...

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Tuesday, November 20, 2012 4:27 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
> OMAP-L138 DSP
> 
> On 11/14/2012 6:03 AM, Robert Tivy wrote:
> > Requires CMA services.
> >
> > New 'clk_reset()' API added so that the DSP's reset state can be
> > toggled separately from its enable/disable operation.
> 
> But we cannot add a private clk_ API without it being defined in
> include/linux/clk.h. So, this requires wider alignment.
> 
> And I am not sure clock API should be extended to support reset since
> "resetting a clock" does not make a lot of sense. On DaVinci, clock
> gating and reset are handled by the same module, but that need not
> always be the case.
> 
> What you need is a way to reset an IP. I do not know of an existing
> framework to do this; likely a new API needs to be created. I am
> guessing this never existed so far because most of the IPs can be reset
> internally (by writing a bit within its own register space). I guess
> DSP is different since its actually a co-processor and may not have
> such a bit.
> 
> How about simulating a reset by making the DSP jump to its reset
> address. While I am sure its not quite the same as resetting the DSP
> using PSC, may be it could be used while you wait for consensus around
> handling module reset in kernel?

Since the ARM can't write the DSP's program counter I suspect such a temporary solution is not possible.

> 
> >
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> > ---
> >  arch/arm/mach-davinci/board-da850-evm.c        |   10 +++
> >  arch/arm/mach-davinci/board-omapl138-hawk.c    |   10 +++
> >  arch/arm/mach-davinci/clock.c                  |   22 +++++++
> >  arch/arm/mach-davinci/clock.h                  |    1 +
> >  arch/arm/mach-davinci/da850.c                  |   17 ++++++
> >  arch/arm/mach-davinci/devices-da8xx.c          |   78
> +++++++++++++++++++++++-
> >  arch/arm/mach-davinci/include/mach/da8xx.h     |    1 +
> >  arch/arm/mach-davinci/include/mach/psc.h       |    3 +
> >  arch/arm/mach-davinci/psc.c                    |   27 ++++++++
> >  arch/arm/mach-davinci/remoteproc.h             |   23 +++++++
> >  include/linux/clk.h                            |   17 ++++++
> >  include/linux/platform_data/da8xx-remoteproc.h |   34 +++++++++++
> 
> This patch is touching too many areas at once and needs to be split
> according to whether the changes are in the soc support or board
> support. 

OK.

> Also, platform data needs be added along with the driver. And
> the driver itself needs to be added before its platform users.

Are these comments suggesting some change to the code, or are they more of a guide as to how to split this part of the patch up into related chunks?  Please clarify.

> 
> >  12 files changed, 242 insertions(+), 1 deletion(-)  create mode
> > 100644 arch/arm/mach-davinci/remoteproc.h
> >  create mode 100644 include/linux/platform_data/da8xx-remoteproc.h
> >
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c
> > b/arch/arm/mach-davinci/board-da850-evm.c
> > index 6c172b3..4e86008 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> > @@ -48,6 +48,8 @@
> >  #include <media/tvp514x.h>
> >  #include <media/adv7343.h>
> >
> > +#include "remoteproc.h"
> > +
> >  #define DA850_EVM_PHY_ID		"davinci_mdio-0:00"
> >  #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
> >  #define DA850_LCD_BL_PIN		GPIO_TO_PIN(2, 15)
> > @@ -1550,6 +1552,11 @@ static __init void da850_evm_init(void)
> >  		pr_warn("%s: sata registration failed: %d\n", __func__,
> ret);
> >
> >  	da850_evm_setup_mac_addr();
> > +
> > +	ret = da8xx_register_rproc();
> > +	if (ret)
> > +		pr_warn("%s: dsp/rproc registration failed: %d\n",
> > +			__func__, ret);
> >  }
> >
> >  #ifdef CONFIG_SERIAL_8250_CONSOLE
> > @@ -1577,4 +1584,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci
> DA850/OMAP-L138/AM18x EVM")
> >  	.init_late	= davinci_init_late,
> >  	.dma_zone_size	= SZ_128M,
> >  	.restart	= da8xx_restart,
> > +#ifdef CONFIG_CMA
> > +	.reserve	= da8xx_rproc_reserve_cma,
> > +#endif
> >  MACHINE_END
> > diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
> > b/arch/arm/mach-davinci/board-omapl138-hawk.c
> > index 8aea169..a0b81c1 100644
> > --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> > +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> > @@ -21,6 +21,8 @@
> >  #include <mach/da8xx.h>
> >  #include <mach/mux.h>
> >
> > +#include "remoteproc.h"
> > +
> >  #define HAWKBOARD_PHY_ID		"davinci_mdio-0:07"
> >  #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
> >  #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
> > @@ -311,6 +313,11 @@ static __init void omapl138_hawk_init(void)
> >  	if (ret)
> >  		pr_warn("%s: watchdog registration failed: %d\n",
> >  			__func__, ret);
> > +
> > +	ret = da8xx_register_rproc();
> > +	if (ret)
> > +		pr_warn("%s: dsp/rproc registration failed: %d\n",
> > +			__func__, ret);
> >  }
> >
> >  #ifdef CONFIG_SERIAL_8250_CONSOLE
> > @@ -338,4 +345,7 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-
> L138 Hawkboard")
> >  	.init_late	= davinci_init_late,
> >  	.dma_zone_size	= SZ_128M,
> >  	.restart	= da8xx_restart,
> > +#ifdef CONFIG_CMA
> > +	.reserve	= da8xx_rproc_reserve_cma,
> > +#endif
> >  MACHINE_END
> > diff --git a/arch/arm/mach-davinci/clock.c
> > b/arch/arm/mach-davinci/clock.c index 34668ea..3fad759 100644
> > --- a/arch/arm/mach-davinci/clock.c
> > +++ b/arch/arm/mach-davinci/clock.c
> > @@ -31,6 +31,13 @@ static LIST_HEAD(clocks);  static
> > DEFINE_MUTEX(clocks_mutex);  static DEFINE_SPINLOCK(clockfw_lock);
> >
> > +static void __clk_reset(struct clk *clk, bool reset) {
> > +	if (clk->flags & CLK_PSC)
> > +		davinci_psc_reset_config(clk->domain, clk->gpsc, clk->lpsc,
> > +				reset, clk->flags);
> > +}
> > +
> >  static void __clk_enable(struct clk *clk)  {
> >  	if (clk->parent)
> > @@ -52,6 +59,21 @@ static void __clk_disable(struct clk *clk)
> >  		__clk_disable(clk->parent);
> >  }
> >
> > +int clk_reset(struct clk *clk, bool reset) {
> > +	unsigned long flags;
> > +
> > +	if (clk == NULL || IS_ERR(clk))
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(&clockfw_lock, flags);
> > +	__clk_reset(clk, reset);
> > +	spin_unlock_irqrestore(&clockfw_lock, flags);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(clk_reset);
> > +
> >  int clk_enable(struct clk *clk)
> >  {
> >  	unsigned long flags;
> > diff --git a/arch/arm/mach-davinci/clock.h
> > b/arch/arm/mach-davinci/clock.h index 46f0f1b..89aa95e 100644
> > --- a/arch/arm/mach-davinci/clock.h
> > +++ b/arch/arm/mach-davinci/clock.h
> > @@ -112,6 +112,7 @@ struct clk {
> >  #define PRE_PLL			BIT(4) /* source is before PLL
> mult/div */
> >  #define PSC_SWRSTDISABLE	BIT(5) /* Disable state is SwRstDisable
> */
> >  #define PSC_FORCE		BIT(6) /* Force module state transtition
> */
> > +#define PSC_LRST		BIT(8) /* Use local reset on
> enable/disable */
> >
> >  #define CLK(dev, con, ck) 	\
> >  	{			\
> > diff --git a/arch/arm/mach-davinci/da850.c
> > b/arch/arm/mach-davinci/da850.c index b90c172..4008fdc 100644
> > --- a/arch/arm/mach-davinci/da850.c
> > +++ b/arch/arm/mach-davinci/da850.c
> > @@ -76,6 +76,13 @@ static struct clk pll0_aux_clk = {
> >  	.flags		= CLK_PLL | PRE_PLL,
> >  };
> >
> > +static struct clk pll0_sysclk1 = {
> > +	.name		= "pll0_sysclk1",
> > +	.parent		= &pll0_clk,
> > +	.flags		= CLK_PLL,
> > +	.div_reg	= PLLDIV1,
> > +};
> 
> Adding support for PLL0 sysclk1 can be separated out and can be taken
> ahead of other changes.

OK, will do.

> 
> > +
> >  static struct clk pll0_sysclk2 = {
> >  	.name		= "pll0_sysclk2",
> >  	.parent		= &pll0_clk,
> > @@ -362,10 +369,19 @@ static struct clk sata_clk = {
> >  	.flags		= PSC_FORCE,
> >  };
> >
> > +static struct clk dsp_clk = {
> > +	.name		= "dsp",
> > +	.parent		= &pll0_sysclk1,
> > +	.domain		= DAVINCI_GPSC_DSPDOMAIN,
> > +	.lpsc		= DA8XX_LPSC0_GEM,
> > +	.flags		= PSC_LRST,
> > +};
> > +
> >  static struct clk_lookup da850_clks[] = {
> >  	CLK(NULL,		"ref",		&ref_clk),
> >  	CLK(NULL,		"pll0",		&pll0_clk),
> >  	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
> > +	CLK(NULL,		"pll0_sysclk1",	&pll0_sysclk1),
> >  	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
> >  	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
> >  	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
> > @@ -406,6 +422,7 @@ static struct clk_lookup da850_clks[] = {
> >  	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> >  	CLK("vpif",		NULL,		&vpif_clk),
> >  	CLK("ahci",		NULL,		&sata_clk),
> > +	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
> >  	CLK(NULL,		NULL,		NULL),
> >  };
> >
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c
> > b/arch/arm/mach-davinci/devices-da8xx.c
> > index 466b70c..ae54769 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > @@ -12,10 +12,13 @@
> >   */
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/dma-mapping.h>
> > +#ifdef CONFIG_CMA
> > +#include <linux/dma-contiguous.h>
> > +#endif
> >  #include <linux/serial_8250.h>
> >  #include <linux/ahci_platform.h>
> >  #include <linux/clk.h>
> > +#include <linux/platform_data/da8xx-remoteproc.h>
> >
> >  #include <mach/cputype.h>
> >  #include <mach/common.h>
> > @@ -655,6 +658,79 @@ int __init da850_register_mmcsd1(struct
> > davinci_mmc_config *config)  }  #endif
> >
> > +static struct resource da8xx_rproc_resources[] = {
> > +	{ /* HOST1CFG syscfg offset - DSP boot address */
> > +		.start		= 0x44,
> > +		.end		= 0x44,
> 
> These should be absolute addresses, not relative.
> 
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
> > +	.firmware	= "da8xx-dsp.xe674",
> 
> Sounds like the user can name the firmware whatever he wants and so it
> should be a module parameter to the remote proc driver? There is
> nothing platform specific about the firmware name, no?

Sounds OK.  I propose then to have the above be the default firmware name, along with a module parameter that will override if specified.

> 
> > +};
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
> > +#ifdef CONFIG_CMA
> > +
> > +static phys_addr_t rproc_base __initdata =
> > +CONFIG_DAVINCI_DSP_RPROC_CMA_BASE;
> > +static unsigned long rproc_size __initdata =
> > +CONFIG_DAVINCI_DSP_RPROC_CMA_SIZE;
> 
> These are not defined at this point so the kernel build will fail after
> applying this patch. This breaks things for those who run git-bisect.
> Please verify kernel build after applying each patch.
> 
> Looking at patch 6/6 where these are actually defined, it is not
> correct to define these using Kconfig. This prevents users from running
> a single kernel image on systems where the value needs to be different.

They can run a single image if the image supports overriding the Kconfig settings with kernel command-line arguments.

The most basic solution is constants in the .c file itself.  A better solution is Kconfig settings used by the .c file.  An even better solution is Kconfig settings with kernel command-line overrides.

> If you want the remoteproc driver to allocate a certain area of memory
> to the dsp, why don't you take that value as a module parameter so
> people who need different values can pass them differently? It is not
> clear to me why this memory management needs to be dealt with in
> platform code.

Unfortunetly we need to reserve this dsp memory during early boot, using CMA.  Runtime module insertion is too late.

> 
> > +
> > +static int __init early_rproc_mem(char *p) {
> > +	char *endp;
> > +
> > +	rproc_size = memparse(p, &endp);
> > +	if (*endp == '@')
> > +		rproc_base = memparse(endp + 1, NULL);
> > +
> > +	return 0;
> > +}
> > +early_param("rproc_mem", early_rproc_mem);
> 
> Use of non-standard kernel parameters is discouraged. All kernel
> parameters should be documented in Documentation/kernel-parameters.txt
> (this means each and every kernel parameter needs to be justified
> well).

Can I use the kernel command-line (i.e., u-boot bootargs variable) to specify non-kernel parameters?  I guess my question is more one about the terminology "kernel parameter" - is there a way to specify a module parameter on the kernel command line (like, perhaps, rproc.membase and rproc.memsize)?

Regards,

- Rob

> 
> I have not reviewed the rest of the code here. Lets get some of these
> fundamental issues resolved first.
> 
> Thanks,
> Sekhar
