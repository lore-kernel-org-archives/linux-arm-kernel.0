From: peter@peter-b.co.uk (Peter TB Brett)
Date: Thu, 15 May 2014 15:06:28 +0100
Subject: Accessing GPIOs from userspace using recent kernels
In-Reply-To: <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
Message-ID: <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Thank you for your helpful suggestions.

On 2014-05-14 11:00, Javier Martinez Canillas wrote:
> [snip]
> 
>> If there is no longer a userspace API for these settings, is there any 
>> way
>> that I can simply amend the device tree in order to change a couple of 
>> mux
>> settings?
>> 
> 
> Not that I'm aware of, I've added Linus Walleij (the pinctrl subsystem
> maintainer) on cc who will have an authoritative answer on this
> subject.

Having some sort of debugfs API for runtime modification of pinmux 
settings from userspace would be very helpful for hardware/firmware 
prototyping purposes.

> [snip]
> 
> You are only defining a set of pinmux configuration pins that will be
> registered but that does not mean that the configuration will take
> effect. Need to associate that configuration with a specific device
> node so the state will be applicable. The good practice is to
> associate with the device that needs that particular configuration or
> if there is no such device then you can just add the properties in the
> pinmux device node.
> 
> In your case would be something like should work:
> 
> &omap4_pmx_core
> {
>         pinctrl-names = "default";
>         pinctrl-0 = <
>                 &foo_pins
>         >;
> 
>         foo_pins: pinmux_foo_pins {
>                pinctrl-single,pins = <
>                0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* 
> IRQ */
>                0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* 
> RST */
>                >
>         };
> };

Note that this doesn't work; the omap4_pmx_core node already has a 
pinctrl-0 attribute with a whole bunch of entries (e.g. I2C pins and 
pins used for other peripherals) and there doesn't appear to be a way to 
append to the array rather than replacing it.

> But as I said it would be better if you associate the pins with the
> GPIO controller that contains those pins instead of the pinmux device.

Following this advice, I used:

&gpio1
{
   pinctrl-names = "default";
   pinctrl-0 = < &foo_pins >;
};

However, with these settings, nothing referring to pinmux_foo_pins 
appears in pinctrl-devices, pinctrl-maps, pinctrl-handles, or 
pinmux-pins, so I'm fairly sure these aren't the settings I'm looking 
for.

Is there any documentation for the debugfs interface to pinctrl?

                                                       Peter


-- 
Dr Peter Brett <peter@peter-b.co.uk>
