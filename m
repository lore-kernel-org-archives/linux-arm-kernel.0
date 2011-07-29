From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Jul 2011 10:40:45 -0600
Subject: [PATCH v2 2/7] ARM: mmp: parse timer configuration from DT
In-Reply-To: <1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110729164045.GK11164@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 02:41:28PM +0800, Haojian Zhuang wrote:
> Parse timer configuration from DT. Now we can merge pxa910_timer and
> mmp2_timer into mmp_timer. Since most configuration between these two
> timers are same. The difference is recorded in DT.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  .../devicetree/bindings/arm/marvell/timer.txt      |   24 +++++++++
>  arch/arm/mach-mmp/common.h                         |    2 +
>  arch/arm/mach-mmp/time.c                           |   50 +++++++++++++++++++-
>  3 files changed, 75 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/timer.txt b/Documentation/devicetree/bindings/arm/marvell/timer.txt
> new file mode 100644
> index 0000000..24a6f97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/timer.txt
> @@ -0,0 +1,24 @@
> +* Timer Controller Binding for ARCH-MMP
> +
> +This binding specifies what properties must be available in device tree
> +representation of an ARCH-MMP compliant timer controller.
> +
> +Required properties:
> +
> +	- compatible: Specifies the compatibility list of the timer controller.
> +	  The type shall be <string> and the value shall be
> +	  "mrvl,pxa168-timer".
> +
> +	- mrvl,clk-conf: Specifies the address and value of timer 
> +	  configuration register.
> +	  The type shall be <prop-encoded-array>. The first value indicates
> +	  the physical address of timer configuration register. The second
> +	  value indicates data should be written to timer configuration
> +	  register.
> +
> +* Example
> +
> +	mmp_timer: {
> +		compatible = "mrvl,pxa168-timer";
> +		mrvl,clk-conf = <0xd4000034 0x33>;
> +	};
> diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
> index 1c563c2..890c664 100644
> --- a/arch/arm/mach-mmp/common.h
> +++ b/arch/arm/mach-mmp/common.h
> @@ -2,6 +2,8 @@
>  
>  struct sys_timer;
>  
> +extern struct sys_timer mmp_timer;
> +
>  extern void timer_init(int irq);
>  
>  extern void __init icu_init_irq(void);
> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 99833b9..5a90b27 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -25,6 +25,8 @@
>  
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/sched.h>
>  
>  #include <asm/sched_clock.h>
> @@ -150,7 +152,7 @@ static void __init timer_config(void)
>  
>  	__raw_writel(cer & ~0x1, TIMERS_VIRT_BASE + TMR_CER); /* disable */
>  
> -	ccr &= (cpu_is_mmp2()) ? TMR_CCR_CS_0(0) : TMR_CCR_CS_0(3);
> +	ccr &= TMR_CCR_CS_0(0);
>  	__raw_writel(ccr, TIMERS_VIRT_BASE + TMR_CCR);
>  
>  	/* free-running mode */
> @@ -187,3 +189,49 @@ void __init timer_init(int irq)
>  	clocksource_register_hz(&cksrc, CLOCK_TICK_RATE);
>  	clockevents_register_device(&ckevt);
>  }
> +
> +#ifdef CONFIG_OF
> +static void __init mmp_timer_init(void)
> +{
> +	struct device_node *np;
> +	const __be32 *clk_offs;
> +	void __iomem *conf;
> +	unsigned int addr = 0, offs = 0;
> +	int size, irq;
> +
> +	np = of_find_compatible_node(NULL, NULL, "mrvl,pxa168-timer");
> +
> +	BUG_ON(!np);
> +
> +	of_node_get(np);
> +	irq = irq_of_parse_and_map(np, 0);
> +
> +	clk_offs = of_get_property(np, "mrvl,clk-conf", &size);
> +	if ((clk_offs == NULL) || (size != sizeof(int) * 2)) {

sizeof(u32)

I would recommend using of_property_read_u32_array() which does the
sanity checking for you.

> +		pr_warn("mmp-timer: mrvl,clk-conf property is wrong\n");
> +		goto out;
> +	}
> +	addr = be32_to_cpu(*clk_offs) & PAGE_MASK;
> +	offs = be32_to_cpu(*clk_offs) - addr;
> +	conf = ioremap(addr, PAGE_SIZE);

base addresses should be in a 'reg' property.  I would put the
register region into a 'reg' tuple so that of_iomap() works, and then
encode just the offset/config-value pair into mrvl,clk-conf.

> +	if (conf == NULL) {
> +		pr_warn("mmp-timer: failed on mapping 0x%x\n", (uint32_t)conf);
> +		goto out;
> +	}
> +	/* reset and configure */
> +	__raw_writel(APBC_APBCLK | APBC_RST, conf + offs);
> +	__raw_writel(be32_to_cpu(*++clk_offs), conf + offs);
> +	__raw_readl(conf + offs);
> +	iounmap(conf);
> +
> +	timer_init(irq);
> +	return;
> +out:
> +	of_node_put(np);
> +	return;
> +}
> +
> +struct sys_timer mmp_timer = {
> +	.init	= mmp_timer_init,
> +};
> +#endif
> -- 
> 1.5.6.5
> 
