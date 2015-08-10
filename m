From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 10 Aug 2015 14:37:42 +0800
Subject: [PATCH] thermal: rockhip: fix setting thermal shutdown polarity
In-Reply-To: <55C84611.10904@rock-chips.com>
References: <20150807210052.GA34032@dtor-ws> <55C84611.10904@rock-chips.com>
Message-ID: <55C846B6.2050303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, forgot it!
\s 'rockhip' to 'rockchip' :-)

? 2015?08?10? 14:34, Caesar Wang ??:
> Dear Dmitry,
>
> Thanks to work for it.
>
> ? 2015?08?08? 05:00, Dmitry Torokhov ??:
>> When requested thermal shutdown signal polarity is low we need to make
>> sure that the bit representing high level of signal is reset, and not
>> set all other bits in that register.
>>
>> Also rename TSADCV2_INT_PD_CLEAR to TSADCV2_INT_PD_CLEAR_MASK to better
>> reflect its nature.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>
>  Acked-by: Caesar Wang <wxt@rock-chips.com>
>
> -- 
> Thanks,
> Caesar
>
>> ---
>>   drivers/thermal/rockchip_thermal.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c 
>> b/drivers/thermal/rockchip_thermal.c
>> index 93ee307..4d5b7d4 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -106,16 +106,14 @@ struct rockchip_thermal_data {
>>   #define TSADCV2_AUTO_PERIOD_HT            0x6c
>>     #define TSADCV2_AUTO_EN                BIT(0)
>> -#define TSADCV2_AUTO_DISABLE            ~BIT(0)
>>   #define TSADCV2_AUTO_SRC_EN(chn)        BIT(4 + (chn))
>>   #define TSADCV2_AUTO_TSHUT_POLARITY_HIGH    BIT(8)
>> -#define TSADCV2_AUTO_TSHUT_POLARITY_LOW        ~BIT(8)
>>     #define TSADCV2_INT_SRC_EN(chn)            BIT(chn)
>>   #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)        BIT(4 + (chn))
>>   #define TSADCV2_SHUT_2CRU_SRC_EN(chn)        BIT(8 + (chn))
>>   -#define TSADCV2_INT_PD_CLEAR            ~BIT(8)
>> +#define TSADCV2_INT_PD_CLEAR_MASK        ~BIT(8)
>>     #define TSADCV2_DATA_MASK            0xfff
>>   #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT    4
>> @@ -244,10 +242,10 @@ static void rk_tsadcv2_initialize(void __iomem 
>> *regs,
>>                     enum tshut_polarity tshut_polarity)
>>   {
>>       if (tshut_polarity == TSHUT_HIGH_ACTIVE)
>> -        writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_HIGH),
>> +        writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
>>                      regs + TSADCV2_AUTO_CON);
>>       else
>> -        writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_LOW),
>> +        writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
>>                      regs + TSADCV2_AUTO_CON);
>>         writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + 
>> TSADCV2_AUTO_PERIOD);
>> @@ -264,7 +262,7 @@ static void rk_tsadcv2_irq_ack(void __iomem *regs)
>>       u32 val;
>>         val = readl_relaxed(regs + TSADCV2_INT_PD);
>> -    writel_relaxed(val & TSADCV2_INT_PD_CLEAR, regs + TSADCV2_INT_PD);
>> +    writel_relaxed(val & TSADCV2_INT_PD_CLEAR_MASK, regs + 
>> TSADCV2_INT_PD);
>>   }
>>     static void rk_tsadcv2_control(void __iomem *regs, bool enable)
>
