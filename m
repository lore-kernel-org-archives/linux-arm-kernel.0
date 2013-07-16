From: juha.lumme@gmail.com (Juha Lumme)
Date: Tue, 16 Jul 2013 10:59:22 +0900
Subject: Can't get FIQ interrupt to work on i.mx233
Message-ID: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to get my head around FIQ's on imx233, with Maxime Ripard's
article at free electrons (
http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/ )
as my original inspiration.

Unfortunately, for some reason I'm unable to get similar results on my
board (Olimex olinuxino maxi), even though the cpu is very close to
his (he was using imx28).

Im working with 3.10 kernel (Freescales mainline), and I had to add
some code to drivers/irqchip/irq-mxs.c for mxs_icoll_set_irq_fiq. This
is the code I added:
http://codetidy.com/6195/

Maxime used timer 2 to trigger interrupts in his design, but it seems
that in imx233, timer 0 and 2 are being used by the kernel, so I chose
timer3 for my purpose.
According to the reference manual, the mx233 timer3 uses interrupt 31.

As a first step, I'm now just trying to trigger FIQ once, and in FIQ I
want to acknowledge the interrupt, and set GPIO state high.
My driver code looks like this:
http://codetidy.com/6194/

I have carried over a simple header file from 2.6 kernel, that has
register addresses defined, it can be seen here:
http://codetidy.com/6192/

In the driver I:
1. map memory areas for HW_PINCTRL_DOUT1 (to trigger GPIO)
HW_TIMROT_TIMCTRL3 (to initalize timer3 settings) HW_TIMROT_TIMCOUNT3
(setup the actual timer values) HW_ICOLL_INTERRUPT31 (directly access
interrupt 31 register)
2. Reserve and setup the GPIO 38 as output (the pin I want to
trigger), and initialize the timer3 settings.
3. Claim the FIQ, setup it's assembly handler, and pass mapped memory
pointers of HW_PINCTRL_DOUT1 (to trigger gpio) and HW_TIMROT_TIMCTRL3
(to acknowledge the interrupt bit) to the handler via pt_regs struct.
4. Call mxs_icoll_set_irq_fiq(irq) and enable_fiq(irq) to enable the IRQ/FIQ.

For now the assembly handler is only 6 instructions: http://codetidy.com/6193/
I first want to just clear the interrupt bit in HW_ICOLL_INTERRUPT31,
and then I write 0xFF to HW_PINCTRL_DOUT1

Now when I compile this driver to the kernel, I see during the boot
that driver is initialized, and from the register printouts I can see
that timer3 is initialized as I request.
When I cat /proc/interrupts, I can see that my FIQ handler appears installed:
# cat /proc/interrupts
           CPU0
 16:       2082         -  MXS Timer Tick
 17:          0         -  mxs-spi
 18:       2147         -  mxs-dma
118:          0         -  mxs-spi
119:          0         -  mxs-dma
120:          0         -  RTC alarm
124:          0         -  8006c000.serial
127:         76         -  uart-pl011
128:        258         -  ci13xxx_imx
FIQ:              beagle_fiq_handler
Err:          0

In user space, I made a simple register reading application, and when
I read HW_TIMROT_TIMCOUNT3, I can see that as requested first 16 bits
of the register (fixed count part), is set to 4096 (bit 12), and bits
16-31(running count part) vary all the time, so the timer appears
running.
Also, when I read HW_TIMROT_TIMCTRL3 in userspace, I can see that IRQ
bit (bit 15) is now set, implying that timer3 has decremented to 0.
This bit was not set during the initial driver loading. Now because of
this, I am assuming that my assembly handler is never called, since
the first task is to clear this bit:
lsl r11, r11, #15?
str r11, [r9, #BIT_CLR]

This is basically where I am now, I don't know why my FIQ handler is
never called, even though the IRQ bit is triggered in interrupt 31,
and my handler appears to be created.

I did try to do a bit of debugging in the IRQ setup part, and it seems
that when I call mxs_icoll_set_irq_fiq(31); in the function it calls
__raw_writel(BM_ICOLL_INTERRUPTn_FIQ_ENABLE, icoll_base +
HW_ICOLL_INTERRUPTn_SET(d->hwirq));
Now this d->hwirq is actually a value "8", not "31" as I thought it
should be ? Im not exactly sure though here.
Also enable_fiq(31) will use same irq_desc in kernel/irq/manage.c that
has incorrect (?) value for hwirq.. but, again, I'm not sure this is
the cause.

If in user-space I check the value in HW_ICOLL_INTERRUPT31 I do NOT
see the bit 4 (ENFIQ) set, it actually seems to be 0.
Should the HW_ICOLL_INTERRUPT31 have bits 2 (enable) and 4 (enfiq) set ?

Another difference with Maxime's code is that currently I do not have
definition for my "HW" (gpio pin) and driver in dts file, I have
hardcoded the values for now to the driver.

I wonder what I might be doing wrong now, and where I should look more
closer with this ? I'm a newbie with IRQ's and FIQ's, so please don't
hesitate to confirm even some simple stuff I might have overlooked..
Thank you for any advice,
Juha Lumme
