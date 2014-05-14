From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 14 May 2014 12:00:31 +0200
Subject: Accessing GPIOs from userspace using recent kernels
In-Reply-To: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
Message-ID: <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On Wed, May 14, 2014 at 10:46 AM, Peter TB Brett <peter@peter-b.co.uk> wrote:
> Hi all,
>
> We have several pieces of software that make use of the /sys/class/gpio
> userspace interface to the GPIO subsystem.
>
> One important prerequisite to being able to use the userspace GPIO interface
> is to be able to put the corresponding package pins into GPIO mode, by
> modifying the chip's mux settings.
>
> With Fedora 19 on the Pandaboard, we were able to achieve this by poking
> around in /sys/kernel/debug/omap_mux.  However, when running Fedora 20, this
> directory is empty.  My assumption is that this functionality has been
> subsumed by the pinctrl subsystem in recent kernels.  Unfortunately, there
> doesn't seem to be any documented userspace API.
>

That is correct, OMAP now uses the pinctrl-single
(drivers/pinctrl/pinctrl-single.c) driver for pin configuration and
the old omap_mux debugfs interface no longer exists.

> If there is no longer a userspace API for these settings, is there any way
> that I can simply amend the device tree in order to change a couple of mux
> settings?
>

Not that I'm aware of, I've added Linus Walleij (the pinctrl subsystem
maintainer) on cc who will have an authoritative answer on this
subject.

> I've figured out that I would need a stanza that looks something like:
>
> &omap4_pmx_core
> {
>  foo_pins: pinmux_foo_pins {
>    pinctrl-single,pins = <
>      0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* IRQ */
>      0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* RST */
>  };
> };
>
> But I can't work out what else I need to modify in order for these mux
> settings to take effect.
>

You are only defining a set of pinmux configuration pins that will be
registered but that does not mean that the configuration will take
effect. Need to associate that configuration with a specific device
node so the state will be applicable. The good practice is to
associate with the device that needs that particular configuration or
if there is no such device then you can just add the properties in the
pinmux device node.

In your case would be something like should work:

&omap4_pmx_core
{
        pinctrl-names = "default";
        pinctrl-0 = <
                &foo_pins
        >;

        foo_pins: pinmux_foo_pins {
               pinctrl-single,pins = <
               0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* IRQ */
               0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* RST */
               >
        };
};

But as I said it would be better if you associate the pins with the
GPIO controller that contains those pins instead of the pinmux device.

> Thanks for any pointers!
>
>                                                    Peter

Hope it helps,

Javier
