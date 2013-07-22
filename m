From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 22 Jul 2013 23:14:35 +0200
Subject: [PATCH 5/5] ARM: bcm4760: Add restart hook
In-Reply-To: <201307211020.25966.arnd@arndb.de>
References: <20130721002320.730568671@gmail.com>
 <20130721002714.732402573@gmail.com>
 <201307211020.25966.arnd@arndb.de>
Message-ID: <20130722211434.GA6665@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 21, 2013 at 10:20:25AM +0200, Arnd Bergmann wrote:
> On Sunday 21 July 2013, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Restart hook implementation for the Broadcom BCM4760 based ARM11 SoCs.
> > 
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/brcm,bcm4760-pm-wdt.txt |   14 ++
> >  arch/arm/boot/dts/bcm4760.dtsi                                     |    5 +
> >  arch/arm/mach-bcm/bcm4760.c                                        |   78 ++++++++++
> >  3 files changed, 97 insertions(+)
> 
> The implementation looks ok to me, but I would prefer this to be part of a
> watchdog device driver that overrides the pm_power_off hook.

I'd appreciate if I could keep this implementation, which I don't plan to
develop further, but won't cry if it's left out.

> It can probably be done at a later stage when you submit a watchdog driver.

I should be able to reuse an existing ARM watchdog driver but I need to
investigate further.

BTW is it acceptable to loose the ability to reboot the board in case the
proper watchdog driver is not configured?

Domenico

> 
> 	Arnd
> 
> > Index: b/Documentation/devicetree/bindings/watchdog/brcm,bcm4760-pm-wdt.txt
> > ===================================================================
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm4760-pm-wdt.txt
> > @@ -0,0 +1,14 @@
> > +Broadcom BCM4760 watchdog timer device tree bindings
> > +----------------------------------------------------
> > +
> > +Required properties:
> > +
> > +- compatible : should be "brcm,bcm4760-pm-wdt"
> > +- reg : Specifies base physical address and size of the registers.
> > +
> > +Example:
> > +
> > +watchdog {
> > +	compatible = "brcm,bcm4760-pm-wdt";
> > +	reg = <0xbd000 0x1000>;
> > +};
> > Index: b/arch/arm/boot/dts/bcm4760.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/bcm4760.dtsi
> > +++ b/arch/arm/boot/dts/bcm4760.dtsi
> > @@ -23,6 +23,11 @@
> >  			reg = <0xbc000 0x1000>;
> >  		};
> >  
> > +		watchdog {
> > +			compatible = "brcm,bcm4760-pm-wdt";
> > +			reg = <0xbd000 0x1000>;
> > +		};
> > +
> >  		vic0: interrupt-controller at 80000 {
> >  			compatible = "brcm,bcm4760-pl192", "arm,pl192-vic", "arm,primecell";
> >  			reg = <0x80000 0x1000>;
> > Index: b/arch/arm/mach-bcm/bcm4760.c
> > ===================================================================
> > --- a/arch/arm/mach-bcm/bcm4760.c
> > +++ b/arch/arm/mach-bcm/bcm4760.c
> > @@ -16,7 +16,9 @@
> >  
> >  #include <linux/init.h>
> >  #include <linux/irqchip.h>
> > +#include <linux/delay.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/clk/bcm4760.h>
> >  
> > @@ -28,6 +30,17 @@
> >  #define BCM4760_PERIPH_VIRT   IOMEM(0xd0080000)
> >  #define BCM4760_PERIPH_SIZE   SZ_512K
> >  
> > +#define BCM4760_WDT_LOAD      0x000
> > +#define BCM4760_WDT_CTRL      0x008
> > +#define BCM4760_WDT_INTCLR    0x00c
> > +#define BCM4760_WDT_LOCK      0xc00
> > +
> > +#define BCM4760_WDT_PASSWORD  0x1acce551
> > +#define BCM4760_WDT_INTEN     BIT(0)
> > +#define BCM4760_WDT_RESEN     BIT(1)
> > +
> > +static void __iomem *wdt_regs;
> > +
> >  static struct map_desc io_map __initdata = {
> >  	.virtual = (unsigned long) BCM4760_PERIPH_VIRT,
> >  	.pfn = __phys_to_pfn(BCM4760_PERIPH_PHYS),
> > @@ -56,11 +69,75 @@ static void __init bcm4760_system_rev(vo
> >  		system_rev = id0 << 8 | (id1 & 0xff);
> >  }
> >  
> > +static const struct of_device_id bcm4760_pm_wdt_match[] __initconst = {
> > +	{ .compatible = "brcm,bcm4760-pm-wdt" },
> > +	{}
> > +};
> > +
> > +/*
> > + * The machine restart method can be called from an atomic context so we won't
> > + * be able to ioremap the regs then.
> > + */
> > +static void __init bcm4760_setup_restart(void)
> > +{
> > +	struct device_node *node;
> > +
> > +	node = of_find_matching_node(NULL, bcm4760_pm_wdt_match);
> > +	if (!node) {
> > +		pr_info("No bcm4760 watchdog node\n");
> > +		return;
> > +	}
> > +
> > +	wdt_regs = of_iomap(node, 0);
> > +	if (!wdt_regs) {
> > +		pr_err("Can't remap watchdog registers\n");
> > +		return;
> > +	}
> > +
> > +	/* unlock watchdog registers */
> > +	writel(BCM4760_WDT_PASSWORD, wdt_regs + BCM4760_WDT_LOCK);
> > +	/* disable watchdog */
> > +	writel(0, wdt_regs + BCM4760_WDT_CTRL);
> > +	/* lock watchdog registers */
> > +	writel(1, wdt_regs + BCM4760_WDT_LOCK);
> > +}
> > +
> > +static void bcm4760_restart(enum reboot_mode mode, const char *cmd)
> > +{
> > +	if (!wdt_regs) {
> > +		pr_err("No restart hook installed. ");
> > +		return;
> > +	}
> > +
> > +	/* unlock watchdog registers */
> > +	writel(BCM4760_WDT_PASSWORD, wdt_regs + BCM4760_WDT_LOCK);
> > +
> > +	/* disable watchdog */
> > +	writel(0, wdt_regs + BCM4760_WDT_CTRL);
> > +	udelay(20);
> > +
> > +	/* clear the irq status */
> > +	writel(1, wdt_regs + BCM4760_WDT_INTCLR);
> > +	udelay(20);
> > +
> > +	/* expire after 5 cycles (~156us) */
> > +	writel(5, wdt_regs + BCM4760_WDT_LOAD);
> > +	/* enable watchdog */
> > +	writel(BCM4760_WDT_INTEN | BCM4760_WDT_RESEN,
> > +		wdt_regs + BCM4760_WDT_CTRL);
> > +
> > +	/* lock watchdog registers */
> > +	writel(1, wdt_regs + BCM4760_WDT_LOCK);
> > +	/* wait the bite */
> > +	udelay(400);
> > +}
> > +
> >  static void __init bcm4760_init(void)
> >  {
> >  	int err;
> >  
> >  	bcm4760_system_rev();
> > +	bcm4760_setup_restart();
> >  	bcm4760_init_clocks();
> >  
> >  	err = of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > @@ -78,5 +155,6 @@ static const char * const bcm4760_compat
> >  DT_MACHINE_START(BCM4760, "Broadcom BCM4760")
> >  	.map_io = bcm4760_map_io,
> >  	.init_machine = bcm4760_init,
> > +	.restart = bcm4760_restart,
> >  	.dt_compat = bcm4760_compat
> >  MACHINE_END
> > 
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
