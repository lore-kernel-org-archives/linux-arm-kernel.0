From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 00:06:20 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <1342363754-30808-2-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
Message-ID: <CACRpkdZup6OuKcr-VafrB_irau7WRqL+v1URbm1+=ScM6pM6DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 4:49 PM, Florian Fainelli <florian@openwrt.org> wrote:

> diff --git a/arch/arm/mach-mcs814x/clock.c b/arch/arm/mach-mcs814x/clock.c

As mentioned by other reviewers, move this to the new common
clock framework. I just migrated the Integrator, Nomadik and U300
for the v3.7 merge window, we need to get rid of these
implementations, not make more of them.

> diff --git a/arch/arm/mach-mcs814x/common.c b/arch/arm/mach-mcs814x/common.c

Usually this kind of file is called "core.c".

> +void __init mcs814x_init_machine(void)
> +{
> +       u32 bs2, cpu_mode;
> +       int gpio;
> +
> +       bs2 = __raw_readl(mcs814x_sysdbg_base + SYSDBG_BS2);
> +       cpu_mode = (bs2 >> CPU_MODE_SHIFT) & CPU_MODE_MASK;
> +
> +       pr_info("CPU mode: %s\n", cpu_modes[cpu_mode].name);
> +
> +       /* request the gpios since the pins are muxed for functionnality */
> +       for (gpio = cpu_modes[cpu_mode].gpio_start;
> +               gpio == cpu_modes[cpu_mode].gpio_end; gpio++) {
> +               if (gpio != -1)
> +                       gpio_request(gpio, cpu_modes[cpu_mode].name);
> +       }
> +}

What is this? It is looking very suspiciouly much like a pin multiplexer,
which means it should have a driver in drivers/pinctrl/pinctrl-foo.c not
in arch/arm/*.

I do understand it is just a small hack to make things work, but I fear
it is going to grow and then it sets a bad example.

This version looks like switching some I2S, GPIO and UART and that's
all, but I highly suspect that is not the whole story, is it? Better
to get it in right shape from the start.

> diff --git a/arch/arm/mach-mcs814x/irq.c b/arch/arm/mach-mcs814x/irq.c
> new file mode 100644
> index 0000000..089937b
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/irq.c
(...)
> +       /* Clear all interrupts */
> +       __raw_writel(0xffffffff, base + MCS814X_IRQ_ICR);

Consider writel_relaxed()

> diff --git a/arch/arm/mach-mcs814x/include/mach/entry-macro.S b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..cbad566
> --- /dev/null
> +++ b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> @@ -0,0 +1,29 @@
> +#include <mach/mcs814x.h>
> +                .macro  disable_fiq
> +                .endm
> +
> +               .macro arch_ret_to_user, tmp1, tmp2
> +               .endm
> +
> +               .macro  get_irqnr_preamble, base, tmp
> +               ldr     \base, =mcs814x_intc_base@ base virtual address of INTC
> +               ldr     \base, [\base]
> +               .endm
> +
> +               .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +               mov     \tmp, #MCS814X_IRQ_STS0  @ load tmp with STS0 register offset
> +               ldr     \irqstat, [\base, \tmp]  @ load value at base + tmp
> +               tst     \irqstat, \irqstat       @ test if no active IRQ's
> +               beq     1002f                    @ if no active irqs return with status 0
> +               mov     \irqnr, #0               @ start from irq zero
> +               mov     \tmp,   #1               @ the mask initially 1
> +1001:
> +               tst     \irqstat, \tmp           @ and with mask
> +               addeq   \irqnr, \irqnr, #1       @ if  zero then add one to nr
> +               moveq   \tmp,   \tmp, lsl #1     @ shift mask one to left
> +               beq     1001b                    @ if  zero then loop again
> +               mov     \irqstat, \tmp           @ save the return mask
> +               mov     \tmp, #MCS814X_IRQ_STS0  @ load tmp with ICR offset
> +               str     \irqstat,  [\base, \tmp] @ clear irq with selected mask
> +1002:
> +                .endm

Don't do this. Delete this file.

Let your platform select MULTI_IRQ_HANDLER
Then let your platform MACHINE_START (or DT_MACHINE_START)
have a .handle_irq member, calling a function from your interrupt controller
driver to handle the IRQs.

Add some
asmlinkage void __exception_irq_entry foo_handle_irq(struct pt_regs *regs)

And rewrite the entry handler in plain C.

Refer to for example the rewrite I do of the FPGA IRQ controller in commit
3108e6ab21a9b9dbd88f0b2ff99f73e95b8b1580 or directly to
arch/arm/plat-versatile/fpga-irq.c or
arch/arm/common/vic.c for an example.

> diff --git a/arch/arm/mach-mcs814x/timer.c b/arch/arm/mach-mcs814x/timer.c

A timer driver not #including <linux/clockchips.h> and <linux/clocksource.h>
is a real bad idea.

(...)
> +static inline unsigned long ticks2usecs(u32 x)
> +{
> +       return x / (clock_rate / 1000000);
> +}
> +
> +/*
> + * Returns number of ms since last clock interrupt.  Note that interrupts
> + * will have been disabled by do_gettimeoffset()
> + */
> +static unsigned long mcs814x_gettimeoffset(void)
> +{
> +       u32 ticks = __raw_readl(mcs814x_timer_base + TIMER_VAL);
> +
> +       if (ticks < last_reload)
> +               return ticks2usecs(ticks + (u32)(0xffffffff - last_reload));
> +       else
> +               return ticks2usecs(ticks - last_reload);
> +}

This is not looking good. Don't handle ticks -> usec conversion in the
driver.

> +static irqreturn_t mcs814x_timer_interrupt(int irq, void *dev_id)
> +{
> +       u32 count = __raw_readl(mcs814x_timer_base + TIMER_VAL);
> +
> +       /* take into account delay up to this moment */
> +       last_reload = count + timer_correct + timer_reload_value;
> +
> +       if (last_reload < timer_reload_value)
> +               last_reload = timer_reload_value;
> +       else if (timer_correct == 0)
> +               timer_correct = __raw_readl(mcs814x_timer_base + TIMER_VAL) -
> +                                       count;

Don't do this. Let the timer infrastructure take care of these
things.

> +       __raw_writel(last_reload, mcs814x_timer_base + TIMER_VAL);
> +
> +       timer_tick();

Only archaic and bad example platforms call timer_tick() directly.
Use the clockevent API.

> +
> +       return IRQ_HANDLED;
> +}
> +
> +static struct irqaction mcs814x_timer_irq = {
> +       .name           = "mcs814x-timer",
> +       .flags          = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +       .handler        = mcs814x_timer_interrupt,
> +};
> +
> +static struct of_device_id mcs814x_timer_ids[] = {
> +       { .compatible = "moschip,mcs814x-timer" },
> +       { /* sentinel */ },
> +};
> +
> +static void __init mcs814x_of_timer_init(void)
> +{
> +       struct device_node *np;
> +       const unsigned int *intspec;
> +
> +       np = of_find_matching_node(NULL, mcs814x_timer_ids);
> +       if (!np)
> +               panic("unable to find compatible timer node in dtb");
> +
> +       mcs814x_timer_base = of_iomap(np, 0);
> +       if (!mcs814x_timer_base)
> +               panic("unable to remap timer cpu registers");
> +
> +       intspec = of_get_property(np, "interrupts", NULL);
> +       if (!intspec)
> +               panic("no interrupts property for timer");
> +
> +       mcs814x_timer_irq.irq = be32_to_cpup(intspec);

Why are you getting and converting this from bigendian?

What is wrong with using irq_of_parse_and_map(np, 0) for this, this
just looks dangerous.

> +}
> +
> +static void __init mcs814x_timer_init(void)
> +{
> +       struct clk *clk;
> +
> +       clk = clk_get_sys("timer0", NULL);
> +       if (IS_ERR_OR_NULL(clk))
> +               panic("unable to get timer0 clock");

clk_prepare_enable() is needed at this point.

> +
> +       clock_rate = clk_get_rate(clk);
> +       clk_put(clk);

Don't put the clock here, you're using it, perpetually. If you
put() it the clock framework can disable it at as unused.

> +
> +       mcs814x_of_timer_init();
> +
> +       pr_info("Timer frequency: %d (kHz)\n", clock_rate / 1000);
> +
> +       timer_reload_value = 0xffffffff - (clock_rate / HZ);
> +
> +       /* disable timer */
> +       __raw_writel(0, mcs814x_timer_base + TIMER_CTL);
> +       __raw_writel(timer_reload_value, mcs814x_timer_base + TIMER_VAL);
> +       last_reload = timer_reload_value;
> +
> +       setup_irq(mcs814x_timer_irq.irq, &mcs814x_timer_irq);
> +       /* enable timer, stop timer in debug mode */
> +       __raw_writel(0x03, mcs814x_timer_base + TIMER_CTL);
> +}
> +
> +struct sys_timer mcs814x_timer = {
> +       .init   = mcs814x_timer_init,
> +       .offset = mcs814x_gettimeoffset,
> +};

No .offset and rewrite this to register a clock source+clock event
and use that instead.

Please look at arch/arm/common/timer-sp.c for a good example
of how a timer driver should look.

You will feel it's much more elegant afterwards :-)

What might be complicated is that it appears you have only one
single timer in your system, is that reallty the case? Usually
Linux fires one timer to just "run free" to be used as cycle counter
(clock source) and another one to "shoot events" (clock event)

I've never seen one and the same timer being used for both
clock source and clock events but if you really have only one
timer I think that is also feasible, but will need some serious
hacking.

Yours,
Linus Walleij
