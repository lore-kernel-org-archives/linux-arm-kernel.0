From: alchark@gmail.com (Alexey Charkov)
Date: Mon, 12 Jul 2010 21:41:56 +0400
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <201007121906.52483.marek.vasut@gmail.com>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007121906.52483.marek.vasut@gmail.com>
Message-ID: <AANLkTin6kZShnrVJFotiCmIyNCTKPRcLc2L5yc7pWtFi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good night Marek, and thanks for looking at the patch!

I will drop other pieces of the patch to reduce traffic and only
retain those with your comments below:

2010/7/12 Marek Vasut <marek.vasut@gmail.com>:
> Dne Po 12. ?ervence 2010 18:50:25 Alexey Charkov napsal(a):
>> diff --git a/arch/arm/mach-vt8500/include/mach/io.h
>> b/arch/arm/mach-vt8500/include/mach/io.h new file mode 100644
>> index 0000000..dc2181a
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/include/mach/io.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * ?arch/arm/mach-vt8500/include/mach/io.h
>> + *
>> + * ?Copyright (C) 2003 ARM Limited
>
> Really? You just copied it ?
>

Yes, this is straight from mach-versatile.

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307
>> USA + */
>> +#ifndef __ASM_ARM_ARCH_IO_H
>> +#define __ASM_ARM_ARCH_IO_H
>> +
>> +#define IO_SPACE_LIMIT 0xffffffff
>> +
>> +#define __io(a) ? ? ? ? ? ? ?__typesafe_io(a)
>> +#define __mem_pci(a) (a)
>> +
>> +#endif
>> diff --git a/arch/arm/mach-vt8500/include/mach/memory.h
>> b/arch/arm/mach-vt8500/include/mach/memory.h new file mode 100644
>> index 0000000..175f914
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/include/mach/memory.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * ?arch/arm/mach-vt8500/include/mach/memory.h
>> + *
>> + * ?Copyright (C) 2003 ARM Limited
>
> DTTO ?
>

Yep, again mach-versatile

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307
>> USA + */
>> +#ifndef __ASM_ARCH_MEMORY_H
>> +#define __ASM_ARCH_MEMORY_H
>> +
>> +/*
>> + * Physical DRAM offset.
>> + */
>> +#define PHYS_OFFSET ?UL(0x00000000)
>> +
>> +#endif
>> diff --git a/arch/arm/mach-vt8500/include/mach/timex.h
>> b/arch/arm/mach-vt8500/include/mach/timex.h new file mode 100644
>> index 0000000..ff209d8
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/include/mach/timex.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * ?arch/arm/mach-vt8500/include/mach/timex.h
>> + *
>> + * ?Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307
>> USA + */
>> +
>
> #ifndef MACH_TIMEX
> #define MACH_TIMEX
>
>> +#define CLOCK_TICK_RATE ? ? ? ? ? ? ?(3000000)
>
> #endif
>
> Maybe ?
>

Looks reasonable, shall I add those checks? Frankly, I have not found
out where it is used, yet... Neither Versatile nor Realview have
ifndefs here.

>> diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h
>> b/arch/arm/mach-vt8500/include/mach/uncompress.h new file mode 100644
>> index 0000000..3f14bf1
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
>> @@ -0,0 +1,46 @@
>> +/* arch/arm/mach-vt8500/include/mach/uncompress.h
>> + *
>> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * Based on arch/arm/mach-dove/include/mach/uncompress.h
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <mach/vt8500.h>
>> +
>> +#define UART_THR ((volatile unsigned char *)(VT8500_UART0_BASE + 0x0))
>> +#define UART_LSR ((volatile unsigned char *)(VT8500_UART0_BASE + 0x24))
>
> Can't you use some better accessors here ?

This one just follows mach-dove. Shall I change these to inline
function helpers?

>> +
>> +#define LSR_THRE ? ? 0x1f
>> +
>> +static void putc(const char c)
>> +{
>> + ? ? int i;
>> +
>> + ? ? for (i = 0; i < 0x1000; i++) {
>> + ? ? ? ? ? ? /* Transmit fifo not full? */
>> + ? ? ? ? ? ? if (*UART_LSR & LSR_THRE)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? }
>> +
>> + ? ? *UART_THR = c;
>> +}
>> +
>> +static void flush(void)
>> +{
>> +}
>> +
>> +/*
>> + * nothing to do
>> + */
>> +#define arch_decomp_setup()
>> +#define arch_decomp_wdog()

>> diff --git a/arch/arm/mach-vt8500/timer.c b/arch/arm/mach-vt8500/timer.c
>> new file mode 100644
>> index 0000000..817edc8
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/timer.c
>> @@ -0,0 +1,185 @@
>> +/*
>> + * ?arch/arm/mach-vt8500/timer.c
>> + *
>> + * ?Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307
>> USA + */
>> +
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/cnt32_to_63.h>
>> +
>> +#include <asm/mach/time.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/irqs.h>
>> +#include <mach/vt8500.h>
>> +
>> +#define VT8500_TIMER_OFFSET ?0x0100
>> +#define TIMER_MATCH_VAL ? ? ? ? ? ? ?0x0000
>> +#define TIMER_COUNT_VAL ? ? ? ? ? ? ?0x0010
>> +#define TIMER_STATUS_VAL ? ? 0x0014
>> +#define TIMER_IER_VAL ? ? ? ? ? ? ? ?0x001c ? ? ? ? ?/* interrupt enable */
>> +#define TIMER_CTRL_VAL ? ? ? ? ? ? ? 0x0020
>> +#define TIMER_AS_VAL ? ? ? ? 0x0024 ? ? ? ? ?/* access status */
>> +#define TIMER_COUNT_R_ACTIVE (1 << 5) ? ? ? ?/* not ready for read */
>> +#define TIMER_COUNT_W_ACTIVE (1 << 4) ? ? ? ?/* not ready for write */
>> +#define TIMER_MATCH_W_ACTIVE (1 << 0) ? ? ? ?/* not ready for write */
>> +#define VT8500_TIMER_HZ ? ? ? ? ? ? ?3000000
>> +void __iomem* regbase = (void __iomem *)(IO_ADDRESS(VT8500_PMC_BASE)
>> + ? ? ? ? ? ? ? ? ? ? + VT8500_TIMER_OFFSET);
>> +
>> +unsigned long long sched_clock(void)
>> +{
>> + ? ? unsigned long long v;
>> +
>> + ? ? writel(0x3, regbase + TIMER_CTRL_VAL);
>> + ? ? while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
>> + ? ? ? ? ? ? /* wait and poll */;
>> +
>> + ? ? v = cnt32_to_63(readl(regbase + TIMER_COUNT_VAL));
>> +
>> + ? ? /* the <<1 gets rid of the cnt_32_to_63 top bit saving on a bic insn*/
>> + ? ? v *= 1000<<1; ? ? ? ? ? /* 3MHz timer tick implies 333ns resolution */
>> + ? ? do_div(v, 3<<1);
>
> Did you run checkpatch here ... or on this patch ?
>

Yes, I did, and fixed all positives except for the volatile pointers
in accessors of uncompress.h that you've commented on above. As I have
no idea why those keywords were added in the first place, I decided to
retain them.

>> +
>> + ? ? return v;
>> +}
>> +
>> +static int vt8500_timer_set_next_event(unsigned long cycles,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *evt)
>> +{
>> + ? ? unsigned long now, alarm;
>> + ? ? int late;
>> +
>> + ? ? writel(3, regbase + TIMER_CTRL_VAL);
>> + ? ? while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
>> + ? ? ? ? ? ? /* wait and poll */;
>> + ? ? now = readl(regbase + TIMER_COUNT_VAL);
>> + ? ? alarm = now + cycles;
>> + ? ? while (readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
>> + ? ? ? ? ? ? /* wait and poll */;
>> + ? ? writel(alarm, regbase + TIMER_MATCH_VAL);
>> +
>> + ? ? writel(3, regbase + TIMER_CTRL_VAL);
>> + ? ? while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
>> + ? ? ? ? ? ? /* wait and poll */;
>> + ? ? now = readl(regbase + TIMER_COUNT_VAL);
>> + ? ? late = now - alarm;
>> + ? ? if (late >= (-2) && late < VT8500_TIMER_HZ*5)
>> + ? ? ? ? ? ? return -ETIME;
>> +
>> + ? ? writel(1, regbase + TIMER_IER_VAL);
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void vt8500_timer_set_mode(enum clock_event_mode mode,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *evt)
>> +{
>> + ? ? switch (mode) {
>> + ? ? case CLOCK_EVT_MODE_RESUME:
>> + ? ? case CLOCK_EVT_MODE_PERIODIC:
>> + ? ? ? ? ? ? break;
>> + ? ? case CLOCK_EVT_MODE_ONESHOT:
>> + ? ? ? ? ? ? writel(readl(regbase + TIMER_CTRL_VAL) | 1,
>> + ? ? ? ? ? ? ? ? ? ? regbase + TIMER_CTRL_VAL);
>> + ? ? ? ? ? ? writel(0, regbase + TIMER_IER_VAL);
>> + ? ? ? ? ? ? break;
>> + ? ? case CLOCK_EVT_MODE_UNUSED:
>> + ? ? case CLOCK_EVT_MODE_SHUTDOWN:
>> + ? ? ? ? ? ? writel(readl(regbase + TIMER_CTRL_VAL) & ~1,
>> + ? ? ? ? ? ? ? ? ? ? regbase + TIMER_CTRL_VAL);
>> + ? ? ? ? ? ? break;
>> + ? ? }
>> +}
>> +
>> +struct clock_event_device clockevent = {
>> + ? ? .name ? ? ? ? ? = "vt8500_timer",
>> + ? ? .features ? ? ? = CLOCK_EVT_FEAT_ONESHOT,
>> + ? ? .rating ? ? ? ? = 200,
>> + ? ? .set_next_event = vt8500_timer_set_next_event,
>> + ? ? .set_mode ? ? ? = vt8500_timer_set_mode,
>> +};
>> +
>> +static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
>> +{
>> + ? ? struct clock_event_device *evt = dev_id;
>> + ? ? evt->event_handler(evt);
>> + ? ? writel(0xf, regbase + TIMER_STATUS_VAL);
>> +
>> + ? ? return IRQ_HANDLED;
>> +}
>> +
>> +static cycle_t vt8500_timer_read(struct clocksource *cs)
>> +{
>> + ? ? writel(3, regbase + TIMER_CTRL_VAL);
>> + ? ? while (readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
>> + ? ? ? ? ? ? /* wait and poll */;
>> + ? ? return readl(regbase + TIMER_COUNT_VAL);
>> +}
>> +
>> +struct clocksource clocksource = {
>> + ? ? .name ? ? ? ? ? = "vt8500_timer",
>> + ? ? .rating ? ? ? ? = 200,
>> + ? ? .read ? ? ? ? ? = vt8500_timer_read,
>> + ? ? .mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
>> + ? ? .flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
>> +};
>> +struct irqaction irq = {
>> + ? ? .name ? ?= "vt8500_timer",
>> + ? ? .flags ? = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
>> + ? ? .handler = vt8500_timer_interrupt,
>> + ? ? .dev_id ?= &clockevent,
>> +};
>> +
>> +static void __init vt8500_timer_init(void)
>> +{
>> + ? ? int res;
>> +
>> + ? ? struct clock_event_device *ce = &clockevent;
>> + ? ? struct clocksource *cs = &clocksource;
>> + ? ? writel(1, regbase + TIMER_CTRL_VAL);
>> + ? ? writel(0xf, regbase + TIMER_STATUS_VAL);
>> + ? ? writel(~0, regbase + TIMER_MATCH_VAL);
>> +
>> + ? ? clockevents_calc_mult_shift(ce, VT8500_TIMER_HZ, 4);
>> + ? ? clocksource_calc_mult_shift(cs, VT8500_TIMER_HZ, 4);
>> +
>> + ? ? /* copy-pasted from mach-msm; no idea */
>> + ? ? ce->max_delta_ns =
>> + ? ? ? ? ? ? clockevent_delta2ns(0xf0000000, ce);
>> + ? ? ce->min_delta_ns = clockevent_delta2ns(4, ce);
>> + ? ? ce->cpumask = cpumask_of(0);
>> +
>> + ? ? res = clocksource_register(cs);
>> + ? ? if (res)
>> + ? ? ? ? ? ? printk(KERN_ERR "vt8500_timer_init: clocksource_register "
>> + ? ? ? ? ? ? ? ? ? ? "failed for %s\n", cs->name);
>> +
>> + ? ? res = setup_irq(IRQ_PMCOS0, &irq);
>> +
>> + ? ? if (res)
>> + ? ? ? ? ? ? printk(KERN_ERR "vt8500_timer_init: setup_irq "
>> + ? ? ? ? ? ? ? ? ? ? "failed for %s\n", cs->name);
>> + ? ? clockevents_register_device(ce);
>> +}
>> +
>> +struct sys_timer vt8500_timer = {
>> + ? ? .init = vt8500_timer_init
>> +};

>> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
>> index 8f10d24..f5745d1 100644
>> --- a/arch/arm/tools/mach-types
>> +++ b/arch/arm/tools/mach-types
>
> This should be dropped but you probably know that :)
>
Ok, no problem :)

>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 8b23165..5993659 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1351,6 +1351,16 @@ config SERIAL_MSM_CONSOLE
>> ? ? ? depends on SERIAL_MSM=y
>> ? ? ? select SERIAL_CORE_CONSOLE
>>
>> +config SERIAL_VT8500
>> + ? ? bool "VIA VT8500 on-chip serial port support"
>> + ? ? depends on ARM && ARCH_VT8500
>> + ? ? select SERIAL_CORE
>> +
>> +config SERIAL_VT8500_CONSOLE
>> + ? ? bool "VIA VT8500 serial console support"
>> + ? ? depends on SERIAL_VT8500=y
>> + ? ? select SERIAL_CORE_CONSOLE
>> +
>> ?config SERIAL_NETX
>> ? ? ? tristate "NetX serial port support"
>> ? ? ? depends on ARM && ARCH_NETX
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index 208a855..0e8f7b0 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -84,3 +84,4 @@ obj-$(CONFIG_SERIAL_TIMBERDALE) ? ? += timbuart.o
>> ?obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
>> ?obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
>> ?obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
>> +obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o
>
> Possibly move the serial driver into another patch ... split this into patch
> series :)
>

I'll probably try to. There are some traces of serial in the platform
files as well, though.

>> diff --git a/drivers/serial/vt8500_serial.c
>> b/drivers/serial/vt8500_serial.c new file mode 100644
>> index 0000000..21e0462
>> --- /dev/null
>> +++ b/drivers/serial/vt8500_serial.c
>> @@ -0,0 +1,612 @@
>> +/*
>> + * drivers/serial/vt8500_serial.c
>> + *
>> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * Based on msm_serial.c, which is:
>> + * Copyright (C) 2007 Google, Inc.
>> + * Author: Robert Love <rlove@google.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#if defined(CONFIG_SERIAL_VT8500_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>> +# define SUPPORT_SYSRQ
>> +#endif
>> +
>> +#include <linux/hrtimer.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <linux/irq.h>
>> +#include <linux/init.h>
>> +#include <linux/console.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial.h>
>> +#include <linux/clk.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <mach/vt8500.h>
>> +
>> +struct vt8500_port {
>> + ? ? struct uart_port ? ? ? ?uart;
>> + ? ? char ? ? ? ? ? ? ? ? ? ?name[16];
>> + ? ? struct clk ? ? ? ? ? ? ?*clk;
>> + ? ? unsigned int ? ? ? ? ? ?ier;
>> +};
>> +
>> +#define UART_TO_VT8500(uart_port) ? ?((struct vt8500_port *) uart_port)
>> +
>> +static inline void vt8500_write(struct uart_port *port, unsigned int val,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int off)
>> +{
>> + ? ? __raw_writel(val, port->membase + off);
>> +}
>> +
>> +static inline unsigned int vt8500_read(struct uart_port *port, unsigned
>> int off) +{
>> + ? ? return __raw_readl(port->membase + off);
>> +}
>> +
>> +static void vt8500_stop_tx(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? vt8500_port->ier &= ~1;
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> +}
>> +
>> +static void vt8500_start_tx(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? vt8500_port->ier |= 1;
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> +}
>> +
>> +static void vt8500_stop_rx(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? vt8500_port->ier &= ~2;
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> +}
>> +
>> +static void vt8500_enable_ms(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? vt8500_port->ier |= (1 << 10);
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> +}
>
> Won't "inline" help here performance-wise?
>

Quite possibly. Doesn't GCC auto-inline it with -O2/-Os, though?
Should I add "inline" explicitly?

>> +
>> +static void handle_rx(struct uart_port *port)
>> +{
>> + ? ? struct tty_struct *tty = port->state->port.tty;
>> +
>> + ? ? /*
>> + ? ? ?* Handle overrun
>> + ? ? ?*/
>> + ? ? if ((vt8500_read(port, VT8500_URISR) & (1 << 7))) {
>> + ? ? ? ? ? ? port->icount.overrun++;
>> + ? ? ? ? ? ? tty_insert_flip_char(tty, 0, TTY_OVERRUN);
>> + ? ? }
>> +
>> + ? ? /* and now the main RX loop */
>> + ? ? while (vt8500_read(port, VT8500_URUSR) & (1 << 3)) {
>> + ? ? ? ? ? ? unsigned int c;
>> + ? ? ? ? ? ? char flag = TTY_NORMAL;
>> +
>> + ? ? ? ? ? ? c = vt8500_read(port, VT8500_URRDR);
>> +
>> + ? ? ? ? ? ? /* Mask conditions we're ignorning. */
>> + ? ? ? ? ? ? c &= ~port->read_status_mask;
>> +
>> + ? ? ? ? ? ? if (c & (1 << 9)) {
>> + ? ? ? ? ? ? ? ? ? ? port->icount.frame++;
>> + ? ? ? ? ? ? ? ? ? ? flag = TTY_FRAME;
>> + ? ? ? ? ? ? } else if (c & (1 << 8)) {
>> + ? ? ? ? ? ? ? ? ? ? port->icount.parity++;
>> + ? ? ? ? ? ? ? ? ? ? flag = TTY_PARITY;
>> + ? ? ? ? ? ? } else
>> + ? ? ? ? ? ? ? ? ? ? port->icount.rx++;
>> +
>> + ? ? ? ? ? ? if (!uart_handle_sysrq_char(port, c))
>> + ? ? ? ? ? ? ? ? ? ? tty_insert_flip_char(tty, c, flag);
>> + ? ? }
>> +
>> + ? ? tty_flip_buffer_push(tty);
>> +}
>> +
>> +static void handle_tx(struct uart_port *port)
>> +{
>> + ? ? struct circ_buf *xmit = &port->state->xmit;
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> + ? ? int sent_tx;
>> +
>> + ? ? if (port->x_char) {
>> + ? ? ? ? ? ? vt8500_write(port, port->x_char, VT8500_URTDR);
>> + ? ? ? ? ? ? port->icount.tx++;
>> + ? ? ? ? ? ? port->x_char = 0;
>> + ? ? }
>> +
>> + ? ? while (!(vt8500_read(port, VT8500_URUSR) & 2)) {
>> + ? ? ? ? ? ? if (uart_circ_empty(xmit)) {
>> + ? ? ? ? ? ? ? ? ? ? /* disable tx interrupts */
>> + ? ? ? ? ? ? ? ? ? ? vt8500_port->ier &= ~1;
>> + ? ? ? ? ? ? ? ? ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? vt8500_write(port, xmit->buf[xmit->tail], VT8500_URTDR);
>> +
>> + ? ? ? ? ? ? xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>> + ? ? ? ? ? ? port->icount.tx++;
>> + ? ? ? ? ? ? sent_tx = 1;
>> + ? ? }
>> +
>> + ? ? if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> + ? ? ? ? ? ? uart_write_wakeup(port);
>> +}
>> +
>> +static void handle_delta_cts(struct uart_port *port)
>> +{
>> + ? ? port->icount.cts++;
>> + ? ? wake_up_interruptible(&port->state->port.delta_msr_wait);
>> +}
>> +
>> +static irqreturn_t vt8500_irq(int irq, void *dev_id)
>> +{
>> + ? ? struct uart_port *port = dev_id;
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> + ? ? unsigned int isr;
>> +
>> + ? ? spin_lock(&port->lock);
>> + ? ? isr = vt8500_read(port, VT8500_URISR);
>> + ? ? vt8500_write(port, 0, VT8500_URIER); /* disable interrupt */
>> +
>> + ? ? if (isr & 2)
>> + ? ? ? ? ? ? handle_rx(port);
>> + ? ? if (isr & 1)
>> + ? ? ? ? ? ? handle_tx(port);
>> + ? ? if (isr & (1 << 10))
>> + ? ? ? ? ? ? handle_delta_cts(port);
>> +
>> + ? ? /* restore interrupt */
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> + ? ? spin_unlock(&port->lock);
>> +
>> + ? ? return IRQ_HANDLED;
>> +}
>> +
>> +static unsigned int vt8500_tx_empty(struct uart_port *port)
>> +{
>> + ? ? return (vt8500_read(port, VT8500_URUSR) & 2) ? 0 : TIOCSER_TEMT;
>> +}
>> +
>> +static unsigned int vt8500_get_mctrl(struct uart_port *port)
>> +{
>> + ? ? return TIOCM_CTS | TIOCM_RTS;
>> +}
>> +
>> +static void vt8500_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
>> + ? ? unsigned int lcr;
>> +
>> + ? ? lcr = vt8500_read(port, VT8500_URLCR);
>> +
>> + ? ? if (!(mctrl & TIOCM_RTS)) {
>> + ? ? ? ? ? ? lcr &= ~(1 << 6);
>> + ? ? ? ? ? ? vt8500_write(port, lcr, VT8500_URLCR);
>> + ? ? } else {
>> + ? ? ? ? ? ? lcr |= (1 << 6);
>> + ? ? ? ? ? ? vt8500_write(port, lcr, VT8500_URLCR);
>> + ? ? }
>> +}
>> +
>> +static void vt8500_break_ctl(struct uart_port *port, int break_ctl)
>> +{
>> + ? ? if (break_ctl)
>> + ? ? ? ? ? ? vt8500_write(port, vt8500_read(port, VT8500_URLCR) | (1 << 9),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?VT8500_URLCR);
>> +}
>> +
>> +static int vt8500_set_baud_rate(struct uart_port *port, unsigned int baud)
>> +{
>> + ? ? unsigned int div = vt8500_read(port, VT8500_URDIV) & ~(0x3ff);
>> +
>> + ? ? if (unlikely((baud < 900) || (baud > 921600)))
>> + ? ? ? ? ? ? div |= 7;
>> + ? ? else
>> + ? ? ? ? ? ? div |= (921600 / baud) - 1;
>> +
>> + ? ? while (vt8500_read(port, VT8500_URUSR) & (1 << 5))
>> + ? ? ? ? ? ? ;
>> + ? ? vt8500_write(port, div, VT8500_URDIV);
>> +
>> + ? ? return baud;
>> +}
>> +
>> +static int vt8500_startup(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> + ? ? int ret;
>> +
>> + ? ? snprintf(vt8500_port->name, sizeof(vt8500_port->name),
>> + ? ? ? ? ? ? ?"vt8500_serial%d", port->line);
>> +
>> + ? ? ret = request_irq(port->irq, vt8500_irq, IRQF_TRIGGER_HIGH,
>> + ? ? ? ? ? ? ? ? ? ? ? vt8500_port->name, port);
>> + ? ? if (unlikely(ret))
>> + ? ? ? ? ? ? return ret;
>> +
>> + ? ? vt8500_write(port, 0x03, VT8500_URLCR); /* enable TX & RX */
>> +
>> + ? ? /* turn on RX and CTS interrupts */
>> + ? ? vt8500_port->ier = (2) | (1 << 10);
>> + ? ? vt8500_write(port, vt8500_port->ier, VT8500_URIER);
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void vt8500_shutdown(struct uart_port *port)
>> +{
>> + ? ? struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? vt8500_port->ier = 0;
>> + ? ? vt8500_write(port, 0, VT8500_URIER); /* disable interrupts */
>> +
>> + ? ? free_irq(port->irq, port);
>> +}
>> +
>> +static void vt8500_set_termios(struct uart_port *port, struct ktermios
>> *termios, + ? ? ? ? ? ? ? ? ? ? ? struct ktermios *old)
>> +{
>> + ? ? unsigned long flags;
>> + ? ? unsigned int baud, lcr;
>> +
>> + ? ? spin_lock_irqsave(&port->lock, flags);
>> +
>> + ? ? /* calculate and set baud rate */
>> + ? ? baud = uart_get_baud_rate(port, termios, old, 900, 921600);
>> + ? ? baud = vt8500_set_baud_rate(port, baud);
>> + ? ? if (tty_termios_baud_rate(termios))
>> + ? ? ? ? ? ? tty_termios_encode_baud_rate(termios, baud, baud);
>> +
>> + ? ? /* calculate parity */
>> + ? ? lcr = vt8500_read(port, VT8500_URLCR);
>> + ? ? lcr &= ~((1 << 5) | (1 << 4));
>> + ? ? if (termios->c_cflag & PARENB) {
>> + ? ? ? ? ? ? lcr |= (1 << 4);
>> + ? ? ? ? ? ? if (termios->c_cflag & PARODD)
>> + ? ? ? ? ? ? ? ? ? ? lcr |= (1 << 5);
>> + ? ? }
>> +
>> + ? ? /* calculate bits per char */
>> + ? ? lcr &= ~(1 << 2);
>> + ? ? switch (termios->c_cflag & CSIZE) {
>> + ? ? case CS7:
>> + ? ? ? ? ? ? break;
>> + ? ? case CS8:
>> + ? ? default:
>> + ? ? ? ? ? ? lcr |= (1 << 2);
>> + ? ? ? ? ? ? break;
>> + ? ? }
>> +
>> + ? ? /* calculate stop bits */
>> + ? ? lcr &= ~(1 << 3);
>> + ? ? if (termios->c_cflag & CSTOPB)
>> + ? ? ? ? ? ? lcr |= (1 << 3);
>> +
>> + ? ? /* set parity, bits per char, and stop bit */
>> + ? ? vt8500_write(port, lcr, VT8500_URLCR);
>> +
>> + ? ? /* Configure status bits to ignore based on termio flags. */
>> + ? ? port->read_status_mask = 0;
>> + ? ? if (termios->c_iflag & INPCK)
>> + ? ? ? ? ? ? port->read_status_mask |= (1 << 9) | (1 << 8);
>> +
>> + ? ? uart_update_timeout(port, termios->c_cflag, baud);
>> +
>> + ? ? spin_unlock_irqrestore(&port->lock, flags);
>> +}
>> +
>> +static const char *vt8500_type(struct uart_port *port)
>> +{
>> + ? ? return "VT8500";
>> +}
>> +
>> +static void vt8500_release_port(struct uart_port *port)
>> +{
>> + ? ? struct platform_device *pdev = to_platform_device(port->dev);
>> + ? ? struct resource *resource;
>> + ? ? resource_size_t size;
>> +
>> + ? ? resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? if (unlikely(!resource))
>> + ? ? ? ? ? ? return;
>> + ? ? size = resource->end - resource->start + 1;
>> +
>> + ? ? release_mem_region(port->mapbase, size);
>> + ? ? iounmap(port->membase);
>> + ? ? port->membase = NULL;
>> +}
>> +
>> +static int vt8500_request_port(struct uart_port *port)
>> +{
>> + ? ? struct platform_device *pdev = to_platform_device(port->dev);
>> + ? ? struct resource *resource;
>> + ? ? resource_size_t size;
>> +
>> + ? ? resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? if (unlikely(!resource))
>> + ? ? ? ? ? ? return -ENXIO;
>> + ? ? size = resource->end - resource->start + 1;
>> +
>> + ? ? if (unlikely(!request_mem_region(port->mapbase, size, "vt8500_serial")))
>> + ? ? ? ? ? ? return -EBUSY;
>> +
>> + ? ? port->membase = ioremap(port->mapbase, size);
>> + ? ? if (!port->membase) {
>> + ? ? ? ? ? ? release_mem_region(port->mapbase, size);
>> + ? ? ? ? ? ? return -EBUSY;
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void vt8500_config_port(struct uart_port *port, int flags)
>> +{
>> + ? ? if (flags & UART_CONFIG_TYPE) {
>> + ? ? ? ? ? ? port->type = PORT_VT8500;
>> + ? ? ? ? ? ? vt8500_request_port(port);
>> + ? ? }
>> +}
>> +
>> +static int vt8500_verify_port(struct uart_port *port, struct serial_struct
>> *ser) +{
>> + ? ? if (unlikely(ser->type != PORT_UNKNOWN && ser->type != PORT_VT8500))
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? if (unlikely(port->irq != ser->irq))
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? return 0;
>> +}
>> +
>> +static struct uart_ops vt8500_uart_pops = {
>> + ? ? .tx_empty = vt8500_tx_empty,
>> + ? ? .set_mctrl = vt8500_set_mctrl,
>> + ? ? .get_mctrl = vt8500_get_mctrl,
>> + ? ? .stop_tx = vt8500_stop_tx,
>> + ? ? .start_tx = vt8500_start_tx,
>> + ? ? .stop_rx = vt8500_stop_rx,
>> + ? ? .enable_ms = vt8500_enable_ms,
>> + ? ? .break_ctl = vt8500_break_ctl,
>> + ? ? .startup = vt8500_startup,
>> + ? ? .shutdown = vt8500_shutdown,
>> + ? ? .set_termios = vt8500_set_termios,
>> + ? ? .type = vt8500_type,
>> + ? ? .release_port = vt8500_release_port,
>> + ? ? .request_port = vt8500_request_port,
>> + ? ? .config_port = vt8500_config_port,
>> + ? ? .verify_port = vt8500_verify_port,
>> +};
>> +
>> +static struct vt8500_port vt8500_uart_ports[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .uart = {
>> + ? ? ? ? ? ? ? ? ? ? .iotype = UPIO_MEM,
>> + ? ? ? ? ? ? ? ? ? ? .ops = &vt8500_uart_pops,
>> + ? ? ? ? ? ? ? ? ? ? .flags = UPF_BOOT_AUTOCONF,
>> + ? ? ? ? ? ? ? ? ? ? .fifosize = 16,
>> + ? ? ? ? ? ? ? ? ? ? .line = 0,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .uart = {
>> + ? ? ? ? ? ? ? ? ? ? .iotype = UPIO_MEM,
>> + ? ? ? ? ? ? ? ? ? ? .ops = &vt8500_uart_pops,
>> + ? ? ? ? ? ? ? ? ? ? .flags = UPF_BOOT_AUTOCONF,
>> + ? ? ? ? ? ? ? ? ? ? .fifosize = 16,
>> + ? ? ? ? ? ? ? ? ? ? .line = 1,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .uart = {
>> + ? ? ? ? ? ? ? ? ? ? .iotype = UPIO_MEM,
>> + ? ? ? ? ? ? ? ? ? ? .ops = &vt8500_uart_pops,
>> + ? ? ? ? ? ? ? ? ? ? .flags = UPF_BOOT_AUTOCONF,
>> + ? ? ? ? ? ? ? ? ? ? .fifosize = 16,
>> + ? ? ? ? ? ? ? ? ? ? .line = 2,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .uart = {
>> + ? ? ? ? ? ? ? ? ? ? .iotype = UPIO_MEM,
>> + ? ? ? ? ? ? ? ? ? ? .ops = &vt8500_uart_pops,
>> + ? ? ? ? ? ? ? ? ? ? .flags = UPF_BOOT_AUTOCONF,
>> + ? ? ? ? ? ? ? ? ? ? .fifosize = 16,
>> + ? ? ? ? ? ? ? ? ? ? .line = 3,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> +};
>> +
>> +#define UART_NR ? ? ?ARRAY_SIZE(vt8500_uart_ports)
>> +
>> +static inline struct uart_port *get_port_from_line(unsigned int line)
>> +{
>> + ? ? return &vt8500_uart_ports[line].uart;
>> +}
>> +
>> +#ifdef CONFIG_SERIAL_VT8500_CONSOLE
>> +
>> +static void vt8500_console_putchar(struct uart_port *port, int c)
>> +{
>> + ? ? while (vt8500_read(port, VT8500_URUSR) & 2) /* Transmitter busy */
>> + ? ? ? ? ? ? ;
>> + ? ? vt8500_write(port, c, VT8500_URTDR);
>> +}
>> +
>> +static void vt8500_console_write(struct console *co, const char *s,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int count)
>> +{
>> + ? ? struct uart_port *port;
>> + ? ? struct vt8500_port *vt8500_port;
>> +
>> + ? ? BUG_ON(co->index < 0 || co->index >= UART_NR);
>> +
>> + ? ? port = get_port_from_line(co->index);
>> + ? ? vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? spin_lock(&port->lock);
>> + ? ? uart_console_write(port, s, count, vt8500_console_putchar);
>> + ? ? spin_unlock(&port->lock);
>> +}
>> +
>> +static int __init vt8500_console_setup(struct console *co, char *options)
>> +{
>> + ? ? struct uart_port *port;
>> + ? ? int baud, flow, bits, parity;
>> + ? ? unsigned int tmp;
>> +
>> + ? ? if (unlikely(co->index >= UART_NR || co->index < 0))
>> + ? ? ? ? ? ? return -ENXIO;
>> +
>> + ? ? port = get_port_from_line(co->index);
>> +
>> + ? ? if (unlikely(!port->membase))
>> + ? ? ? ? ? ? return -ENXIO;
>> +
>> + ? ? port->cons = co;
>> +
>> + ? ? if (options)
>> + ? ? ? ? ? ? uart_parse_options(options, &baud, &parity, &bits, &flow);
>> +
>> + ? ? bits = 8;
>> + ? ? parity = 'n';
>> + ? ? flow = 'n';
>> + ? ? tmp = vt8500_read(port, VT8500_URLCR) & ~((1 << 5) | (1 << 4));
>> + ? ? vt8500_write(port, tmp, VT8500_URLCR); ?/* 8N1 */
>> +
>> + ? ? if (baud < 28800 || baud > 921600)
>> + ? ? ? ? ? ? baud = 115200;
>> + ? ? vt8500_set_baud_rate(port, baud);
>> +
>> + ? ? printk(KERN_INFO "vt8500_serial: console setup on port #%d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? port->line);
>> +
>> + ? ? return uart_set_options(port, co, baud, parity, bits, flow);
>> +}
>> +
>> +static struct uart_driver vt8500_uart_driver;
>> +
>> +static struct console vt8500_console = {
>> + ? ? .name = "ttyS",
>> + ? ? .write = vt8500_console_write,
>> + ? ? .device = uart_console_device,
>> + ? ? .setup = vt8500_console_setup,
>> + ? ? .flags = CON_PRINTBUFFER,
>> + ? ? .index = -1,
>> + ? ? .data = &vt8500_uart_driver,
>> +};
>> +
>> +#define VT8500_CONSOLE ? ? ? (&vt8500_console)
>> +
>> +#else
>> +#define VT8500_CONSOLE ? ? ? NULL
>> +#endif
>> +
>> +static struct uart_driver vt8500_uart_driver = {
>> + ? ? .owner = THIS_MODULE,
>> + ? ? .driver_name = "vt8500_serial",
>> + ? ? .dev_name = "ttyS",
>> + ? ? .nr = UART_NR,
>> + ? ? .cons = VT8500_CONSOLE,
>> +};
>> +
>> +static int __init vt8500_serial_probe(struct platform_device *pdev)
>> +{
>> + ? ? struct vt8500_port *vt8500_port;
>> + ? ? struct resource *resource;
>> + ? ? struct uart_port *port;
>> + ? ? int irq;
>> +
>> + ? ? if (unlikely(pdev->id < 0 || pdev->id >= UART_NR))
>> + ? ? ? ? ? ? return -ENXIO;
>> +
>> + ? ? printk(KERN_INFO "vt8500_serial: detected port #%d\n", pdev->id);
>> +
>> + ? ? port = get_port_from_line(pdev->id);
>> + ? ? port->dev = &pdev->dev;
>> + ? ? vt8500_port = UART_TO_VT8500(port);
>> +
>> + ? ? resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? if (unlikely(!resource))
>> + ? ? ? ? ? ? return -ENXIO;
>> + ? ? port->mapbase = resource->start;
>> +
>> + ? ? irq = platform_get_irq(pdev, 0);
>> + ? ? if (unlikely(irq < 0))
>> + ? ? ? ? ? ? return -ENXIO;
>> + ? ? port->irq = irq;
>> +
>> + ? ? platform_set_drvdata(pdev, port);
>> +
>> + ? ? return uart_add_one_port(&vt8500_uart_driver, port);
>> +}
>> +
>> +static int __devexit vt8500_serial_remove(struct platform_device *pdev)
>> +{
>> + ? ? return 0;
>> +}
>> +
>> +static struct platform_driver vt8500_platform_driver = {
>> + ? ? .remove = vt8500_serial_remove,
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "vt8500_serial",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? },
>> +};
>> +
>> +static int __init vt8500_serial_init(void)
>> +{
>> + ? ? int ret;
>> +
>> + ? ? ret = uart_register_driver(&vt8500_uart_driver);
>> + ? ? if (unlikely(ret))
>> + ? ? ? ? ? ? return ret;
>> +
>> + ? ? ret = platform_driver_probe(&vt8500_platform_driver,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? vt8500_serial_probe);
>> +
>> + ? ? if (unlikely(ret))
>> + ? ? ? ? ? ? uart_unregister_driver(&vt8500_uart_driver);
>> +
>> + ? ? printk(KERN_INFO "vt8500_serial: driver initialized\n");
>> +
>> + ? ? return ret;
>> +}
>> +
>> +static void __exit vt8500_serial_exit(void)
>> +{
>> +#ifdef CONFIG_SERIAL_VT8500_CONSOLE
>> + ? ? unregister_console(&vt8500_console);
>> +#endif
>> + ? ? platform_driver_unregister(&vt8500_platform_driver);
>> + ? ? uart_unregister_driver(&vt8500_uart_driver);
>> +}
>> +
>> +module_init(vt8500_serial_init);
>> +module_exit(vt8500_serial_exit);
>> +
>> +MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
>> +MODULE_DESCRIPTION("Driver for vt8500 serial device");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index f10db6e..20ba8c3 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -186,6 +186,9 @@
>> ?#define PORT_ALTERA_JTAGUART 91
>> ?#define PORT_ALTERA_UART ? ? 92
>>
>> +/* VIA VT8500 SoC */
>> +#define PORT_VT8500 ? ?93
>> +
>> ?#ifdef __KERNEL__
>>
>> ?#include <linux/compiler.h>
>
> This patch looks very good otherwise, good night ! :)

Thanks :)
