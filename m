From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 8 Jun 2013 11:17:16 +0800
Subject: [PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag
In-Reply-To: <201306071431.22732.heiko@sntech.de>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1370358317-12768-4-git-send-email-haojian.zhuang@linaro.org>
 <201306071431.22732.heiko@sntech.de>
Message-ID: <CAD6h2NS7a+URA=6J3FeiMfkuBebb5LpOayUmXnx98a_KHkn53w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2013 20:31, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Haojian,
>
> as Linus suggested, a bit of commentary for your side :-)
>
> The same also applies to the similar changes to the mux clock.
>
> Interestingly the gates on the hisilicon follow another paradigm altogether,
> where on the Rockchip they also use this mask-mechanism.
>
>
> Am Dienstag, 4. Juni 2013, 17:05:14 schrieb Haojian Zhuang:
>> In Hisilicon Hi3620 clock divider register, 16-bit HIWORD is mask field.
>> Support the HIWORD mask to reuse clock divider driver.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  drivers/clk/clk-divider.c    | 6 ++++++
>>  include/linux/clk-provider.h | 2 ++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index 6d96741..4c344b4 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -220,6 +220,12 @@ static int clk_divider_set_rate(struct clk_hw *hw,
>> unsigned long rate, val = readl(divider->reg);
>>       val &= ~(div_mask(divider) << divider->shift);
>
> Do you really need to read the register value on the HiSilicon before changing
> it?

Because there's a mask field in the register, it could work without reading.
My purpose is only to do less change in common code.

>
> On the Rockchip side, the mask is used just for just this, to indicate the
> bits that are set in the lower part, so there there really is no separate read
> necessary when changing bits.
>
>
>>       val |= value << divider->shift;
>> +     if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
>> +             if (divider->width + divider->shift > 16)
>> +                     pr_warn("divider value exceeds LOWORD field\n");
>
> This can be checked in the clock setup. If shift and mask are exceeding the
> low word there is something seriously wrong with the setup data and the clock
> shouldn't be created at all. This also saves the conditional on every set
> operation.

OK.
>
>
>> +             else
>> +                     val |= div_mask(divider) << (divider->shift + 16);
>> +     }
>>       writel(val, divider->reg);
>>
>>       if (divider->lock)
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 6ba32bc..dbb9bd9 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -257,6 +257,7 @@ struct clk_div_table {
>>   *   Some hardware implementations gracefully handle this case and allow a
>>   *   zero divisor by not modifying their input clock
>>   *   (divide by one / bypass).
>> + * CLK_DIVIDER_HIWORD_MASK - register contains high 16-bit as mask field
>>   */
>>  struct clk_divider {
>>       struct clk_hw   hw;
>> @@ -271,6 +272,7 @@ struct clk_divider {
>>  #define CLK_DIVIDER_ONE_BASED                BIT(0)
>>  #define CLK_DIVIDER_POWER_OF_TWO     BIT(1)
>>  #define CLK_DIVIDER_ALLOW_ZERO               BIT(2)
>> +#define CLK_DIVIDER_HIWORD_MASK              BIT(3)
>
> I like your naming a lot better than mine :-)

OK. How about I sent the next version. And you can base on mine version.
I'll append your comments & logic in my version. And I'll split your patches
into three that are gate, mux and divider.

Regards
Haojian

>
>
> Heiko
