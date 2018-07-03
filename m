From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 3 Jul 2018 17:56:40 +0800
Subject: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
In-Reply-To: <1530605373.2900.158.camel@baylibre.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-3-yixun.lan@amlogic.com>
 <20180703092107.51497a8f@bbrezillon>
 <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
 <1530605373.2900.158.camel@baylibre.com>
Message-ID: <1aedbb15-1373-adde-f5bb-bce3701d50b0@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome:


On 07/03/18 16:09, Jerome Brunet wrote:
> On Tue, 2018-07-03 at 15:36 +0800, Yixun Lan wrote:
>> Hi Broris
>>
>>  thanks for your quick response, and see my comments below
>>
>> On 07/03/18 15:21, Boris Brezillon wrote:
>>> On Tue, 3 Jul 2018 14:57:15 +0000
>>> Yixun Lan <yixun.lan@amlogic.com> wrote:
>>>
>>>> Add two clock bindings IDs which provided by the EMMC clock controller,
>>>> These two clocks will be used by EMMC or NAND driver.
>>>>
>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>> ---
>>>>  include/dt-bindings/clock/emmc-clkc.h | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
>>>>
>>>> diff --git a/include/dt-bindings/clock/emmc-clkc.h b/include/dt-bindings/clock/emmc-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..d9972c400e58
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/emmc-clkc.h
>>>> @@ -0,0 +1,14 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>> +/*
>>>> + * Meson EMMC sub clock tree IDs
>>>> + *
>>>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef __EMMC_CLKC_H
>>>> +#define __EMMC_CLKC_H
>>>> +
>>>> +#define CLKID_EMMC_C_MUX				0
>>>
>>> Looks like the MUX clk is the parent of the DIV one, and I guess the clk
>>> driver is able to select the best parent+div pair for a requested rate.
>>> Do you really need to expose the MUX to users?
>>>
>>
>> Yes, It's true, the mux is parent of the div clock.
>>
>> while testing for the NAND driver, I find it's kind of loose about the
>> parent of the clock, so selecting the div (and let CCF decide freely) is
>> actually works fine
>>
>> but for the EMMC driver, especially when running at high clock, it's
>> kind of picky about the parent of the clock, 
> 
> It would be nice to get an explanation about this behavior.
> it seems that even of the rate provided by CLKID_SD_EMMC_X_CLK0 (main clock
> controller) is correct, the eMMC cannot reliably tune with it.
> 
> Could you elaborate on this ?
> 
It's during my own test in AXG platform, I found clock path
a) fclk_div2 -> sd_emmc_c_clk0_sel -> sd_emmc_c_clk0_div ->
sd_emmc_c_clk0 -> sd_emmc_c_mux -> sd_emmc_c_div

b) fclk_div2 -> sd_emmc_c_mux -> sd_emmc_c_div

path a) doesn't work in EMMC driver, even both clock parent of them from
the same fclk_div2 source.

 sd_emmc_c_mux -> sd_emmc_c_div is the clock from the EMMC register base.
I believe it's ASIC design issue

>> so the driver may want to
>> manually choose the parent of the mux clock (example fclk_div2 here).
>> That's why I'm exporting this clock ID.
> 
> ATM the EMMC driver will not use this provider. If this is the only reason, it
> could be done later.
> 
sure, I'm fine with this.. we could certainly adjust it later.

I will fix this in next patch version

> Is the NAND driver "picky" as well ?
> 
No, since the NAND is running at much low clock speed, and during my
tests, it works fine with various clock parent

>>
>>
>>>> +#define CLKID_EMMC_C_DIV				1
>>>> +
>>>> +#endif
>>>
>>> .
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
