From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 15 May 2014 20:54:40 +0200
Subject: Accessing GPIOs from userspace using recent kernels
In-Reply-To: <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
 <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
Message-ID: <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On Thu, May 15, 2014 at 4:06 PM, Peter TB Brett <peter@peter-b.co.uk> wrote:
> Hi Javier,
>
> Thank you for your helpful suggestions.
>
> On 2014-05-14 11:00, Javier Martinez Canillas wrote:
>>
>> [snip]
>>
>>
>>> If there is no longer a userspace API for these settings, is there any
>>> way
>>> that I can simply amend the device tree in order to change a couple of
>>> mux
>>> settings?
>>>
>>
>> Not that I'm aware of, I've added Linus Walleij (the pinctrl subsystem
>> maintainer) on cc who will have an authoritative answer on this
>> subject.
>
>
> Having some sort of debugfs API for runtime modification of pinmux settings
> from userspace would be very helpful for hardware/firmware prototyping
> purposes.
>
>> [snip]
>>
>>
>> You are only defining a set of pinmux configuration pins that will be
>> registered but that does not mean that the configuration will take
>> effect. Need to associate that configuration with a specific device
>> node so the state will be applicable. The good practice is to
>> associate with the device that needs that particular configuration or
>> if there is no such device then you can just add the properties in the
>> pinmux device node.
>>
>> In your case would be something like should work:
>>
>> &omap4_pmx_core
>> {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <
>>                 &foo_pins
>>         >;
>>
>>         foo_pins: pinmux_foo_pins {
>>                pinctrl-single,pins = <
>>                0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /*
>> IRQ */
>>                0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /*
>> RST */
>>                >
>>         };
>> };
>
>
> Note that this doesn't work; the omap4_pmx_core node already has a pinctrl-0
> attribute with a whole bunch of entries (e.g. I2C pins and pins used for
> other peripherals) and there doesn't appear to be a way to append to the
> array rather than replacing it.
>

In that case you can add the pinctrl single pins setup in the
omap4-panda-common.dtsi file as another element in pinctrl-0.

But I would first look why associating the pins with gpio1 does not work.

>
>> But as I said it would be better if you associate the pins with the
>> GPIO controller that contains those pins instead of the pinmux device.
>
>
> Following this advice, I used:
>
> &gpio1
>
> {
>   pinctrl-names = "default";
>   pinctrl-0 = < &foo_pins >;
> };
>
> However, with these settings, nothing referring to pinmux_foo_pins appears
> in pinctrl-devices, pinctrl-maps, pinctrl-handles, or pinmux-pins, so I'm
> fairly sure these aren't the settings I'm looking for.
>

That should work afaict, did you see any errors on the kernel log? can
you share your complete boot log?

Something that looks strange to me is that you say to be using a
Pandaboard and in your pasted DTS fragment you had:

0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* IRQ */
0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* RST *

but grepping for those registers numbers in omap4-panda-common.dtsi I
see that they refers to different mux pins and are already configured
for other devices in different modes:

$ git grep "0x5e\|0x12e" arch/arm/boot/dts/omap4-panda-common.dtsi

0x5e (PIN_INPUT_PULLUP | MUX_MODE0)     /* hdmi_sda.hdmi_sda */
0x12e (PIN_OUTPUT | MUX_MODE5)  /* dispc2_data15 */

Also I see that i2c4_scl has another register number and by the way is
also configured in another mode by i2c4 device node.
0xee (PIN_INPUT_PULLUP | MUX_MODE0)     /* i2c4_scl */

Is what you shared your real change or just an example that does not
apply to the Pandaboard? Could you please share your complete DTS?

> Is there any documentation for the debugfs interface to pinctrl?
>

No that I'm aware of, you should take a look to
drivers/pinctrl/{core,pinconf,pinmux}.c to figure out what information
each file exports.

Best regards,
Javier
