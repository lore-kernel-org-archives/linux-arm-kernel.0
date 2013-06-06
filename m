From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 6 Jun 2013 08:43:45 +0800
Subject: pxa27x and pinctrl-single
In-Reply-To: <51AF7404.3090003@newsguy.com>
References: <51AF7404.3090003@newsguy.com>
Message-ID: <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2013 01:23, Mike Dunn <mikedunn@newsguy.com> wrote:
> Hi,
>
> I'd like to start converting to device tree usage some of the old pxa27x
> platforms I'm fond of, starting with adding pinctrl support.  If I'm not
> mistaken, this will clear the way for some ongoing updates to the pinctrl/gpio
> code used by newer Marvell arches.
>
> I noticed that Haojian pulled the pinctrl-pxa driver from the kernel, in favor
> of using pinctrl-single, so I turned my attention to that.  From what I can
> tell, pinctrl-single is currently inadequate for pxa27x because:
>
> (1) On the pxa27x, setting the mux for a pin involves configuring both the alt
> function register *and* the direction register, requiring the ability to specify
> in the device tree multiple reg/value pairs for each pin.
In PXA27x, GPIO controller control both GPIO & pin alternate function. The
alternate function is covered by GAFRx registers.

At first, we need to move GAFRx from gpio-pxa driver. Then we can support
it by pinctrl-single driver since pinctrl-single driver could support mulitple
pins in one pin registers. There's "bits-per-mux" property in pinctrl-single
driver.
>
> (2) Some of the pinctrl-single code still assumes one register-per-pin; see for
> example the functions pcs_allocate_pin_table() and pcs_get_pin_by_offset().
> Curiously, the recently added pcs_request_gpio() function also suffers from
> this, unless I'm mistaken.
>
Not exactly. pinctrl-single driver could support multiple pins in one register.
Now Manjunathappa also fixed some issue in pinctrl-single for supporting
multiple pins. (https://lkml.org/lkml/2013/5/21/226) I suggest you to develop
based on his patches.

Regards
Haojian
