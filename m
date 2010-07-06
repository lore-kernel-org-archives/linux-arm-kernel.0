From: redhatter@gentoo.org (Stuart Longland)
Date: Tue, 6 Jul 2010 12:12:07 +1000
Subject: i.MX KPP usage as interrupt-enabled GPIOs
Message-ID: <20100706021204.GA32310@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm working on an i.MX27-based device which uses the keypad column and
row signals as GPIOs.  A few of the lines are outputs, and for these
I've written a GPIO chip driver (attached) that permits me to use them
as if they were regular GPIOs.

As far as I know the keypad device pins do not route via IOMUX, and
therefore do not have any corresponding GPIO pins that I could utilise.
The Keypad controller was chosen for this since it supports totem-pole
outputs on the columns, and it can act as a wake-up source for the
i.MX27.  (We're not sure if the GPIOs can; the datasheet suggests this
isn't possible.)

I can read the state of the row pins just fine, however I get an
infinite loop when I try to make the KPP interrupt the MCU.  It's
important to remember that they are not connected to a keypad here, but
rather, to logic buffers on other peripherals which will pull these
signal lines low to interrupt the MCU.

I'm also not sure, having determined which of the ROW pins is being
pulled low, how to signal to a device driver that its device wants its
attention.  I've created an irq_chip device, and registered it... but I
can't seem to figure out how to report this back to the driver.

I'm testing at the moment using the gpio_keys driver, as a simple
test... and manually shorting a row pin to 0V.  If I leave interrupts
disabled, everything works; and I can see the state when I monitor the
GPIO via SYSFS.

However, with interrupts enabled, I get both "key press" and "key
release" events reported ... even long after I've stopped shorting the
pins... and after acknowledging those "key presses".  So I might be
doing something wrong in the interrupts.  Some of the ideas have been
taken from the imx-keypad driver in later kernels (I'm working with
2.6.28 here) and from other GPIO drivers in the kernel.

Does anyone have any idea what I might be doing wrong, or how I can get
this to work?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx-kpp-gpio.c
Type: text/x-c
Size: 13071 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100706/3c6f9d3d/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx-kpp-gpio.h
Type: text/x-c
Size: 1430 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100706/3c6f9d3d/attachment-0001.bin>
