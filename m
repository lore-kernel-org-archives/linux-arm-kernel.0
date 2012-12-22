From: kg4ysn@gmail.com (Chris Verges)
Date: Fri, 21 Dec 2012 21:51:02 -0800
Subject: at91 gpio irq discrepancy in behavior vs. documentation
Message-ID: <CAG4_upQTZW0_+cRsyqOi031Gm4BTwXPqxYxKS1W-OtZUrVfOjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In gpio.c for the mach-at91 family, there is a comment above the
gpio_irq_mask() function which indicates that the AT91_PIN_* macros can
be used directly as inputs into the request_irq() function.  (See
arch/arm/mach-at91/gpio.c Line 489 in a 3.4.10 kernel if you aren't
familiar with this comment block.)

Following this comment block, to register an IRQ on the GPIO pin PA0,
for example, one could do the following:

    err = request_irq(AT91_PIN_PA0, ...);

I recently tested this on a board using an at91sam9g20 processor.  The
image was running a vanilla 3.4.10 (no patches).  The request_irq() call
succeeded, but in looking at /proc/interrupts, it seems like this causes
an interrupt to be assign to the Advanced Interrupt Controller (AIC) on
the processor:

    $ cat /proc/interrupts
               CPU0
>>>   0:          0       AIC  my_irq_handler
      1:    2478772       AIC  at91_tick, rtc0, ttyS0
      7:          0       AIC  ttyS2
      8:        150       AIC
      9:         26       AIC  mmc0
     12:        474       AIC
     20:      62796       AIC  ohci_hcd:usb1
    Err:          0

Toggling the pin PA0 does not cause an interrupt.

What I found works is wrapping the pin macro with gpio_to_irq():

    err = request_irq(gpio_to_irq(AT91_PIN_PA0), ...);

    $ cat /proc/interrupts
               CPU0
      1:    2478772       AIC  at91_tick, rtc0, ttyS0
      7:          0       AIC  ttyS2
      8:        150       AIC
      9:         26       AIC  mmc0
     12:        474       AIC
     20:      62796       AIC  ohci_hcd:usb1
>>>  32:          0      GPIO  my_irq_handler
    Err:          0

Since this behavior is so contrary to the comment block in the gpio.c
file, I'm wondering why there is such a discrepancy in behavior.  Is the
comment block simply out of date?  I'm more than happy to submit a patch
to update the documentation if that's the case.

Thanks,
Chris
