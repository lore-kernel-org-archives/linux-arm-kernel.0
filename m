From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 21 Jul 2013 08:11:38 +0400
Subject: [PATCH 08/10] ARM: clps711x: Add CLPS711X cpuidle driver
In-Reply-To: <51EB0433.3050308@linaro.org>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-9-git-send-email-shc_work@mail.ru>
 <51EB0433.3050308@linaro.org>
Message-ID: <20130721081138.75cf5437bc30f42284f12e47@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Jul 2013 23:42:11 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/18/2013 08:34 PM, Alexander Shiyan wrote:
> > This adds the cpuidle driver for Cirrus Logic CLPS711X series SoCs.
> > Designed primarily for migration CLPS711X subarch for multiplatform & DT.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/cpuidle/Kconfig            |  6 +++
> >  drivers/cpuidle/Makefile           |  1 +
> >  drivers/cpuidle/cpuidle-clps711x.c | 80 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 87 insertions(+)
> >  create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
[...]
> > +static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
> > +				 struct cpuidle_driver *drv, int index)
> > +{
> > +	writel(1, clps711x_halt);
> 
> In what the 'clps711x_halt' differs from the usual WFI (cpu_do_idle) ?

AFAIK, ARM720T does not implement the WFI instruction.
"HALT" register in CLPS711X do the same:
"A write to this location will put the system into the Idle State by
halting the clock to the processor until an interrupt is generated."

> > +	asm volatile ("mov r0, r0");
> > +	asm volatile ("mov r0, r0");
> 
> Why are needed these two volatile ?

Two NOP instructions necessary following the enable or disable of the MMU.
Documentation not say anything about using this for "HALT", maybe it's the
remnants of the old code. I will remove it.

[...]
> > +static int clps711x_cpuidle_remove(struct platform_device *pdev)
> > +{
> > +	cpuidle_unregister(&clps711x_idle_driver);
> > +
> > +	return 0;
> > +}
> 
> The driver is not compiled as module, will this function be called ?

You're right. I will remove it.

> > +static const struct of_device_id clps711x_cpuidle_dt_ids[] = {
> > +	{ .compatible = "cirrus,clps711x-cpuidle", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, clps711x_cpuidle_dt_ids);
> > +
> > +static struct platform_driver clps711x_cpuidle_driver = {
> > +	.driver	= {
> > +		.name		= "clps711x-cpuidle",
> > +		.owner		= THIS_MODULE,
> > +		.of_match_table	= clps711x_cpuidle_dt_ids,
> > +	},
> > +	.remove	= clps711x_cpuidle_remove,
> > +};
> > +module_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuidle_probe);
> 
> +1

??? What here?

[...]

-- 
Alexander Shiyan <shc_work@mail.ru>
