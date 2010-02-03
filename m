From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 19:43:59 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <20100203155558.GH11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<20100203155558.GH11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B78790@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +static void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
> > +   unsigned pin, int input)
> > +{
> > +   if (input)
> > +           writel(1 << pin, group->gpio_grp->dir_clr);
> readl/writel are used to "perform PCI memory accesses via an ioremap
> region" and "are defined to perform little endian accesses".  I think
> most archs use __raw_readl/__raw_writel here.

There seems to be a lot of intermixing elsewhere in arch/arm where
readl()/writel() is used instead of the __raw() functions. I actually
switched to the non-__raw functions previously. Are the __raw variants
the correct way to go then?


> > +   int state;
> > +
> > +   state = readl(group->gpio_grp->inp_state);
> > +
> > +   /* P3 GPIO pin input mapping is not contiguous */
> > +   if (pin == 5)
> > +           state = (state >> 24) & 1;
> > +   else
> > +           state = (state >> (10 + pin)) & 1;
> The mapping here is different from above in __set_gpio_dir_p3??  Please
> someone kick the responsible hardware designer from me.
>

I've already kicked the ones involved. It's not wrong though, its
designed like that.

> > +                   .request                = lpc32xx_gpio_request,
> > +                   .base                   = GPIO_P0_GRP,
> > +                   .ngpio                  = GPIO_P0_MAX,
> > +                   .names                  = gpio_p0_names,
> > +                   .can_sleep              = 0,
> > +           },
> > +           .gpio_grp = &gpio_grp_regs[0],
> These absolute array references tend to become wrong.  There is no need
> to have them in an array, so why not call it gpio_grp_regs_p0 etc.?
>

Ok

> > +   case IRQ_TYPE_EDGE_FALLING:
> > +           /* Falling edge sensitive */
> > +           reg = readl(ctrl + INTC_POLAR);
> > +           reg &= ~mask;
> > +           writel(reg, (ctrl + INTC_POLAR));
> > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > +           reg |= mask;
> > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > +           set_irq_handler(irq, handle_edge_irq);
> > +           break;
> did you test that you really need handle_edge_irq?  Sane irq controllers
> can (and should) use handle_level_irq for both level and edge sensitive
> irqs.  You only need handle_edge_irq if your controller doesn't remember
> edge transitions while the irq is masked.

This is supported and intended. It's important for slow moving external
GPIO events where you can't clear the active level state or pulse
duration (ie, switches).

>
> > +   case IRQ_TYPE_LEVEL_LOW:
> > +           /* Low level sensitive */
> > +           reg = readl(ctrl + INTC_POLAR);
> > +           reg &= ~mask;
> > +           writel(reg, (ctrl + INTC_POLAR));
> > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > +           reg &= ~mask;
> > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > +           set_irq_handler(irq, handle_level_irq);
> > +           break;
> > +
> > +   case IRQ_TYPE_LEVEL_HIGH:
> > +           /* High level sensitive */
> > +           reg = readl(ctrl + INTC_POLAR);
> > +           reg |= mask;
> > +           writel(reg, (ctrl + INTC_POLAR));
> > +           reg = readl(ctrl + INTC_ACT_TYPE);
> > +           reg &= ~mask;
> > +           writel(reg, (ctrl + INTC_ACT_TYPE));
> > +           set_irq_handler(irq, handle_level_irq);
> > +           break;
> You could increase code sharing here with something like:
>
>       static inline __set_irq_type(unsigned int ctrl, unsigned mask,
> unsigned polar, unsigned acttype)
>       {
>
>               unsigned reg = __raw_readl(ctrl + INTC_POLAR);
>               reg &= ~mask;
>               reg |= polar;
>               __raw_writel(reg, ctrl + INTC_POLAR);
>               reg = __raw_readl(ctrl + INTC_ACT_TYPE);
>               ...
>       }
>
> and then the different cases would only be:
>
>       ...
>       case IRQ_TYPE_LEVEL_HIGH:
>               __set_irq_type(ctrl, mask, mask, 0);
>

Again, some great suggestions. I'm all for making this more readable.

> > +
> > +   /* Other modes are not supported */
> > +   default:
> > +           return -ENOTSUPP;
> > +   }
> I think you need to differenciate between unsupported an invalid types.
> I.e.:
>
>       case IRQ_TYPE_EDGE_BOTH:
>               return -ENOTSUPP;
>
>       default:
>               return -EINVAL;
>
> And I'm not sure if ENOTSUPP is the right value to return.  I grepped a
> bit around and returning -EINVAL for both unsupported and wrong values
> seems common.  (pnx4008_set_irq_type return -1 which looks worse than
> -ENOTSUPP.)
> > +
> > +   return 0;
> > +}
> > +
> > +static void __init lpc32xx_set_default_mappings(unsigned int base,
> > +   unsigned int apr, unsigned int atr, unsigned int offset)
> > +{
> > +   unsigned int i, lvl, type;
> > +
> > +   /* Set activation levels for each interrupt */
> > +   i = 0;
> > +   while (i < 32)  {
> > +           lvl = ((apr >> i) & 0x1) | (((atr >> i) & 0x1) << 1);
> > +           switch (lvl) {
> > +           case 0x0: /* Low polarity and level operation */
> > +                   type = IRQ_TYPE_LEVEL_LOW;
> > +                   break;
> > +
> > +           case 0x1: /* High polarity and level operation */
> > +                   type = IRQ_TYPE_LEVEL_HIGH;
> > +                   break;
> > +
> > +           case 0x2: /* Low polarity and edge operation */
> > +                   type = IRQ_TYPE_EDGE_FALLING;
> > +                   break;
> > +
> > +           case 0x3: /* High polarity and edge operation */
> > +           default:
> > +                   type = IRQ_TYPE_EDGE_RISING;
> > +                   break;
> > +           }
> > +
> > +           lpc32xx_set_irq_type((offset + i), type);
> you could reuse the function I suggested above, here.
>
> > +           i++;
> > +   }
> > +}
> > +
> > +static struct irq_chip lpc32xx_irq_chip = {
> > +   .ack = lpc32xx_mask_ack_irq,
> .ack = ...mask_ack... ?
>
> > +   .mask = lpc32xx_mask_irq,
> > +   .unmask = lpc32xx_unmask_irq,
> > +   .set_type = lpc32xx_set_irq_type,
> > +};
> > +
> > +void __init lpc32xx_init_irq(void)
> > +{
> > +   unsigned int i, vloc;
> > +
> > +   /* Setup MIC */
> > +   vloc = io_p2v(MIC_BASE);
> > +   writel(0, (vloc + INTC_MASK));
> > +   writel(MIC_APR_DEFAULT, (vloc + INTC_POLAR));
> > +   writel(MIC_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> > +
> > +   /* Setup SIC1 */
> > +   vloc = io_p2v(SIC1_BASE);
> > +   writel(0, (vloc + INTC_MASK));
> > +   writel(SIC1_APR_DEFAULT, (vloc + INTC_POLAR));
> > +   writel(SIC1_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> > +
> > +   /* Setup SIC2 */
> > +   vloc = io_p2v(SIC2_BASE);
> > +   writel(0, (vloc + INTC_MASK));
> > +   writel(SIC2_APR_DEFAULT, (vloc + INTC_POLAR));
> > +   writel(SIC2_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> > +
> > +   /* Configure supported IRQ's */
> > +   for (i = 0; i < NR_IRQS; i++) {
> > +           set_irq_flags(i, IRQF_VALID);
> > +           set_irq_chip(i, &lpc32xx_irq_chip);
> > +   }
> > +
> > +   /* Set default mappings */
> > +   lpc32xx_set_default_mappings(io_p2v(MIC_BASE), MIC_APR_DEFAULT,
> > +           MIC_ATR_DEFAULT, 0);
> > +   lpc32xx_set_default_mappings(io_p2v(SIC1_BASE), SIC1_APR_DEFAULT,
> > +           SIC1_ATR_DEFAULT, 32);
> > +   lpc32xx_set_default_mappings(io_p2v(SIC2_BASE), SIC2_APR_DEFAULT,
> > +           SIC2_ATR_DEFAULT, 64);
> > +
> > +   /* mask all interrupts except SUBIRQA and SUBFIQ */
> Why don't you mask all irqs?
>
> > +   writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
> > +                   (1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
> > +           (io_p2v(MIC_BASE) + INTC_MASK));
> I wonder you want s/SUBIRQA/SUBIRQ/ ?

Interrupt banks SIC1 and SIC2 will work, but won't signal events to the
MIC if they are masked. These are globally unmasked and never changed.
The MIC is the only device that can generate an ARM IRQ or FIQ.

>
> > +   writel(0, (io_p2v(SIC1_BASE) + INTC_MASK));
> > +   writel(0, (io_p2v(SIC2_BASE) + INTC_MASK));
> > +}
> > diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-
> lpc32xx/serial.c
> > new file mode 100644
> > index 0000000..1c15121
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/serial.c
> > @@ -0,0 +1,200 @@
> > +/*
> > + * arch/arm/mach-lpc32xx/serial.c
> > + *
> > + * Author: Kevin Wells <kevin.wells@nxp.com>
> > + *
> > + * Copyright (C) 2010 NXP Semiconductors
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> USA
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/serial_reg.h>
> > +#include <linux/serial_8250.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/platform.h>
> > +#include <mach/io.h>
> > +#include "common.h"
> > +
> > +/* Standard 8250/16550 compatible serial ports */
> > +static struct plat_serial8250_port serial_std_platform_data[] = {
> > +#ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
> > +   {
> > +           .membase        = (void *) io_p2v(UART5_BASE),
> > +           .mapbase        = UART5_BASE,
> > +           .irq            = IRQ_UART_IIR5,
> I'd prefix all lpc32xx specific constants with LPC32XX_.
>
> > +           .uartclk        = MAIN_OSC_FREQ,
> MAIN_OSC_FREQ isn't defined yet.
>
> > +           .regshift       = 2,
> > +           .iotype         = UPIO_MEM32,
> > +           .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                   UPF_SKIP_TEST,
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
> > +   {
> > +           .membase        = (void *) io_p2v(UART3_BASE),
> > +           .mapbase        = UART3_BASE,
> > +           .irq            = IRQ_UART_IIR3,
> > +           .uartclk        = MAIN_OSC_FREQ,
> > +           .regshift       = 2,
> > +           .iotype         = UPIO_MEM32,
> > +           .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                   UPF_SKIP_TEST,
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
> > +   {
> > +           .membase        = (void *) io_p2v(UART4_BASE),
> > +           .mapbase        = UART4_BASE,
> > +           .irq            = IRQ_UART_IIR4,
> > +           .uartclk        = MAIN_OSC_FREQ,
> > +           .regshift       = 2,
> > +           .iotype         = UPIO_MEM32,
> > +           .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                   UPF_SKIP_TEST,
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
> > +   {
> > +           .membase        = (void *) io_p2v(UART6_BASE),
> > +           .mapbase        = UART6_BASE,
> > +           .irq            = IRQ_UART_IIR6,
> > +           .uartclk        = MAIN_OSC_FREQ,
> > +           .regshift       = 2,
> > +           .iotype         = UPIO_MEM32,
> > +           .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                   UPF_SKIP_TEST,
> > +   },
> > +#endif
> > +   { },
> > +};
> > +
> > +struct uartinit {
> > +   char *uart_ck_name;
> > +   u32 ck_mode_mask;
> > +   u32 pdiv_clk_reg;
> > +};
> > +
> > +static struct uartinit uartinit_data[] __initdata = {
> > +#ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
> > +   {
> > +           .uart_ck_name = "uart5_ck",
> > +           .ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 5),
> > +           .pdiv_clk_reg = CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE),
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
> > +   {
> > +           .uart_ck_name = "uart3_ck",
> > +           .ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 3),
> > +           .pdiv_clk_reg = CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE),
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
> > +   {
> > +           .uart_ck_name = "uart4_ck",
> > +           .ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 4),
> > +           .pdiv_clk_reg = CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE),
> > +   },
> > +#endif
> > +#ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
> > +   {
> > +           .uart_ck_name = "uart6_ck",
> > +           .ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 6),
> > +           .pdiv_clk_reg = CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE),
> > +   },
> > +#endif
> does the order matter here?  If not, why use 5,3,4,6?
>
> > +};
> > +
> > +static struct platform_device serial_std_platform_device = {
> > +   .name                   = "serial8250",
> > +   .id                     = 0,
> > +   .dev                    = {
> > +           .platform_data  = serial_std_platform_data,
> > +   },
> > +};
> > +
> > +static struct platform_device *lpc32xx_serial_devs[] __initdata = {
> > +   &serial_std_platform_device,
> > +};
> > +
> > +void __init lpc32xx_serial_init(void)
> > +{
> > +   u32 tmp, clkmodes = 0;
> > +   struct clk *clk;
> > +   void *puart;
> > +   int i;
> > +
> > +   /* UART clocks are off, let clock driver manage them */
> > +   __raw_writel(0, CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE));
> > +
> > +   for (i = 0; i < ARRAY_SIZE(uartinit_data); i++) {
> > +           clk = clk_get(NULL, uartinit_data[i].uart_ck_name);
> > +           if (IS_ERR(clk)) {
> > +#ifdef CONFIG_DEBUG_LL
> > +                   /* A clock get failure can mean the console might
> > +                      not work. It's possible this might not even
> > +                      work. */
> > +                   printascii("Serial port clock get failure!\n");
> > +#endif
> > +           } else {
> > +                   clk_enable(clk);
> > +                   serial_std_platform_data[i].uartclk =
> > +                           clk_get_rate(clk);
> IIRC clk_get_rate is only valid for enabled clocks, so you might want to
> check if clk_enable returned 0.
>
> > +           }
> > +
> > +           /* Setup UART clock modes for all UARTs, disable autoclock */
> > +           clkmodes |= uartinit_data[i].ck_mode_mask;
> Do you really want to do this if clk_enable or clk_get failed?
> > +
> > +           /* pre-UART clock divider set to 1 */
> > +           writel(0x0101, uartinit_data[i].pdiv_clk_reg);
> ditto.
>
> > +   }
> > +
> > +   /* This needs to be done after all UART clocks are setup */
> > +   writel(clkmodes, UARTCTL_CLKMODE(io_p2v(UART_CTRL_BASE)));
> > +   for (i = 0; i < ARRAY_SIZE(uartinit_data) - 1; i++) {
> > +           /* Force a flush of the RX FIFOs to work around a HW bug */
> > +           puart = serial_std_platform_data[i].membase;
> > +           writel(0xC1, UART_IIR_FCR(puart));
> > +           writel(0x00, UART_DLL_FIFO(puart));
> > +           clkmodes = 64;
> > +           while (clkmodes--)
> > +                   tmp = readl(UART_DLL_FIFO(puart));
> The variable clkmodes seems to be misused here.  IMHO it should be named
> something like j.  and can i have a
>
>       #define LPC32XX_UART_FIFO_SIZE  64
>
> inclusive usage here?
>
> > +           writel(0, UART_IIR_FCR(puart));
> > +   }
> > +
> > +   /* IrDA pulsing support on UART6. This only enables the IrDA mux */
> > +   tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> > +#ifdef CONFIG_ARCH_LPC32XX_UART6_IRDAMODE
> > +   tmp &= ~UART_UART6_IRDAMOD_BYPASS;
> > +#else
> > +   tmp |= UART_UART6_IRDAMOD_BYPASS;
> > +#endif
> > +   writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> > +
> > +   /* Disable UART5->USB transparent mode or USB won't work */
> > +   tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> > +   tmp &= ~UART_U5_ROUTE_TO_USB;
> > +   writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> > +
> > +   platform_add_devices(lpc32xx_serial_devs,
> > +           ARRAY_SIZE(lpc32xx_serial_devs));
> > +}
> > diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-
> lpc32xx/timer.c
> > new file mode 100644
> > index 0000000..9c06346
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/timer.c
> > @@ -0,0 +1,187 @@
> > +/*
> > + * arch/arm/mach-lpc32xx/timer.c
> > + *
> > + * Author: Kevin Wells <kevin.wells@nxp.com>
> > + *
> > + * Copyright (C) 2009 - 2010 NXP Semiconductors
> > + * Copyright (C) 2009 Fontys University of Applied Sciences, Eindhoven
> > + *                    Ed Schouten <e.schouten@fontys.nl>
> > + *                    Laurens Timmermans <l.timmermans@fontys.nl>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> USA
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/time.h>
> > +#include <linux/err.h>
> > +#include <linux/clockchips.h>
> > +
> > +#include <asm/mach/time.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/platform.h>
> > +#include "common.h"
> > +
> > +#define TIMER0_IOBASE io_p2v(TIMER0_BASE)
> > +#define TIMER1_IOBASE io_p2v(TIMER1_BASE)
> I like the register constants already providing a virtual address.
> Something like:
>
>       #ifndef __REG
>       #ifndef __ASSEMBLY__
>       #define __REG(x) ((void __iomem __force *)io_p2v(x))
>       #else
>       #define __REG(x) io_p2v(x)
>       #endif
>
>       #define LPC32XX_TIMER0_IOBASE __REG(0x4004c000)
>
> And for the few places where a physical address is needed you can define
> __REG(x) to be just x.
>
>
> > +static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
> > +{
> > +   return (cycle_t)readl(TIMER_TC(TIMER1_IOBASE));
> > +}
> > +
> > +static struct clocksource lpc32xx_clksrc = {
> > +   .name   = "lpc32xx_clksrc",
> > +   .shift  = 24,
> > +   .rating = 300,
> > +   .read   = lpc32xx_clksrc_read,
> > +   .mask   = CLOCKSOURCE_MASK(32),
> > +   .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +static int lpc32xx_clkevt_next_event(unsigned long delta,
> > +    struct clock_event_device *dev)
> > +{
> > +   unsigned long flags;
> > +
> > +   if (delta < 1)
> > +           return -ETIME;
> As you set min_delta_ns below you don't need to test it here.
>
> > +   local_irq_save(flags);
> No.  irqs are already disabled by the clock framework.
>
> > +   writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER0_IOBASE));
> > +   writel(delta, TIMER_PR(TIMER0_IOBASE));
> > +   writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER0_IOBASE));
> > +
> > +   local_irq_restore(flags);
> > +
> > +   return 0;
> > +}
> > +
> > +static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
> > +    struct clock_event_device *dev)
> > +{
> > +   switch (mode) {
> > +   case CLOCK_EVT_MODE_PERIODIC:
> > +           WARN_ON(1);
> > +           break;
> > +
> > +   case CLOCK_EVT_MODE_ONESHOT:
> > +   case CLOCK_EVT_MODE_SHUTDOWN:
> > +           /*
> > +            * Disable the timer. When using oneshot, we must also
> > +            * disable the timer to wait for the first call to
> > +            * set_next_event().
> > +            */
> > +           writel(0, TIMER_TCR(TIMER0_IOBASE));
> > +           break;
> > +
> > +   case CLOCK_EVT_MODE_UNUSED:
> > +   case CLOCK_EVT_MODE_RESUME:
> > +           break;
> > +   }
> > +}
> > +
> > +static struct clock_event_device lpc32xx_clkevt = {
> > +   .name           = "lpc32xx_clkevt",
> > +   .features       = CLOCK_EVT_FEAT_ONESHOT,
> > +   .shift          = 32,
> > +   .rating         = 300,
> > +   .set_next_event = lpc32xx_clkevt_next_event,
> > +   .set_mode       = lpc32xx_clkevt_mode,
> > +};
> > +
> > +static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
> > +{
> > +   struct clock_event_device *evt = &lpc32xx_clkevt;
> > +
> > +   /* Clear match */
> > +   writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
> > +
> > +   evt->event_handler(evt);
> > +
> > +   return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction lpc32xx_timer_irq = {
> > +   .name           = "LPC32XX Timer Tick",
> > +   .flags          = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> > +   .handler        = lpc32xx_timer_interrupt,
> > +};
> > +
> > +/*
> > + * The clock management driver isn't initialized at this point, so the
> > + * clocks need to be enabled here manually and then tagged as used in
> > + * the clock driver initialization
> > + */
> > +static void __init lpc32xx_timer_init(void)
> > +{
> > +   u32 clkrate, pllreg;
> > +
> > +   /* Enable timer clock */
> > +   writel(
> > +           (CLKPWR_TMRPWMCLK_TIMER0_EN | CLKPWR_TMRPWMCLK_TIMER1_EN),
> > +           CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE));
> > +
> > +   /* The clock driver isn't initialized at this point. So determine
> if
> > +      the SYSCLK is driven from the PLL397 or main oscillator and then
> use
> > +      it to compute the PLL frequency and the PCLK divider to get the
> base
> > +      timer rates. This rate is needed to compute the tick rate. */
> the common format for multiline comments is
>
>       /*
>        * ...
>        * ...
>        */
>
> > +   if (clk_is_sysclk_mainosc() != 0)
> > +           clkrate = MAIN_OSC_FREQ;
> > +   else
> > +           clkrate = 397 * CLOCK_OSC_FREQ;
> > +
> > +   /* Get ARM HCLKPLL register and convert it into a frequency*/
> missing space -----------------------------------------------------^
>
> > +   pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
> > +   clkrate = clk_get_pllrate_from_reg(clkrate, pllreg);
> > +
> > +   /* Get PCLK divider and divide ARM PLL clock by it to get timer
> rate */
> > +   clkrate = clkrate / clk_get_pclk_div();
> > +
> > +   /* Initial timer setup */
> > +   writel(0, TIMER_TCR(TIMER0_IOBASE));
> > +   writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
> > +   writel(1, TIMER_MR0(TIMER0_IOBASE));
> > +   writel(TIMER_CNTR_MCR_MTCH(0) | TIMER_CNTR_MCR_STOP(0) |
> > +       TIMER_CNTR_MCR_RESET(0), TIMER_MCR(TIMER0_IOBASE));
> > +
> > +   /* Setup tick interrupt */
> > +   setup_irq(IRQ_TIMER0, &lpc32xx_timer_irq);
> > +
> > +   /* Setup the clockevent structure. */
> > +   lpc32xx_clkevt.mult = div_sc(clkrate, NSEC_PER_SEC,
> > +           lpc32xx_clkevt.shift);
> > +   lpc32xx_clkevt.max_delta_ns = clockevent_delta2ns(-1,
> > +           &lpc32xx_clkevt);
> > +   lpc32xx_clkevt.min_delta_ns = clockevent_delta2ns(1,
> &lpc32xx_clkevt);
> For rounding reasons this might not be enough to assert delta being >= 1
> for set_next event.  IIRC you need
>
>       clockevent_delta2ns(1, &lpc32xx_clkevt) + 1
>
> > +   lpc32xx_clkevt.cpumask = cpumask_of(0);
> > +   clockevents_register_device(&lpc32xx_clkevt);
> > +
> > +   /* Use timer1 as clock source. */
> > +   writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER1_IOBASE));
> > +   writel(0, TIMER_PR(TIMER1_IOBASE));
> > +   writel(0, TIMER_MCR(TIMER1_IOBASE));
> > +   writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER1_IOBASE));
> > +   lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
> > +           lpc32xx_clksrc.shift);
> > +   clocksource_register(&lpc32xx_clksrc);
> > +}
> > +
> > +struct sys_timer lpc32xx_timer = {
> > +   .init           = &lpc32xx_timer_init,
> > +};
> Does this work without NO_HZ?  I though you need to setup a periodic
> mode with CONFIG_HZ irqs per second first?

This is handled in the clockevents handler. It will setup the driver
for the next event in the set_next_event callback. I believe the
current CONFIG_HZ rate is set to 100.
