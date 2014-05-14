From: peter@peter-b.co.uk (Peter TB Brett)
Date: Wed, 14 May 2014 09:46:47 +0100
Subject: Accessing GPIOs from userspace using recent kernels
Message-ID: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We have several pieces of software that make use of the /sys/class/gpio 
userspace interface to the GPIO subsystem.

One important prerequisite to being able to use the userspace GPIO 
interface is to be able to put the corresponding package pins into GPIO 
mode, by modifying the chip's mux settings.

With Fedora 19 on the Pandaboard, we were able to achieve this by poking 
around in /sys/kernel/debug/omap_mux.  However, when running Fedora 20, 
this directory is empty.  My assumption is that this functionality has 
been subsumed by the pinctrl subsystem in recent kernels.  
Unfortunately, there doesn't seem to be any documented userspace API.

If there is no longer a userspace API for these settings, is there any 
way  that I can simply amend the device tree in order to change a couple 
of mux settings?

I've figured out that I would need a stanza that looks something like:

&omap4_pmx_core
{
  foo_pins: pinmux_foo_pins {
    pinctrl-single,pins = <
      0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* IRQ */
      0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* RST */
  };
};

But I can't work out what else I need to modify in order for these mux 
settings to take effect.

Thanks for any pointers!

                                                    Peter



-- 
Dr Peter Brett <peter@peter-b.co.uk>
