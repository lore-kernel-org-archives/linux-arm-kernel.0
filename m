From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 02 Jan 2014 23:36:33 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <20140102202022.GK3144@lukather>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net> <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil> <52C56D79.1060506@redhat.com>
 <20140102202022.GK3144@lukather>
Message-ID: <52C5E9F1.9010700@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
>>> Also, instead of inventing yet another vendor-specific property, why not re-use
>>> a button binding similar to gpio-keys like:
>>>
>>>         lradc: lradc at 01c22800 {
>>>                 compatible = "allwinner,sun4i-lradc-keys";
>>>                 reg = <0x01c22800 0x100>;
>>>                 interrupts = <31>;
>>>                 allwinner,chan0-step = <200>;
>>>
>>> 		#address-cells = <1>;
>>> 		#size-cells = <0>;
>>>
>>> 		button at 0 {
>>> 			reg = <0>; /* your channel index from above */
>>> 			linux,code = <115>; /* already used as dt-property */
>>> 		};
>>>
>>> 		button at 1 {
>>> 			reg = <1>;
>>> 			linux,code = <114>;
>>> 		};
>>
>> Ugh no. Having a vendor specific property which is KISS certainly
>> beats this, both wrt ease of writing dts files as well as wrt the
>> dts parsing code in the driver.
>
> I'd agree with Heiko here. This is pretty much the same construct
> that's already in use in other input drivers, like gpio-keys.

In the gpio case there is a 1 on 1 relation between a single hw
entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
which maps to an array of key-codes, certainly using an array rather
then a much more complicated construct is the correct data-structure
to represent this.

>
> This is also something that can really easily be made generic, since
> this is something that is rather common.
>
> Speaking of which. I believe this should actually come in two
> different drivers:
>    - The ADC driver itself, using IIO
>    - A generic button handler driver on top of IIO.
 >
 > The fact that on most board this adc is used for buttons doesn't make
 > any difference, it's actually a hardware designer choice, we should
 > support that choice, but we should also be able to use it just as an
 > ADC.

No, this is not a generic adc, as mentioned in the commit msg, this
adc is specifically designed to be used this way.

The adc won't start sampling data, and won't generate any interrupts
until a button is pressed. That is until the input voltage drops below
2/3 of Vref, this is checked through a built-in analog comparator, which
hooks into the control logic.

It has button down and button up interrupts, and can detect long
presses (unused) and generate a second type of down interrupt for those.

This really is an input device, which happens to use an adc.

> Carlo Caione already started to work on an IIO driver for the LRADC:
> https://github.com/carlocaione/linux/tree/sunxi-lradc
> maybe you can take over his work.

That won't work because the adc won't sample if the input gets above
2/3 of Vref. There may be some other mode which does not do that, but
that is not clearly documented.

Even if an IIO driver turns out to be doable, I strongly believe that
having a separate input driver for this is best, since this device
was designed to be used as such. Building input on top of IIO would
mean polling the adc, while with my driver it actually generates
button down / up interrupts without any polling being involved.

And no boards I know of are using this as a generic analog input,
where as many boards are using it as designed.

Regards,

Hans
