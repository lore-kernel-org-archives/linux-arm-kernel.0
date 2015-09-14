From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 14 Sep 2015 19:46:05 +0800
Subject: [PATCH] thermal: rockchip: fix handling of invalid readings
In-Reply-To: <55C87B70.5050805@rock-chips.com>
References: <20150807205923.GA33949@dtor-ws>	<55C84521.5040007@rock-chips.com>
 <CAE_wzQ_xhh17tsVj28W5Z=mgomnz1nOMPMN15Sozb8KcMjo=wA@mail.gmail.com>
 <55C87B70.5050805@rock-chips.com>
Message-ID: <55F6B37D.9010206@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eduardo,

I guess you forgot to review/pick up this series patchs.

Another patch as follows:

[PATCH] thermal: rockhip: fix setting thermal shutdown polarity
https://patchwork.kernel.org/patch/6973131/

----
Thanks,
Caesar

? 2015?08?10? 18:22, Caesar Wang ??:
>
>
> ? 2015?08?10? 15:59, Dmitry Torokhov ??:
>> Hi Caesar,
>>
>> On Sun, Aug 9, 2015 at 11:30 PM, Caesar Wang <wxt@rock-chips.com> wrote:
>>> Dear Dmitry,
>>>
>>> Thanks your patch.
>>>
>>> The code looks like fine,but I don't think the TS-ADC will work on 
>>> rk3288
>>> SoC.
>> What do you mean? It seems to work when I ran it...
>
> Making a mistake.:-(
>
>>>
>>> ? 2015?08?08? 04:59, Dmitry Torokhov ??:
>>>> We attempted to signal invalid code by returning -EAGAIN from
>>>> rk_tsadcv2_code_to_temp(), unfortunately the return value was stuffed
>>>> directly into the temperature pointer, potentially confusing upper
>>>> layers with temperature of -EINVAL.
>>>>
>>>> Let's split temperature from error/success indicator to avoid such
>>>> confusion.
>>>>
>>>> Also change the way we scan the temperature table to start with the 
>>>> 2nd
>>>> element so that we do not need to worry that we may reference out of
>>>> bounds element while doing binary search and keep checking that we end
>>>> up with 'mid' equal to 0 (since we are looking for the temperature 
>>>> that
>>>> would fall into interval between the 'mid' and 'mid - 1') .
>>>>
>>>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>>>> ---
>>>>    drivers/thermal/rockchip_thermal.c | 28 
>>>> +++++++++++++---------------
>>>>    1 file changed, 13 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>>> b/drivers/thermal/rockchip_thermal.c
>>>> index c89ffb2..93ee307 100644
>>>> --- a/drivers/thermal/rockchip_thermal.c
>>>> +++ b/drivers/thermal/rockchip_thermal.c
>>>> @@ -124,7 +124,7 @@ struct rockchip_thermal_data {
>>>>    #define TSADCV2_AUTO_PERIOD_HT_TIME           50  /* msec */
>>>>      struct tsadc_table {
>>>> -       unsigned long code;
>>>> +       u32 code;
>>>>          long temp;
>>>>    };
>>>>    @@ -164,7 +164,6 @@ static const struct tsadc_table 
>>>> v2_code_table[] = {
>>>>          {3452, 115000},
>>>>          {3437, 120000},
>>>>          {3421, 125000},
>>>> -       {0, 125000},
>>>>    };
>>>>      static u32 rk_tsadcv2_temp_to_code(long temp)
>>>> @@ -191,19 +190,21 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
>>>>          return 0;
>>>>    }
>>>>    -static int rk_tsadcv2_code_to_temp(u32 code)
>>>> +static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
>
> It's wired that can't git-am this patch.
>
> I search the Eduardo'branch[0] for rockchip-thermal.c driver. The 
> function is "static long rk_tsadcv2_code_to_temp(u32 code)"
>
> Maybe i'm missing something, I verified this patch on my board but 
> this fixed.
>
> So you can free add it:
> Tested-by: Caesar Wang <wxt@rock-chips.com>
>
> [0]:
> url = 
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>
>
>
> ---
> Thanks,
> Caesar
>
>
>
>>>>    {
>>>> -       unsigned int low = 0;
>>>> +       unsigned int low = 1;
>>>>          unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
>>>>          unsigned int mid = (low + high) / 2;
>>>>          unsigned int num;
>>>>          unsigned long denom;
>>>>    -     /* Invalid code, return -EAGAIN */
>>>> -       if (code > TSADCV2_DATA_MASK)
>>>> -               return -EAGAIN;
>>>> +       BUILD_BUG_ON(ARRAY_SIZE(v2_code_table) < 2);
>>>>    -     while (low <= high && mid) {
>>>> +       code &= TSADCV2_DATA_MASK;
>>>> +       if (code < v2_code_table[high].code)
>>>> +               return -EAGAIN;         /* Incorrect reading */
>>>> +
>>>> +       while (low <= high) {
>>>>                  if (code >= v2_code_table[mid].code &&
>>>>                      code < v2_code_table[mid - 1].code)
>>>>                          break;
>>>> @@ -223,7 +224,9 @@ static int rk_tsadcv2_code_to_temp(u32 code)
>>>>          num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
>>>>          num *= v2_code_table[mid - 1].code - code;
>>>>          denom = v2_code_table[mid - 1].code - 
>>>> v2_code_table[mid].code;
>>>> -       return v2_code_table[mid - 1].temp + (num / denom);
>>>> +       *temp = v2_code_table[mid - 1].temp + (num / denom);
>>>> +
>>>> +       return 0;
>>>>    }
>>>>      /**
>>>> @@ -281,14 +284,9 @@ static int rk_tsadcv2_get_temp(int chn, void 
>>>> __iomem
>>>> *regs, int *temp)
>>>>    {
>>>>          u32 val;
>>>>    -     /* the A/D value of the channel last conversion need some 
>>>> time */
>>>>          val = readl_relaxed(regs + TSADCV2_DATA(chn));
>>>> -       if (val == 0)
>>>> -               return -EAGAIN;
>>>> -
>>>
>>> if we reserve the above code, that will get the ADC value.
>> But if we pass  0 into rk_tsadcv2_code_to_temp() it will trigger:
>>
>>>> +       if (code < v2_code_table[high].code)
>>>> +               return -EAGAIN;         /* Incorrect reading */
>> and still return -EAGAIN, as it was. There is no behavior change as
>> far as I can see.
> Yup, that's ok for me.
>
>>>
>>>> -       *temp = rk_tsadcv2_code_to_temp(val);
>>>>    -     return 0;
>>>> +       return rk_tsadcv2_code_to_temp(val, temp);
>>>>    }
>>>>      static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs, 
>>>> long
>>>> temp)
>>>
>> Thanks,
>> Dmitry
>>
>>
>>
>
