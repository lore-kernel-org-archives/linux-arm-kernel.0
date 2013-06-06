From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 7 Jun 2013 07:58:49 +0800
Subject: pxa27x and pinctrl-single
In-Reply-To: <51B0C7E8.5090308@newsguy.com>
References: <51AF7404.3090003@newsguy.com>
 <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
 <51B0C7E8.5090308@newsguy.com>
Message-ID: <CAD6h2NSRCti57NZtw0wzE8Th65_3Y8Dkz5zGsbnA2SUPYS263Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2013 01:33, Mike Dunn <mikedunn@newsguy.com> wrote:
> Thanks for the reply Haojian.
>
> On 06/05/2013 05:43 PM, Haojian Zhuang wrote:
>> On 6 June 2013 01:23, Mike Dunn <mikedunn@newsguy.com> wrote:
>>> Hi,
>>>
>>> I'd like to start converting to device tree usage some of the old pxa27x
>>> platforms I'm fond of, starting with adding pinctrl support.  If I'm not
>>> mistaken, this will clear the way for some ongoing updates to the pinctrl/gpio
>>> code used by newer Marvell arches.
>>>
>>> I noticed that Haojian pulled the pinctrl-pxa driver from the kernel, in favor
>>> of using pinctrl-single, so I turned my attention to that.  From what I can
>>> tell, pinctrl-single is currently inadequate for pxa27x because:
>>>
>>> (1) On the pxa27x, setting the mux for a pin involves configuring both the alt
>>> function register *and* the direction register, requiring the ability to specify
>>> in the device tree multiple reg/value pairs for each pin.
>> In PXA27x, GPIO controller control both GPIO & pin alternate function. The
>> alternate function is covered by GAFRx registers.
>>
>> At first, we need to move GAFRx from gpio-pxa driver. Then we can support
>
>
> Thanks... I wondered about division of labor between pinctrl and gpio.  Pinctrl
> did seem to be the appropriate place.
>
>
>> it by pinctrl-single driver since pinctrl-single driver could support mulitple
>> pins in one pin registers. There's "bits-per-mux" property in pinctrl-single
>> driver.
>
>
> Yes, but currently pinctrl-single only supports writing one register for a given
> pin (with multiple pins sharing a register if bit-per-mux==true).  On pxa27x, a
> pin's alt function is determined by the values written to both the GAFRx and the
> GPDRx registers, so I think that pinctrl-single may need to allow a device tree
> to specify multiple reg/value/mask sets for any one pin.  I don't have a
> pxa3xx/mmp developer's manual handy, but from the code it appears that on these
> arches the direction register is irrelevant to the mux setting.
>

No, it's not need to access both GAFRx & GPDRx. Let's focus on PXA27x first.

GPIO ?x? Alternate Function Select Bits (where x = 112 through 120)
A bit-pair in this register determines the corresponding GPIO pin?s
functionality as one of the alternate functions that is mapped to it or as a
generic GPIO pin.

0b00 = The corresponding GPIO pin (GPIO<x>) is used as a general-
purpose I/O.
0b01 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
function 1.
0b10 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
function 2.
0b11 = The corresponding GPIO pin (GPIO<x>) is used for its alternate
function 3.

We can see that GAFRx configures the pinmux. That's all. We can use
pinctrl-single
driver to cover this.

I know that you're also talking the implementation in gpio-pxa driver.
__gpio_is_occupied() checks both GAFRx & GPDRx. Because this GPIO
pin should be configured as GPIO input. Actually we could also discard the
checking.

So there's no relationship between GAFRx and GPDRx. And "inverted" GPIO
pins only exists in PXA26x. This "inverted" means that GPDR bits should
also be inverted.

Regards
Haojian
