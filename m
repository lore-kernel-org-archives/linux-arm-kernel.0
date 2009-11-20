From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 20:27:34 +0100
Subject: RFC [PATCH 3/9] Added core lpc32xx architecture files
In-Reply-To: <20091120101022.GA10644@n2100.arm.linux.org.uk>
References: <083DF309106F364B939360100EC290F804F54D560C@eu1rdcrdc1wx030.exi.nxp.com>
	<20091120101022.GA10644@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F804F5545BD1@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Thanks for posting these patches.
> 
> On Fri, Nov 20, 2009 at 02:11:21AM +0100, Kevin Wells wrote:
> > +/*
> > + * I2C busses
> > + */
> > +static void i2c_clock_get_name(char *name, int id)
> > +{
> > +       snprintf(name, 10, "i2c%d_ck", id);
> > +}
> > +
> > +static int i2c_set_clock_run(struct platform_device *pdev)
> > +{
> > +       struct clk *clk;
> > +       char name[10];
> > +       int retval = 0;
> > +
> > +       i2c_clock_get_name(name, pdev->id);
> > +       clk = clk_get(&pdev->dev, name);
> > +       if (!IS_ERR(clk)) {
> > +               clk_set_rate(clk, 1);
> > +               clk_put(clk);
> > +       } else
> > +               retval = -ENOENT;
> > +
> > +       return retval;
> > +}
> > +
> > +static int i2c_set_clock_stop(struct platform_device *pdev)
> > +{
> > +       struct clk *clk;
> > +       char name[10];
> > +       int retval = 0;
> > +
> > +       i2c_clock_get_name(name, pdev->id);
> > +       clk = clk_get(&pdev->dev, name);
> > +       if (!IS_ERR(clk)) {
> > +               clk_set_rate(clk, 0);
> > +               clk_put(clk);
> > +       } else
> > +               retval = -ENOENT;
> > +
> > +       return retval;
> > +}
> 
> This is interesting for the following reasons:
> 
> 1. you don't need to generate unique clock names based on the device.
> 2. you should be using clk_enable() and clk_disable() to turn the
>    turn the clock on and off, rather than clk_set_rate()
> 3. I can see no reason why these should not be in the I2C driver itself.
> 
> I think I know why this is happening, which is because mach-pnx4008
> didn't get properly reviewed in these respects before it went in.
> 
> What I would like to do is to see whether we can get the existing PNX I2C
> driver fixed up before we merge this; essentially I want to stop the
> current issue getting any bigger than it currently is, thereby requiring
> even more work to resolve.
> 

This was setup based on legacy support for the pnx-i2c driver. I'm happy
this is being updated! I'll set up the initial release to use the updates
when they become available.

> > +static inline void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
> > +       unsigned pin, int input)
> > +{
> > +       if (input)
> > +               writel((1 << pin), group->gpio_grp->dir_clr);
> > +       else
> > +               writel((1 << pin), group->gpio_grp->dir_set);
> 
> Parens are not required around function (or macro) arguments when calling
> them.  (In the case of macros, they should always internally use parens
> around arguments.  IOW:
> 
> #define foo(x, y)	((x) * (y))
> 
> so that foo(5 + 6, 1 + 2) results in 33 and not 13.)
> 
> Something else you may wish to consider is changing the 'inline' to
> 'noinline' temporarily, and check the assembly.  I suspect writing these
> functions like the following will result in smaller and faster code:
> 
> 	void __iomem *reg;
> 
> 	if (input)
> 		reg = group->gpio_grp->dir_clr;
> 	else
> 		reg = group->gpio_grp->dir_set;
> 
> 	writel(1 << pin, reg);
> 

Will do!

> > diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
> > new file mode 100644
> > index 0000000..44772ce
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/irq.c
> > @@ -0,0 +1,247 @@
> > +/*
> > + *  linux/arch/arm/mach-lpc32xx/irq.c
> > + *
> > + *  Copyright (C) 2009 NXP Semiconductors
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
> > +#include <linux/mm.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/list.h>
> > +#include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/device.h>
> > +#include <linux/irq.h>
> > +#include <mach/hardware.h>
> > +#include <asm/io.h>
> 
> Should be linux/io.h
> 
> > +#include <asm/setup.h>
> > +#include <asm/mach-types.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/page.h>
> > +#include <asm/system.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/irq.h>
> > +#include <asm/mach/map.h>
> > +#include <mach/irqs.h>
> > +#include <mach/platform.h>
> 
> Are you sure all these includes are needed?  Please eliminate unnecessary
> includes.

I'll check them and remove as necessary.

> 
> > diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-
> lpc32xx/serial.c
> > new file mode 100644
> > index 0000000..e2bfe49
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/serial.c
> > @@ -0,0 +1,211 @@
> > +/*
> > + *  linux/arch/arm/mach-lpc32xx/serial.c
> > + *
> > + *  Copyright (C) 2009 NXP Semiconductors
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
> > +
> > +#include <mach/platform.h>
> > +#include <mach/io.h>
> 
> Should be linux/io.h
> 
> > +#include "common.h"
> > +
> > +#define UARTCTL_CLKMODE(x)     (x + 0x04)
> > +
> > +/* Standard 8250/16550 compatible serial ports */
> > +static struct plat_serial8250_port serial_std_platform_data[] = {
> > +#if defined (CONFIG_MACH_LPC32XX_UART5_ENABLE)
> > +       {
> > +               .membase        = (void *) io_p2v(UART5_BASE),
> > +               .mapbase        = UART5_BASE,
> > +               .irq            = IRQ_UART_IIR5,
> > +               .uartclk        = MAIN_OSC_FREQ,
> > +               .regshift       = 2,
> > +               .iotype         = UPIO_MEM32,
> > +               .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                       UPF_SKIP_TEST,
> > +       },
> > +#endif
> > +#if defined (CONFIG_MACH_LPC32XX_UART3_ENABLE)
> > +       {
> > +               .membase        = (void *) io_p2v(UART3_BASE),
> > +               .mapbase        = UART3_BASE,
> > +               .irq            = IRQ_UART_IIR3,
> > +               .uartclk        = MAIN_OSC_FREQ,
> > +               .regshift       = 2,
> > +               .iotype         = UPIO_MEM32,
> > +               .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                       UPF_SKIP_TEST,
> > +       },
> > +#endif
> > +#if defined (CONFIG_MACH_LPC32XX_UART4_ENABLE)
> > +       {
> > +               .membase        = (void *) io_p2v(UART4_BASE),
> > +               .mapbase        = UART4_BASE,
> > +               .irq            = IRQ_UART_IIR4,
> > +               .uartclk        = MAIN_OSC_FREQ,
> > +               .regshift       = 2,
> > +               .iotype         = UPIO_MEM32,
> > +               .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                       UPF_SKIP_TEST,
> > +       },
> > +#endif
> > +#if defined (CONFIG_MACH_LPC32XX_UART6_ENABLE)
> > +       {
> > +               .membase        = (void *) io_p2v(UART6_BASE),
> > +               .mapbase        = UART6_BASE,
> > +               .irq            = IRQ_UART_IIR6,
> > +               .uartclk        = MAIN_OSC_FREQ,
> > +               .regshift       = 2,
> > +               .iotype         = UPIO_MEM32,
> > +               .flags          = UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> > +                                       UPF_SKIP_TEST,
> > +       },
> > +#endif
> > +       { },
> > +};
> > +
> > +static struct platform_device serial_std_platform_device = {
> > +       .name                   = "serial8250",
> > +       .id                     = 0,
> > +       .dev                    = {
> > +               .platform_data  = serial_std_platform_data,
> > +       },
> > +};
> > +
> > +static struct platform_device* lpc32xx_serial_devs[] = {
> > +       &serial_std_platform_device,
> > +};
> > +
> > +void __init serial_init(void)
> > +{
> > +       u32 tmp, rate;
> > +       struct clk *clk;
> > +       int i;
> > +
> > +       /* Get the current peripheral clock - if the clock can't be
> fetched,
> > +          use the main oscillator as the base clock. */
> > +       clk = clk_get(NULL, "pclk_ck");
> > +       if (IS_ERR(clk))
> > +               rate = MAIN_OSC_FREQ;
> > +       else
> > +       {
> > +               rate = clk_get_rate(clk);
> > +               clk_put(clk);
> > +       }
> > +       if (rate == 0)
> > +               rate = MAIN_OSC_FREQ;
> 
> Similar concerns about clk API here.

This one doesn't actually have a platform device. This is used for early
init of the serial ports (uses 8250/16550 driver) and populates the
serial platform device uartclk field with the current system clockspeed
for those devices. There is a direct function for reading the PCLK rate
used as the clock basis for these devices, I'll use it instead and dump
all the clk_ functions here.

> 
> > diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-
> lpc32xx/timer.c
> > new file mode 100644
> > index 0000000..0f434b0
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/timer.c
> > @@ -0,0 +1,194 @@
> > +/*
> > + *  linux/arch/arm/mach-lpc32xx/timer.c
> > + *
> > + *  Copyright (C) 2009 NXP Semiconductors
> > + *  Copyright (C) 2009 Fontys University of Applied Sciences, Eindhoven
> > + *                     Ed Schouten <e.schouten@fontys.nl>
> > + *                     Laurens Timmermans <l.timmermans@fontys.nl>
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
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/time.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <asm/io.h>
> 
> linux/io.h

I'll fix all these.

> 
> > +#include <asm/irq.h>
> > +
> > +#include <asm/mach/time.h>
> > +
> > +#include <mach/platform.h>
> > +#include <mach/clock.h>
> > +#include "common.h"
> > +
> > +#define TIMER0_IOBASE io_p2v(TIMER0_BASE)
> > +#define TIMER1_IOBASE io_p2v(TIMER1_BASE)
> > +
> > +extern int clk_is_sysclk_mainosc(void);
> > +extern u32 local_clk_get_pllrate_from_reg(u32 inputclk, u32 regval);
> > +extern u32 clk_get_pclk_div(void);
> 
> externs should be in a header file (common.h ?).
> 
> > +
> > +static struct clock_event_device lpc32xx_clkevt;
> 
> I don't think this is required.

I'll review and fix these.
