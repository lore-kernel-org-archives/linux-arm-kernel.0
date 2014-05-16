From: peter@peter-b.co.uk (Peter TB Brett)
Date: Fri, 16 May 2014 11:15:35 +0100
Subject: Accessing GPIOs from userspace using recent kernels
In-Reply-To: <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
 <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
 <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
Message-ID: <ea43ccacfe4caf1f51f9e5a5c8bbdd5e@net2air.co>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-05-15 19:54, Javier Martinez Canillas wrote:

> [snip]
> 
> But I would first look why associating the pins with gpio1 does not 
> work.
> 
>> 
>>> But as I said it would be better if you associate the pins with the
>>> GPIO controller that contains those pins instead of the pinmux 
>>> device.
>> 
>> 
>> Following this advice, I used:
>> 
>> &gpio1
>> 
>> {
>>   pinctrl-names = "default";
>>   pinctrl-0 = < &foo_pins >;
>> };
>> 
>> However, with these settings, nothing referring to pinmux_foo_pins 
>> appears
>> in pinctrl-devices, pinctrl-maps, pinctrl-handles, or pinmux-pins, so 
>> I'm
>> fairly sure these aren't the settings I'm looking for.
>> 
> 
> That should work afaict, did you see any errors on the kernel log? can
> you share your complete boot log?

Ah yes, there were some relevant messages:

[    2.939453] pinctrl-single 4a100040.pinmux: pin 4a10009e.0 already 
requested by 4a100040.pinmux; cannot claim for 4a310000.gpio
[    2.951843] pinctrl-single 4a100040.pinmux: pin-47 (4a310000.gpio) 
status -22
[    2.955261] pinctrl-single 4a100040.pinmux: could not request pin 47 
on device pinctrl-single

I should have spotted those.

> Something that looks strange to me is that you say to be using a
> Pandaboard and in your pasted DTS fragment you had:
> 
> 0x5e (PIN_INPUT | MUX_MODE3)  /* gpmc_ad15.gpio_39 */ /* IRQ */
> 0x12e (PIN_INPUT | MUX_MODE3) /* i2c4_scl.gpio_132 */ /* RST *
> 
> but grepping for those registers numbers in omap4-panda-common.dtsi I
> see that they refers to different mux pins and are already configured
> for other devices in different modes:
> 
> $ git grep "0x5e\|0x12e" arch/arm/boot/dts/omap4-panda-common.dtsi
> 
> 0x5e (PIN_INPUT_PULLUP | MUX_MODE0)     /* hdmi_sda.hdmi_sda */
> 0x12e (PIN_OUTPUT | MUX_MODE5)  /* dispc2_data15 */

Yes, that's my mistake.  I took the pin control register addresses from 
the OMAP4 documentation and forgot that you have to subtract 0x40 to get 
the correct address for use in the device tree.

The correct snippet has 0x1e and 0xee.

> Also I see that i2c4_scl has another register number and by the way is
> also configured in another mode by i2c4 device node.
> 0xee (PIN_INPUT_PULLUP | MUX_MODE0)     /* i2c4_scl */

The I2C4 controller is exposed on the Pandaboard's expansion header, but 
I want to use the pins for something else.  It seems that I can just 
override the i2c4 device node's pinctrl-0 attribute to be empty and thus 
prevent it from claiming pins?

> Is what you shared your real change or just an example that does not
> apply to the Pandaboard? Could you please share your complete DTS?

The attached .dts file sort of works-ish.  It's an ugly hack, but I 
don't have the time to do any more investigation into this now, 
unfortunately.

I guess my main question is: if I use /sys/class/gpio/export to export a 
GPIO for userspace control, it would make sense for the kernel to try 
and ensure that the GPIO is actually connected to something!  Please 
consider this a feature request for OMAP4's GPIO and pinctrl drivers.

The current call chain seems to be: gpiod_export() --> gpiod_request() 
--> omap_gpio_request().  Looking at other GPIO drivers, it seems like 
omap_gpio_request() should eventually call pinctrl_request_gpio().  
Would be useful if someone who knows about OMAP4/gpio/pinctrl could take 
a look at this.

                                      Peter

-- 
Dr Peter Brett <peter@peter-b.co.uk>
