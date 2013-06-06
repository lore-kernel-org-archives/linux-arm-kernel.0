From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 06 Jun 2013 10:33:28 -0700
Subject: pxa27x and pinctrl-single
In-Reply-To: <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
References: <51AF7404.3090003@newsguy.com>
 <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
Message-ID: <51B0C7E8.5090308@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the reply Haojian.

On 06/05/2013 05:43 PM, Haojian Zhuang wrote:
> On 6 June 2013 01:23, Mike Dunn <mikedunn@newsguy.com> wrote:
>> Hi,
>>
>> I'd like to start converting to device tree usage some of the old pxa27x
>> platforms I'm fond of, starting with adding pinctrl support.  If I'm not
>> mistaken, this will clear the way for some ongoing updates to the pinctrl/gpio
>> code used by newer Marvell arches.
>>
>> I noticed that Haojian pulled the pinctrl-pxa driver from the kernel, in favor
>> of using pinctrl-single, so I turned my attention to that.  From what I can
>> tell, pinctrl-single is currently inadequate for pxa27x because:
>>
>> (1) On the pxa27x, setting the mux for a pin involves configuring both the alt
>> function register *and* the direction register, requiring the ability to specify
>> in the device tree multiple reg/value pairs for each pin.
> In PXA27x, GPIO controller control both GPIO & pin alternate function. The
> alternate function is covered by GAFRx registers.
> 
> At first, we need to move GAFRx from gpio-pxa driver. Then we can support


Thanks... I wondered about division of labor between pinctrl and gpio.  Pinctrl
did seem to be the appropriate place.


> it by pinctrl-single driver since pinctrl-single driver could support mulitple
> pins in one pin registers. There's "bits-per-mux" property in pinctrl-single
> driver.


Yes, but currently pinctrl-single only supports writing one register for a given
pin (with multiple pins sharing a register if bit-per-mux==true).  On pxa27x, a
pin's alt function is determined by the values written to both the GAFRx and the
GPDRx registers, so I think that pinctrl-single may need to allow a device tree
to specify multiple reg/value/mask sets for any one pin.  I don't have a
pxa3xx/mmp developer's manual handy, but from the code it appears that on these
arches the direction register is irrelevant to the mux setting.


>>
>> (2) Some of the pinctrl-single code still assumes one register-per-pin; see for
>> example the functions pcs_allocate_pin_table() and pcs_get_pin_by_offset().
>> Curiously, the recently added pcs_request_gpio() function also suffers from
>> this, unless I'm mistaken.
>>
> Not exactly. pinctrl-single driver could support multiple pins in one register.
> Now Manjunathappa also fixed some issue in pinctrl-single for supporting
> multiple pins. (https://lkml.org/lkml/2013/5/21/226) I suggest you to develop
> based on his patches.


Thanks for the pointer.  I was away from the linux-arm-kernel ML until
yesterday, so I didn't see the patch.  Yes, it looks like bits_per_pin corrects
the problem.

I guess I'll take a stab at this.  Any other comments greatly appreciated.

Thanks again,
Mike
