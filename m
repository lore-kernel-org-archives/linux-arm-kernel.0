From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 2 Apr 2017 20:46:18 +0200
Subject: [PATCH 2/2] clk: meson: mpll: use 64bit math in rate_from_params
In-Reply-To: <1491145750.3480.3.camel@baylibre.com>
References: <20170401130225.8811-1-martin.blumenstingl@googlemail.com>
 <20170401130225.8811-3-martin.blumenstingl@googlemail.com>
 <1491145750.3480.3.camel@baylibre.com>
Message-ID: <CAFBinCDoj6n0o4Ao=ZTF6ewJJ1HeFbxz9-jTWBS70X9sFtoxyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Sun, Apr 2, 2017 at 5:09 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Sat, 2017-04-01 at 15:02 +0200, Martin Blumenstingl wrote:
>> On Meson8b the MPLL parent clock (fixed_pll) has a rate of 2550MHz.
>> Multiplying this with SDM_DEN results in a value greater than 32bits.
>> This is not a problem on the 64bit Meson GX SoCs, but it may result in
>> undefined behavior on the older 32bit Meson8b SoC.
>>
>> While rate_from_params was only introduced recently to make the math
>> reusable from _round_rate and _recalc_rate the original bug exists much
>> longer.
>
> Again, thanks for testing and fixing this Martin !
>
>>
>> Fixes: 1c50da4f27 ("clk: meson: add mpll support")
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/clk/meson/clk-mpll.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
>> index 551aa2a5b291..4306ad833a4f 100644
>> --- a/drivers/clk/meson/clk-mpll.c
>> +++ b/drivers/clk/meson/clk-mpll.c
>> @@ -62,6 +62,7 @@
>>   */
>>
>>  #include <linux/clk-provider.h>
>> +#include <linux/math64.h>
>>  #include "clkc.h"
>>
>>  #define SDM_DEN 16384
>> @@ -81,7 +82,7 @@ static unsigned long rate_from_params(unsigned long
>> parent_rate,
>>       if (divisor == 0)
>>               return 0;
>>       else
>> -             return (parent_rate * SDM_DEN) / divisor;
>> +             return mul_u64_u32_div(parent_rate, SDM_DEN, divisor);
>
> Just casting parent_rate to u64 should be enough, don't you think ?
> Actually, I was thinking of copying a pattern that is used a lot in CCF and use
> DIV_ROUND_UP_ULL((u64)foo, bar). See clk-divider.c.
>
> Would this be ok with you ?
I'm actually happy with any patch that fixes bugs (properly) :)
the current code seems to round the values down instead of up. the
easiest way to check if this is a problem or not is probably by
testing it with your audio driver (which is probably sensitive to this
kind of stuff)


>>  }
>>
>>  static void params_from_rate(unsigned long requested_rate,
