From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 24 Aug 2016 20:08:32 +0200
Subject: [PATCH] ARM: EXYNOS: Clear OF_POPULATED flag from PMU node in
 IRQ init callback
In-Reply-To: <CAL_JsqJZXWSNchKNbKq9YBj2SfYNmyu1L65thg_H8JV7kHT9gw@mail.gmail.com>
References: <1471764465-2524-1-git-send-email-javier@osg.samsung.com>
 <20160824174428.GA18394@kozik-book>
 <CAL_JsqJZXWSNchKNbKq9YBj2SfYNmyu1L65thg_H8JV7kHT9gw@mail.gmail.com>
Message-ID: <20160824180832.GA23091@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 12:57:29PM -0500, Rob Herring wrote:
> On Wed, Aug 24, 2016 at 12:44 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Sun, Aug 21, 2016 at 03:27:45AM -0400, Javier Martinez Canillas wrote:
> >> The Exynos PMU node is an interrupt, clock and PMU (Power Management Unit)
> >> controller, and these functionalities are supported by different drivers
> >> that matches the same compatible strings.
> >>
> >> Since commit 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers
> >> as populated") the OF core flags interrupt controllers registered with the
> >> IRQCHIP_DECLARE() macro as OF_POPULATED, so platform devices with the same
> >> compatible string as the interrupt controller will not be registered.
> >>
> >> This prevents the PMU platform device to be registered so the Exynos PMU
> >> driver is never probed. This breaks (among other things) Suspend-to-RAM.
> >>
> >> Fix this by clearing the OF_POPULATED flag in the PMU IRQ init callback,
> >> to allow the Exynos PMU platform driver to be probed. The patch is based
> >> on Philipp Zabel's "ARM: imx6: mark GPC node as not populated after irq
> >> init to probe pm domain driver".
> >>
> >> Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >>
> >> ---
> >>
> >> This was tested on an Exynos5800 Peach Pi Chromebook with v4.8-rc2 +
> >> Philipp's patch: https://patchwork.kernel.org/patch/9271361/
> >>
> >>  arch/arm/mach-exynos/suspend.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> >> index 3750575c73c5..06332f626565 100644
> >> --- a/arch/arm/mach-exynos/suspend.c
> >> +++ b/arch/arm/mach-exynos/suspend.c
> >> @@ -255,6 +255,12 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
> >>               return -ENOMEM;
> >>       }
> >>
> >> +     /*
> >> +      * Clear the OF_POPULATED flag set in of_irq_init so that
> >> +      * later the Exynos PMU platform device won't be skipped.
> >> +      */
> >> +     of_node_clear_flag(node, OF_POPULATED);
> >> +
> >
> > Looks like a proper workaround (at least till of_irq_init sets this flag
> > before calling irq_init_cb()) however I have some more doubts:
> >
> > 1. The commit 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt
> > controllers as populated") might be also applied to clock CLK_OF_DECLARE
> > and the problem will appear again.
> 
> We now know what to look for...

D'oh!

If you gonna apply this to clock providers, please let us know (or apply
workaround to drivers/clk/samsung/clk-exynos-clkout.c).

> 
> > 2. We are reusing PMU compatible for irqcip, clock provider and a
> > platform driver. This is one PMU block with many features thus many
> > drivers were created. What happens if the Exynos platform driver
> > (drivers/soc/samsung/exynos-pmu.c) binds before irqchip or clk provider?
> 
> It can't. OF_DECLARE calls happen before initcalls*.
> 
> *I did find that IOMMU's are during initcalls which in my opinion is
> wrong. But I think there is some plan to fix them to support deferred
> probe and that should go away.
> 
> > Probably we should not reuse the compatible but create a new one for
> > each type of driver? How does it match DeviceTree?
> 
> No, compatible strings are for h/w blocks, not drivers. Now, if you
> need multiple platform drivers, then you should have 1 parent
> device/driver that's bound from DT, then it can create any child
> devices for specific functions.

Thanks for explanation.

For the Javier's patch itself, applied.

Best regards,
Krzysztof
