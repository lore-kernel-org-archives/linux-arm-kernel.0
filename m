From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 28 Mar 2012 17:53:47 +0800
Subject: [PATCH v2 1/1] ARM: imx28: add basic dt support
In-Reply-To: <20120328055801.GA3953@S2100-06.ap.freescale.net>
References: <1332513070-5400-1-git-send-email-b29396@freescale.com>
 <20120328055801.GA3953@S2100-06.ap.freescale.net>
Message-ID: <20120328095346.GA31901@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 01:58:04PM +0800, Guo Shawn-R65073 wrote:
> On Fri, Mar 23, 2012 at 10:31:10PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
...
> > +/dts-v1/;
> > +/include/ "imx28.dtsi"
> > +
> > +/ {
> > +	model = "Freescale i.MX28 Evaluation Kit";
> > +	compatible = "fsl,imx28-evk", "fsl,imx28";
> > +
> > +	memory {
> > +		device_type = "memory";
> 
> This is already in skeleton.dtsi included by imx28.dtsi.
> 
Correct.

> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> 
> These two are already in skeleton.dtsi.
> 
will remove.

> > +			icoll: interrupt-controller at 80000000 {
> > +				compatible = "fsl,imx28-icoll";
> 
> I would expect it be:
> 
> 	compatible = "fsl,imx28-icoll", "fsl,mxs-icoll";
> 
> So it can be matched by both imx23 and imx28.
> 
Yes, i can change like that.

> > +				#interrupt-cells = <1>;
> > +			};
> > +
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index c57f996..c776aef 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -17,6 +17,14 @@ config SOC_IMX28
> >  
> >  comment "MXS platforms:"
> >  
> > +config MACH_MXS_DT
> > +	bool "Support MXS platforms from device tree"
> > +	select SOC_IMX28
> > +	select USE_OF
> > +	help
> > +	  Include support for Freescale MXS platforms(i.MX23 and i.MX28)
> > +	  using the device tree for discovery
> > +
> 
> If I build mxs_defconfig with only MACH_MXS_DT enabled, I got
> 
>   LD      .tmp_vmlinux1
> arch/arm/mach-mxs/built-in.o: In function `mxs_add_amba_device':
> arch/arm/mach-mxs/devices.c:89: undefined reference to `amba_device_register'
> 
It looks ideally we do not need to compile devices.c and devices/* for only dt.

> It's caused by missing "select ARM_AMBA".  For non-dt build, it gets
> selected under "config MXS_HAVE_AMBA_DUART" (mach-mxs/devices/Kconfig).
> 
> I intend to fix it in the following way.
> 
I agree with this temporary fix.

> --8<---
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 570d5d5..d076452 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -7,11 +7,13 @@ config MXS_OCOTP
> 
>  config SOC_IMX23
>         bool
> +       select ARM_AMBA
>         select CPU_ARM926T
>         select HAVE_PWM
> 
>  config SOC_IMX28
>         bool
> +       select ARM_AMBA
>         select CPU_ARM926T
>         select HAVE_PWM
> 
> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> index 18b6bf5..2febd62 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -1,6 +1,5 @@
>  config MXS_HAVE_AMBA_DUART
>         bool
> -       select ARM_AMBA
> 
> --->8--
> 
> > +#include <linux/init.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/time.h>
> > +#include <mach/common.h>
> > +#include <mach/mx28.h>
> 
> This one is not needed.
> 
Correct.

> > +
> > +static int __init imx28_icoll_add_irq_domain(struct device_node *np,
> 
> mxs_icoll_add_irq_domain
> 
> > +				struct device_node *interrupt_parent)
> > +{
> > +	irq_domain_add_simple(np, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mxs_irq_match[] __initconst = {
> > +	{ .compatible = "fsl,imx28-icoll", .data = imx28_icoll_add_irq_domain, },
> 
> "fsl,mxs-icoll"
> 
Will change.

> > +	{ /* sentinel */ }
> > +};
> > +
> > +static void __init mxs_dt_init_irq(void)
> > +{
> > +	icoll_init_irq();
> > +	of_irq_init(mxs_irq_match);
> > +}
> > +
> > +static void __init imx28_timer_init(void)
> > +{
> > +	mx28_clocks_init();
> > +}
> > +
> > +static struct sys_timer imx28_timer = {
> > +	.init = imx28_timer_init,
> > +};
> > +
> > +static void __init imx28_machine_init(void)
> 
> mxs_init_machine(), so that imx23 can use it later and have the
> function name somehow aligned with hook name .init_machine.
> 
I can do it, but, as icoll, that means we're doing things by assuming
no difference between mx23 and mx28 before we really start mx23 dt work.
However, i think at least of_platform_populate should be common.
So i agree to change to mxs_init_machine right now.
If any difference we may change accordingly latter.

> > +{
> > +       of_platform_populate(NULL, of_default_bus_match_table,
> > +		NULL, NULL);
> > +}
> > +
> > +static const char *imx28_dt_compat[] __initdata = {
> 
> mxs_dt_compat
> 
If changed like that, is it reasonable for mx23 to use this
compatible string list?
I planed to have separate compatible string for mx23 and mx28.

> > +	"fsl,imx28",
> > +	"fsl,imx28-evk",
> 
> I would have the list sorted from the most specific to the most
> general.  That said, it's better to have "fsl,imx28" sorted after
> "fsl,imx28-evk".
> 
I prefer to keep the basic one first, then for future boards support
we just add them below rather than insert above the basic one "fsl,imx28".
However, it's really not a big deal.
If you persist to do like that, i can also do it.

> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
> > +	.map_io		= mx28_map_io,
> > +	.init_irq	= mxs_dt_init_irq,
> > +	.timer		= &imx28_timer,
> > +	.init_machine	= imx28_machine_init,
> > +	.dt_compat	= imx28_dt_compat,
> > +	.restart	= mxs_restart,
> > +MACHINE_END
> > -- 
> > 1.7.0.4
> > 
> 

Regards
Dong Aisheng
