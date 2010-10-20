From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 20 Oct 2010 13:53:42 -0400 (EDT)
Subject: [PATCH,RFC] Remove dependency of plat-orion time code on mach
	directory includes.
In-Reply-To: <20101020050126.GC12979@mail.wantstofly.org>
References: <20101020050126.GC12979@mail.wantstofly.org>
Message-ID: <alpine.LFD.2.00.1010201350450.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Oct 2010, Lennert Buytenhek wrote:

> This patch makes the various mach dirs that use plat-orion pass in
> timer and bridge addresses into orion_time_init() explicitly, instead
> of having plat-orion get those values by including a mach dir include
> file -- the latter mechanism is problematic if you want to support
> multiple ARM platforms in the same kernel image.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Looks fine, except for the annoying (void __iomem *) casts.  Maybe they 
should be part of the definition of BRIDGE_VIRT_BASE and friends.



> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index f7a1258..7ea13ef 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -540,7 +540,10 @@ static int get_tclk(void)
>  
>  static void dove_timer_init(void)
>  {
> -	orion_time_init(IRQ_DOVE_BRIDGE, get_tclk());
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_DOVE_BRIDGE, get_tclk());
>  }
>  
>  struct sys_timer dove_timer = {
> diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
> index 214a4c3..226949d 100644
> --- a/arch/arm/mach-dove/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
> @@ -26,10 +26,6 @@
>  #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
>  #define  SOFT_RESET		0x00000001
>  
> -#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
> -#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
> -#define  BRIDGE_INT_TIMER0	0x0002
> -#define  BRIDGE_INT_TIMER1	0x0004
>  #define  BRIDGE_INT_TIMER1_CLR	(~0x0004)
>  
>  #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 1c82d42..bebc0c5 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -865,7 +865,11 @@ int __init kirkwood_find_tclk(void)
>  static void __init kirkwood_timer_init(void)
>  {
>  	kirkwood_tclk = kirkwood_find_tclk();
> -	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
> +
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
>  }
>  
>  struct sys_timer kirkwood_timer = {
> diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> index aff0e13..957bd79 100644
> --- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> @@ -29,9 +29,6 @@
>  #define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
>  #define WDT_INT_REQ		0x0008
>  
> -#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
> -#define BRIDGE_INT_TIMER0	0x0002
> -#define BRIDGE_INT_TIMER1	0x0004
>  #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
>  
>  #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
> diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> index d26bf32..269677c 100644
> --- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> @@ -39,6 +39,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <mach/kirkwood.h>
> +#include <mach/bridge-regs.h>
>  #include <mach/leds-ns2.h>
>  #include <plat/time.h>
>  #include "common.h"
> @@ -230,7 +231,11 @@ static struct platform_device netspace_v2_leds = {
>  static void netspace_v2_timer_init(void)
>  {
>  	kirkwood_tclk = 166666667;
> -	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
> +
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
>  }
>  
>  struct sys_timer netspace_v2_timer = {
> diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> index 2bd14c5..5f41e14 100644
> --- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> @@ -38,6 +38,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <mach/kirkwood.h>
> +#include <mach/bridge-regs.h>
>  #include <plat/time.h>
>  #include "common.h"
>  #include "mpp.h"
> @@ -252,7 +253,11 @@ static struct platform_device netxbig_v2_gpio_buttons = {
>  static void netxbig_v2_timer_init(void)
>  {
>  	kirkwood_tclk = 166666667;
> -	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
> +
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
>  }
>  
>  struct sys_timer netxbig_v2_timer = {
> diff --git a/arch/arm/mach-loki/common.c b/arch/arm/mach-loki/common.c
> index 818f19d..26aba6c 100644
> --- a/arch/arm/mach-loki/common.c
> +++ b/arch/arm/mach-loki/common.c
> @@ -18,6 +18,7 @@
>  #include <asm/timex.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> +#include <mach/bridge-regs.h>
>  #include <mach/loki.h>
>  #include <plat/orion_nand.h>
>  #include <plat/time.h>
> @@ -292,7 +293,10 @@ void __init loki_uart1_init(void)
>   ****************************************************************************/
>  static void loki_timer_init(void)
>  {
> -	orion_time_init(IRQ_LOKI_BRIDGE, LOKI_TCLK);
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_LOKI_BRIDGE, LOKI_TCLK);
>  }
>  
>  struct sys_timer loki_timer = {
> diff --git a/arch/arm/mach-loki/include/mach/bridge-regs.h b/arch/arm/mach-loki/include/mach/bridge-regs.h
> index a3fabf7..fd87732 100644
> --- a/arch/arm/mach-loki/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-loki/include/mach/bridge-regs.h
> @@ -17,11 +17,6 @@
>  #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
>  #define SOFT_RESET		0x00000001
>  
> -#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
> -
> -#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
> -#define BRIDGE_INT_TIMER0	0x0002
> -#define BRIDGE_INT_TIMER1	0x0004
>  #define BRIDGE_INT_TIMER1_CLR	0x0004
>  
>  #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
> index 08465eb..db926b2 100644
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ b/arch/arm/mach-mv78xx0/common.c
> @@ -820,7 +820,10 @@ void __init mv78xx0_uart3_init(void)
>   ****************************************************************************/
>  static void mv78xx0_timer_init(void)
>  {
> -	orion_time_init(IRQ_MV78XX0_TIMER_1, get_tclk());
> +	orion_time_init((void __iomem *)BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_MV78XX0_TIMER_1, get_tclk());
>  }
>  
>  struct sys_timer mv78xx0_timer = {
> diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
> index 2d14c4f..c64dbb9 100644
> --- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
> @@ -20,10 +20,6 @@
>  #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
>  #define SOFT_RESET		0x00000001
>  
> -#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
> -#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
> -#define BRIDGE_INT_TIMER0	0x0002
> -#define BRIDGE_INT_TIMER1	0x0004
>  #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
>  
>  #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 8dc2c76..682653b 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -26,6 +26,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> +#include <mach/bridge-regs.h>
>  #include <mach/hardware.h>
>  #include <mach/orion5x.h>
>  #include <plat/ehci-orion.h>
> @@ -616,7 +617,11 @@ int __init orion5x_find_tclk(void)
>  static void orion5x_timer_init(void)
>  {
>  	orion5x_tclk = orion5x_find_tclk();
> -	orion_time_init(IRQ_ORION5X_BRIDGE, orion5x_tclk);
> +
> +	orion_time_init((void __iomem *)ORION5X_BRIDGE_VIRT_BASE,
> +			BRIDGE_INT_TIMER1_CLR,
> +			(void __iomem *)TIMER_VIRT_BASE,
> +			IRQ_ORION5X_BRIDGE, orion5x_tclk);
>  }
>  
>  struct sys_timer orion5x_timer = {
> diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> index 5c9744c..e15a8e0 100644
> --- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
> @@ -24,12 +24,8 @@
>  
>  #define POWER_MNG_CTRL_REG	(ORION5X_BRIDGE_VIRT_BASE | 0x11C)
>  
> -#define BRIDGE_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x110)
>  #define WDT_INT_REQ		0x0008
>  
> -#define BRIDGE_MASK		(ORION5X_BRIDGE_VIRT_BASE | 0x114)
> -#define BRIDGE_INT_TIMER0	0x0002
> -#define BRIDGE_INT_TIMER1	0x0004
>  #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
>  
>  #define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x200)
> diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orion/include/plat/time.h
> index c06ca35..2cf3f4d 100644
> --- a/arch/arm/plat-orion/include/plat/time.h
> +++ b/arch/arm/plat-orion/include/plat/time.h
> @@ -11,7 +11,9 @@
>  #ifndef __PLAT_TIME_H
>  #define __PLAT_TIME_H
>  
> -void orion_time_init(unsigned int irq, unsigned int tclk);
> +void
> +orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
> +		void __iomem *_timer_base, unsigned int irq, unsigned int tclk);
>  
>  
>  #endif
> diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
> index 715a301..914b88f 100644
> --- a/arch/arm/plat-orion/time.c
> +++ b/arch/arm/plat-orion/time.c
> @@ -18,28 +18,42 @@
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <asm/mach/time.h>
> -#include <mach/bridge-regs.h>
> -#include <mach/hardware.h>
>  
>  /*
> - * Number of timer ticks per jiffy.
> + * MBus bridge block registers.
>   */
> -static u32 ticks_per_jiffy;
> +#define BRIDGE_CAUSE_OFF	0x0110
> +#define BRIDGE_MASK_OFF		0x0114
> +#define  BRIDGE_INT_TIMER0	 0x0002
> +#define  BRIDGE_INT_TIMER1	 0x0004
>  
>  
>  /*
>   * Timer block registers.
>   */
> -#define TIMER_CTRL		(TIMER_VIRT_BASE + 0x0000)
> -#define  TIMER0_EN		0x0001
> -#define  TIMER0_RELOAD_EN	0x0002
> -#define  TIMER1_EN		0x0004
> -#define  TIMER1_RELOAD_EN	0x0008
> -#define TIMER0_RELOAD		(TIMER_VIRT_BASE + 0x0010)
> -#define TIMER0_VAL		(TIMER_VIRT_BASE + 0x0014)
> -#define TIMER1_RELOAD		(TIMER_VIRT_BASE + 0x0018)
> -#define TIMER1_VAL		(TIMER_VIRT_BASE + 0x001c)
> +#define TIMER_CTRL_OFF		0x0000
> +#define  TIMER0_EN		 0x0001
> +#define  TIMER0_RELOAD_EN	 0x0002
> +#define  TIMER1_EN		 0x0004
> +#define  TIMER1_RELOAD_EN	 0x0008
> +#define TIMER0_RELOAD_OFF	0x0010
> +#define TIMER0_VAL_OFF		0x0014
> +#define TIMER1_RELOAD_OFF	0x0018
> +#define TIMER1_VAL_OFF		0x001c
> +
> +
> +/*
> + * SoC-specific data.
> + */
> +static void __iomem *bridge_base;
> +static u32 bridge_timer1_clr_mask;
> +static void __iomem *timer_base;
> +
> +
> +/*
> + * Number of timer ticks per jiffy.
> + */
> +static u32 ticks_per_jiffy;
>  
>  
>  /*
> @@ -57,7 +71,8 @@ static unsigned long tclk2ns_scale;
>  
>  unsigned long long sched_clock(void)
>  {
> -	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
> +	unsigned long val = readl(timer_base + TIMER0_VAL_OFF);
> +	unsigned long long v = cnt32_to_63(0xffffffff - val);
>  	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
>  }
>  
> @@ -78,6 +93,7 @@ static void __init setup_sched_clock(unsigned long tclk)
>  	v <<= TCLK2NS_SCALE_FACTOR;
>  	v += tclk/2;
>  	do_div(v, tclk);
> +
>  	/*
>  	 * We want an even value to automatically clear the top bit
>  	 * returned by cnt32_to_63() without an additional run time
> @@ -97,7 +113,7 @@ static void __init setup_sched_clock(unsigned long tclk)
>   */
>  static cycle_t orion_clksrc_read(struct clocksource *cs)
>  {
> -	return 0xffffffff - readl(TIMER0_VAL);
> +	return 0xffffffff - readl(timer_base + TIMER0_VAL_OFF);
>  }
>  
>  static struct clocksource orion_clksrc = {
> @@ -128,23 +144,23 @@ orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
>  	/*
>  	 * Clear and enable clockevent timer interrupt.
>  	 */
> -	writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
> +	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
>  
> -	u = readl(BRIDGE_MASK);
> +	u = readl(bridge_base + BRIDGE_MASK_OFF);
>  	u |= BRIDGE_INT_TIMER1;
> -	writel(u, BRIDGE_MASK);
> +	writel(u, bridge_base + BRIDGE_MASK_OFF);
>  
>  	/*
>  	 * Setup new clockevent timer value.
>  	 */
> -	writel(delta, TIMER1_VAL);
> +	writel(delta, timer_base + TIMER1_VAL_OFF);
>  
>  	/*
>  	 * Enable the timer.
>  	 */
> -	u = readl(TIMER_CTRL);
> +	u = readl(timer_base + TIMER_CTRL_OFF);
>  	u = (u & ~TIMER1_RELOAD_EN) | TIMER1_EN;
> -	writel(u, TIMER_CTRL);
> +	writel(u, timer_base + TIMER_CTRL_OFF);
>  
>  	local_irq_restore(flags);
>  
> @@ -162,37 +178,38 @@ orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  		/*
>  		 * Setup timer to fire at 1/HZ intervals.
>  		 */
> -		writel(ticks_per_jiffy - 1, TIMER1_RELOAD);
> -		writel(ticks_per_jiffy - 1, TIMER1_VAL);
> +		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
> +		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
>  
>  		/*
>  		 * Enable timer interrupt.
>  		 */
> -		u = readl(BRIDGE_MASK);
> -		writel(u | BRIDGE_INT_TIMER1, BRIDGE_MASK);
> +		u = readl(bridge_base + BRIDGE_MASK_OFF);
> +		writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
>  
>  		/*
>  		 * Enable timer.
>  		 */
> -		u = readl(TIMER_CTRL);
> -		writel(u | TIMER1_EN | TIMER1_RELOAD_EN, TIMER_CTRL);
> +		u = readl(timer_base + TIMER_CTRL_OFF);
> +		writel(u | TIMER1_EN | TIMER1_RELOAD_EN,
> +		       timer_base + TIMER_CTRL_OFF);
>  	} else {
>  		/*
>  		 * Disable timer.
>  		 */
> -		u = readl(TIMER_CTRL);
> -		writel(u & ~TIMER1_EN, TIMER_CTRL);
> +		u = readl(timer_base + TIMER_CTRL_OFF);
> +		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
>  
>  		/*
>  		 * Disable timer interrupt.
>  		 */
> -		u = readl(BRIDGE_MASK);
> -		writel(u & ~BRIDGE_INT_TIMER1, BRIDGE_MASK);
> +		u = readl(bridge_base + BRIDGE_MASK_OFF);
> +		writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
>  
>  		/*
>  		 * ACK pending timer interrupt.
>  		 */
> -		writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
> +		writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
>  
>  	}
>  	local_irq_restore(flags);
> @@ -212,7 +229,7 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
>  	/*
>  	 * ACK timer interrupt and call event handler.
>  	 */
> -	writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
> +	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
>  	orion_clkevt.event_handler(&orion_clkevt);
>  
>  	return IRQ_HANDLED;
> @@ -224,32 +241,41 @@ static struct irqaction orion_timer_irq = {
>  	.handler	= orion_timer_interrupt
>  };
>  
> -void __init orion_time_init(unsigned int irq, unsigned int tclk)
> +void __init
> +orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
> +		void __iomem *_timer_base, unsigned int irq, unsigned int tclk)
>  {
>  	u32 u;
>  
> +	/*
> +	 * Set SoC-specific data.
> +	 */
> +	bridge_base = _bridge_base;
> +	bridge_timer1_clr_mask = _bridge_timer1_clr_mask;
> +	timer_base = _timer_base;
> +
>  	ticks_per_jiffy = (tclk + HZ/2) / HZ;
>  
>  	/*
> -	 * Set scale and timer for sched_clock
> +	 * Set scale and timer for sched_clock.
>  	 */
>  	setup_sched_clock(tclk);
>  
>  	/*
>  	 * Setup free-running clocksource timer (interrupts
> -	 * disabled.)
> +	 * disabled).
>  	 */
> -	writel(0xffffffff, TIMER0_VAL);
> -	writel(0xffffffff, TIMER0_RELOAD);
> -	u = readl(BRIDGE_MASK);
> -	writel(u & ~BRIDGE_INT_TIMER0, BRIDGE_MASK);
> -	u = readl(TIMER_CTRL);
> -	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);
> +	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
> +	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
> +	u = readl(bridge_base + BRIDGE_MASK_OFF);
> +	writel(u & ~BRIDGE_INT_TIMER0, bridge_base + BRIDGE_MASK_OFF);
> +	u = readl(timer_base + TIMER_CTRL_OFF);
> +	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, timer_base + TIMER_CTRL_OFF);
>  	orion_clksrc.mult = clocksource_hz2mult(tclk, orion_clksrc.shift);
>  	clocksource_register(&orion_clksrc);
>  
>  	/*
> -	 * Setup clockevent timer (interrupt-driven.)
> +	 * Setup clockevent timer (interrupt-driven).
>  	 */
>  	setup_irq(irq, &orion_timer_irq);
>  	orion_clkevt.mult = div_sc(tclk, NSEC_PER_SEC, orion_clkevt.shift);
> -- 
> 
