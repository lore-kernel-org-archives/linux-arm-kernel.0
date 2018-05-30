From: david@lechnology.com (David Lechner)
Date: Wed, 30 May 2018 14:20:48 -0500
Subject: [PATCH 4/9] clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always
 enabled
In-Reply-To: <20180530172239.982.48723@harbor.lan>
References: <20180525181150.17873-1-david@lechnology.com>
 <20180525181150.17873-5-david@lechnology.com>
 <20180530172239.982.48723@harbor.lan>
Message-ID: <c43af78a-de38-7ccc-924f-a349e395d779@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2018 12:22 PM, Michael Turquette wrote:
> Quoting David Lechner (2018-05-25 11:11:45)
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> PLL2 SYSCLK1 on DM646x is connected to DDR2 PHY and cannot
>> be disabled. Mark it so to prevent unused clock disable
>> infrastructure from disabling it.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Reviewed-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/clk/davinci/pll-dm646x.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
>> index a61cc3256418..0ae827e3ce80 100644
>> --- a/drivers/clk/davinci/pll-dm646x.c
>> +++ b/drivers/clk/davinci/pll-dm646x.c
>> @@ -72,7 +72,7 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
>>          .flags = 0,
>>   };
>>   
>> -SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
>> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
> 
> Nitpick: I dislike setting a platform-specific flag that just sets a
> framework-specific flag during clk registration.
> 
> I know there is some legacy here so I'll take this patch as-is, but
> perhaps cleaning this up to directly use CLK_IS_CRITICAL can be added to
> someone's todo list?

I can see how this would be better in general, but I don't think it would
be an improvement in this case. We have other platform-specific flags that
don't correspond to common framework flags (only the one you pointed out
does). So, we  would have to introduce a second flags variable for the
common framework flags (unless I am missing something, like a reserved
range of bits for platform-specific flags that would allow platform-specific
flags and common framework flags to coexist in a single 32 or 64-bit field).
Then we would have to add comments saying that CLK_IS_CRITICAL is the only
flag that you can use for this field because we really don't want someone
to try to use any other common framework flags. This seems like quite a bit
of effort just to try to avoid one redundant flag.
