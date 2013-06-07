From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 7 Jun 2013 09:21:00 +0800
Subject: pxa27x and pinctrl-single
In-Reply-To: <51B12DE9.9040908@newsguy.com>
References: <51AF7404.3090003@newsguy.com>
 <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
 <51B0C7E8.5090308@newsguy.com>
 <CAD6h2NSRCti57NZtw0wzE8Th65_3Y8Dkz5zGsbnA2SUPYS263Q@mail.gmail.com>
 <51B12DE9.9040908@newsguy.com>
Message-ID: <CAN1soZyOzrRewwx0up2s+4igUf77h+UbFpCsm324O-nkBWcsTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 8:48 AM, Mike Dunn <mikedunn@newsguy.com> wrote:
> On 06/06/2013 04:58 PM, Haojian Zhuang wrote:
>> On 7 June 2013 01:33, Mike Dunn <mikedunn@newsguy.com> wrote:
>>>
>
>
> [...]
>
>
>>>
>>> Yes, but currently pinctrl-single only supports writing one register for a given
>>> pin (with multiple pins sharing a register if bit-per-mux==true).  On pxa27x, a
>>> pin's alt function is determined by the values written to both the GAFRx and the
>>> GPDRx registers, so I think that pinctrl-single may need to allow a device tree
>>> to specify multiple reg/value/mask sets for any one pin.  I don't have a
>>> pxa3xx/mmp developer's manual handy, but from the code it appears that on these
>>> arches the direction register is irrelevant to the mux setting.
>>>
>>
>> No, it's not need to access both GAFRx & GPDRx. Let's focus on PXA27x first.
>>
>> GPIO ?x? Alternate Function Select Bits (where x = 112 through 120)
>> A bit-pair in this register determines the corresponding GPIO pin?s
>> functionality as one of the alternate functions that is mapped to it or as a
>> generic GPIO pin.
>>
>> 0b00 = The corresponding GPIO pin (GPIO<x>) is used as a general-
>> purpose I/O.
>> 0b01 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
>> function 1.
>> 0b10 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
>> function 2.
>> 0b11 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
>> function 3.
>>
>> We can see that GAFRx configures the pinmux. That's all. We can use
>> pinctrl-single
>> driver to cover this.
>
>
> But on the pxa27x there are usually *two* meanings for any one of the 3 alt
> functions, depending on the direction.  As a random example... gpio28 alt fn
> 0b01 is AC97_BITCLK if the direction is input, but is I2S_BITCLK if the
> direction is output (from PXA27x Developer's Manual, Table 24-2).
>

You didn't understand the alternate function. GPIO mode is only one mode
of alternate functions. Because GPIO means that user can program the
pin, you also need to configure the direction for GPIO usage.

Most of pins are either input or output. If the alternate function is
AC97_BITCLK,
input mode is configured by hardware automatically. You shouldn't configure
it in GPDR register. Since it's working in AC97 mode, not GPIO mode. Configuring
in GPDR register can't work.

>
>>
>> I know that you're also talking the implementation in gpio-pxa driver.
>> __gpio_is_occupied() checks both GAFRx & GPDRx. Because this GPIO
>> pin should be configured as GPIO input. Actually we could also discard the
>> checking.
>>
>> So there's no relationship between GAFRx and GPDRx.
>
>
> But I am thinking on pxa27x there is... see my example above.  Perhaps this is
> not true for the later Marvell arches and you are missing this point?  Or else I
> am stating the obvious to you and I am missing your point.  In either case,
> thanks for your patience.
>
I explained this above.

Regards
Haojian
