From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Dec 2011 17:44:33 +0100
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20111221154838.GA23102@page>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111221154838.GA23102@page>
Message-ID: <20111221164433.GA24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Wed, Dec 21, 2011 at 03:48:50PM +0000, Jamie Iles wrote:
> Just nits inline, but otherwise looks nice!  Certainly seems like an 
> interesting platform!
Yes it is. I hope to get the silicon version of it in January, this will
have 4 MiB of RAM and so might be better suited for Linux. (Currently
when booting with dt I get a prompt but starting a program makes the
kernel BUG because there isn't enough memory.)

> On Wed, Dec 21, 2011 at 04:13:48PM +0100, Uwe Kleine-K?nig wrote:
> [...]
> > diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
> > new file mode 100644
> > index 0000000..a4aa4f3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
> > @@ -0,0 +1,41 @@
> > +/dts-v1/;
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	model = "Energy Micro Giant Gecko Development Kit";
> > +	compatible = "efm32,dk3750";
> > +
> > +	aliases {
> > +		serial1 = &uart1;
> > +	};
> > +
> > +	nvic: nv-interrupt-controller at 0xe0000000  {
> > +		compatible = "arm,cortex-m3-nvic";
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +		reg = <0xe0000000 0x4000>;
> > +	};
> 
> I guess there's some patches somewhere else for the nvic binding, but I 
> thought that the nvic had a reasonable number of features like 
> edge/level etc and so would have more than one intererupt cell...
This dt stuff is all quite new to me. I will check what needs to be done
here. Support for the nvic is part of Catalin's patches that need some
more love to be included in mainline.
 
> > +	chosen {
> > +		bootargs = "console=ttyefm1,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64";
> > +	};
> > +
> > +	memory {
> 
> I think "memory at 80000000" is preferred here.
ok.

> > +		reg = <0x80000000 0x100000>;
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&nvic>;
> > +		ranges;
> > +
> > +		uart1: uart at 0x4000c400 { /* USART1 */
> > +			compatible = "efm32,usart";
> > +			reg = <0x4000c400 0x400>;
> > +			interrupts = <15>;
> > +			status = "ok";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/mach-efm32/common.h 
> > b/arch/arm/mach-efm32/common.h
> > new file mode 100644
> > index 0000000..f545224
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/common.h
> > @@ -0,0 +1,7 @@
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(addr)     (addr)
> > +#else
> > +#define IOMEM(addr)     ((void __force __iomem *)(addr))
> > +#endif
> 
> It looks like the only users of IOMEM are for the timers.  Is it 
I still wait for this to be moved to generic ARM code.

> possible to get the timer information from the device tree then remove 
> this?
Probably yes. Though I'll have to wait for the bigger machine to test
putting more into dt.
 
> > +extern struct sys_timer efm32_timer;
> > diff --git a/arch/arm/mach-efm32/dtmachine.c b/arch/arm/mach-efm32/dtmachine.c
> > new file mode 100644
> > index 0000000..42d091c
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/dtmachine.c
> > @@ -0,0 +1,47 @@
> > +#include <linux/kernel.h>
> > +#include <linux/pinctrl/machine.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_irq.h>
> > +
> > +#include <asm/hardware/nvic.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/time.h>
> > +
> > +#include "common.h"
> > +
> > +static void __init efm32_nvic_add_irq_domain(struct device_node *np,
> > +		struct device_node *interrupt_parent)
> > +{
> > +	irq_domain_add_simple(np, 0);
> > +}
> 
> If the nvic driver is new then I would have expected that to have device 
> tree and irq domain support internally.  From the entry macros it looks 
> like you're using the GIC macros, so is it pretty much GIC compatible?
Yeah, the relevant register offsets are identical. I think the nvic has
less power management capabilities and supports less irqs. I will
address this when I rework the nvic patch.

> > +
> > +static const struct of_device_id efm32_irq_match[] __initconst = {
> > +	{
> > +		.compatible = "arm,cortex-m3-nvic",
> > +		.data = efm32_nvic_add_irq_domain,
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +
> > +static void __init efm32_init(void)
> > +{
> > +	int ret;
> 
> This doesn't appear to be used.
yeah, that's only used in my tree that has a few more in the init
routine.
 
> > +
> > +	of_irq_init(efm32_irq_match);
> 
> Shouldn't this be in a .init_irq function()?
I think I copied that from imx. So if you're right imx needs fixing,
too.

> > +
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> > +
> > +static const char *const efm32gg_compat[] __initconst = {
> > +	"efm32,dk3750",
> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
> > +	.init_irq = nvic_init,
> 
> This doesn't exist...
yeah, see above.
 
> > +	.timer = &efm32_timer,
> > +	.init_machine = efm32_init,
> > +	.dt_compat = efm32gg_compat,
> > +MACHINE_END
> > diff --git a/arch/arm/mach-efm32/include/mach/io.h 
> > b/arch/arm/mach-efm32/include/mach/io.h
> > new file mode 100644
> > index 0000000..00b6af6
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/include/mach/io.h
> > @@ -0,0 +1,7 @@
> > +#ifndef __MACH_IO_H__
> > +#define __MACH_IO_H__
> > +
> > +#define __io(a)			__typesafe_io(a)
> 
> Do you support io ports on this platform?  If not then perhaps select 
> NO_IPORT and define __io(a) to 0?
> 
> > +#define __mem_pci(a)		(a)
> > +
> > +#endif /* __MACH_IO_H__ */
> > diff --git a/arch/arm/mach-efm32/include/mach/irqs.h b/arch/arm/mach-efm32/include/mach/irqs.h
> > new file mode 100644
> > index 0000000..5fa84db
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/include/mach/irqs.h
> > @@ -0,0 +1,6 @@
> > +#ifndef __MACH_IRQS_H__
> > +#define __MACH_IRQS_H__
> > +
> > +#define NR_IRQS			37
> 
> Is it possible to use sparse irq and have the nvic driver allocate the 
> irq descs?  I guess multi-platform is less likely on platforms with 
> small amounts of RAM though...
> 
> > +
> > +#endif /* __MACH_IRQS_H__ */
> > diff --git a/arch/arm/mach-efm32/include/mach/system.h b/arch/arm/mach-efm32/include/mach/system.h
> > new file mode 100644
> > index 0000000..619222c
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/include/mach/system.h
> > @@ -0,0 +1,18 @@
> > +#ifndef __MACH_SYSTEM_H__
> > +#define __MACH_SYSTEM_H__
> > +
> > +#include <asm/io.h>
> > +
> > +static inline void arch_idle(void)
> > +{
> > +	cpu_do_idle();
> > +}
> > +
> > +static inline void arch_reset(char mode, const char *cmd)
> > +{
> > +	/* XXX: move this to (say) cpuv7m_reset */
> > +	dsb();
> > +	__raw_writel(0x05fa0004, (void __iomem *)0xe000ed0c);
> > +	dsb();
> > +}
> > +#endif /* __MACH_SYSTEM_H__ */
> 
> I guess this would need to be rebased on Russell and Nicolas' series' 
> that remove arch_idle() and arch_reset() from here and moves the reset 
> into the common.c portion and part of the machine desc.
Yeah, I'm aware of these changes.

> > diff --git a/arch/arm/mach-efm32/time.c b/arch/arm/mach-efm32/time.c
> > new file mode 100644
> > index 0000000..65f93a3
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/time.c
> > @@ -0,0 +1,166 @@
> > +#include <linux/kernel.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/stringify.h>
> > +
> > +#include <asm/mach/time.h>
> > +
> > +#include <common.h>
> 
> Perhaps:
> 
> #include "common.h"
> 
> to make it clear it's a local include?
good catch.

> 
> > +
> > +#define BASEADDR_TIMER(n)		IOMEM(0x40010000 + (n) * 0x400)
> 
> Is it not possible to get this from the device tree rather than hard 
> coding it?
> 
> > +
> > +#define TIMERn_CTRL			0x00
> > +#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
> > +#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
> > +#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
> > +#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
> > +#define TIMERn_CTRL_OSMEN			0x00000010
> > +#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
> > +#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
> > +#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
> > +
> > +#define TIMERn_CMD			0x04
> > +#define TIMERn_CMD_START			0x1
> > +#define TIMERn_CMD_STOP				0x2
> > +
> > +#define TIMERn_IEN			0x0c
> > +#define TIMERn_IF			0x10
> > +#define TIMERn_IFS			0x14
> > +#define TIMERn_IFC			0x18
> > +#define TIMERn_IRQ_UF				0x2
> > +#define TIMERn_IRQ_OF				0x1
> > +
> > +#define TIMERn_TOP			0x1c
> > +#define TIMERn_CNT			0x24
> > +
> > +#define TIMER_CLOCKSOURCE	1
> > +#define TIMER_CLOCKEVENT	2
> > +#define IRQ_CLOCKEVENT		13
> > +
> > +static void efm32_timer_write(unsigned timerno, u32 val, unsigned offset)
> > +{
> > +	__raw_writel(val, BASEADDR_TIMER(timerno) + offset);
> 
> I believe writel_relaxed() is preferred where possible over 
> __raw_writel().
> 
> > +}
> > +
> > +static void efm32_clock_event_set_mode(enum clock_event_mode mode,
> > +		struct clock_event_device *unused)
> > +{
> > +	switch (mode) {
> > +	case CLOCK_EVT_MODE_PERIODIC:
> > +		efm32_timer_write(TIMER_CLOCKEVENT,
> > +				TIMERn_CMD_STOP, TIMERn_CMD);
> > +		efm32_timer_write(TIMER_CLOCKEVENT, 137, TIMERn_TOP);
> > +		efm32_timer_write(TIMER_CLOCKEVENT,
> > +				TIMERn_CTRL_PRESC_1024 |
> > +				TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> > +				TIMERn_CTRL_MODE_DOWN, TIMERn_CTRL);
> > +		efm32_timer_write(TIMER_CLOCKEVENT,
> > +				TIMERn_CMD_START, TIMERn_CMD);
> > +		break;
> > +
> > +	case CLOCK_EVT_MODE_ONESHOT:
> > +		efm32_timer_write(TIMER_CLOCKEVENT,
> > +				TIMERn_CMD_STOP, TIMERn_CMD);
> > +		efm32_timer_write(TIMER_CLOCKEVENT,
> > +				TIMERn_CTRL_PRESC_1024 |
> > +				TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> > +				TIMERn_CTRL_OSMEN |
> > +				TIMERn_CTRL_MODE_DOWN, TIMERn_CTRL);
> > +		break;
> > +
> > +	case CLOCK_EVT_MODE_UNUSED:
> > +	case CLOCK_EVT_MODE_SHUTDOWN:
> > +		efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_CMD_STOP,
> > +				TIMERn_CMD);
> > +		break;
> > +
> > +	case CLOCK_EVT_MODE_RESUME:
> > +		break;
> > +	}
> > +}
> > +
> > +static int efm32_clock_event_set_next_event(unsigned long evt,
> > +		struct clock_event_device *unused)
> > +{
> > +	/* writing START to CMD restarts a running timer, too */
> > +	efm32_timer_write(TIMER_CLOCKEVENT, evt, TIMERn_TOP);
> > +	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_CMD_START, TIMERn_CMD);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct clock_event_device efm32_clock_event_device = {
> > +	.name = "efm32 clockevent (" __stringify(TIMER_CLOCKEVENT) ")",
> > +	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_MODE_PERIODIC,
> > +	.set_mode = efm32_clock_event_set_mode,
> > +	.set_next_event = efm32_clock_event_set_next_event,
> > +	.rating = 200,
> > +};
> > +
> > +static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = &efm32_clock_event_device;
> > +
> > +	/* ack irq */
> > +	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_IRQ_UF, TIMERn_IFC);
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction efm32_clock_event_irq = {
> > +	.name = "efm32 clockevent",
> > +	.flags = IRQF_TIMER,
> > +	.handler = efm32_clock_event_handler,
> > +	.dev_id = &efm32_clock_event_device,
> > +};
> > +
> > +/*
> > + * XXX: use clk_ API to get frequency and enabling of the clocks used.
> > + * Here the reset defaults are used:
> > + * - freq_{HFPERCLK} = freq_{HFCLK}
> > + *   (CMU_HFPERCLKDIV_HFPERCLKDIV = 0x0)
> > + * - freq_{HFCLK} = freq_{HFRCO}
> > + *   (CMU_CTRL_HFCLKDIV = 0x0, CMU_STATUS_HFRCOSEL = 0x1)
> > + * - freq_{HFRCO} = 14MHz
> > + *   (CMU_HFRCOCTRL_BAND = 0x3)
> > + *
> > + * So the HFPERCLK runs at 14MHz. The timer has an additional prescaler
> > + * programmed to /1024. This make the timer run at
> > + *
> > + * 	14 MHz / 1024 = 13671.875 Hz
> > + *
> > + */
> > +static void __init efm32_timer_init(void)
> > +{
> > +	/* enable CMU_HFPERCLKEN0_TIMERn for clocksource via bit-band */
> > +	__raw_writel(1, IOMEM(0x43900894 + 4 * TIMER_CLOCKSOURCE));
> > +
> > +	efm32_timer_write(TIMER_CLOCKSOURCE,
> > +			TIMERn_CTRL_PRESC_1024 |
> > +			TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> > +			TIMERn_CTRL_MODE_UP, TIMERn_CTRL);
> > +	efm32_timer_write(TIMER_CLOCKSOURCE, TIMERn_CMD_START, TIMERn_CMD);
> > +
> > +	clocksource_mmio_init(BASEADDR_TIMER(TIMER_CLOCKSOURCE) + TIMERn_CNT,
> > +			"efm32 timer", 13672, 200, 16,
> > +			clocksource_mmio_readl_up);
> > +
> > +	/* enable CMU_HFPERCLKEN0_TIMERn for clockevent via bit-band */
> > +	__raw_writel(1, IOMEM(0x43900894 + 4 * TIMER_CLOCKEVENT));
> > +
> > +	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_IRQ_UF, TIMERn_IEN);
> > +
> > +	setup_irq(IRQ_CLOCKEVENT, &efm32_clock_event_irq);
> 
> Do you need to use setup_irq() here?  For picoxcell I used device tree 
> and so irq_of_parse_and_map() but that seemed fine for getting a timer 
> up and running.
Ok, I will evaluate that.

Thanks for your feedback,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
