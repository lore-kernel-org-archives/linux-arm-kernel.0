From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 16:51:56 +0200
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
Message-ID: <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 5:36 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> I did some of the changes for this v2 and a few things are not clear to
> me.
>
> The first is, how is userspace supposed to find the correct offset for a
> GPIO pin.

The sysfs interface to GPIO is *NOT* *GOOD* this is universally
agreed upon.

This needs someone to step in and provide a replacement, my preferred
mechanism would be a /dev/gpiochip0/... hierarchy using char devices.

> E.g. let's say GPIO 10 of this SOC-internal GPIO controller is
> something I want to control. So, I'd export GPIO (chip-base + 10). But
> this chip-base seems pretty variable. v1 of this patch had it hardcoded
> to 0, which resulted in a predictable offset, but apparently was utterly
> wrong. Now I see an offset of 138 for this chip when using my config.
> And when I use multi_v7_defconfig the offset is somewhere in the 800s,
> IIRC. The best I found was the 'label' in the gpiochip's sysfs entry,
> but documentation says that is not necessarily unique, and parsing labes
> seems sub-optimal too.

You see. It is badly designed and needs to be rewritten.

It was merged into the kernel at a time when the GPIO subsystem
was unmaintained, sadly.

> The second issue is a stack trace (below) I see when triggering
> interrupts (e.g. echo rising > edge; and then pushing the connected
> button). Looking at the stack trace, I don't see an obvious error (I
> think I pretty much copied the IRQ registration from the gpio-pl061.c
> driver you mentioned). Is this an issue in this driver or the core code?

Probably.

Using GPIOs for IRQs in userspace is an even worse idea than using
GPIOs from userspace in general :-D

But before you add any hairy code in userspace, please have a look
at Documentation/gpio/sysfs.txt:

"Note that standard kernel drivers exist for common "LEDs and Buttons"
 GPIO tasks:  "leds-gpio" and "gpio_keys", respectively. Use those
 instead of talking directly to the GPIOs; they integrate with kernel
 frameworks better than your userspace code could."

So: what is the usecase for these GPIOs?

Yours,
Linus Walleij
