From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 14:50:51 +0100
Subject: [PATCH 1/2 v3] i2c: exynos5: add support for HSI2C on Exynos5260
 SoC
In-Reply-To: <52F38EA4.10805@samsung.com>
References: <1385100851-32254-1-git-send-email-ch.naveen@samsung.com>
 <1391688408-8077-1-git-send-email-ch.naveen@samsung.com>
 <52F38EA4.10805@samsung.com>
Message-ID: <52F3933B.9090202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, please use correct addresses of DT ML and Wolfram's e-mail (fixed 
in this message).

Best regards,
Tomasz

On 06.02.2014 14:31, Tomasz Figa wrote:
> Hi Naveen,
>
> On 06.02.2014 13:06, Naveen Krishna Chatradhi wrote:
>> This patch implements a variant struct to handle the differences
>> (like fifo_depths) in the HSI2C modules across SoCs.
>>
>> Adds a new compatible to support HSI2C module on Exynos5260.
>> Also resets the module as an init sequence (Needed by Exynos5260).
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> ---
>> Changes since v2:
>> 1. Used variant struct as suggested by Tomasz Figa.
>> 2. Change compatible strings from samsung,exynos5-hsi2c to
>>     samsung,exynos5250-hsi2c based on the first SoC to see the feature.
>> 3. Using reset as init sequences.
>> 4. Merged the 2 patches into one.
>>
>>   .../devicetree/bindings/i2c/i2c-exynos5.txt        |    8 ++-
>>   drivers/i2c/busses/i2c-exynos5.c                   |   64
>> ++++++++++++++++----
>>   2 files changed, 58 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
>> b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
>> index 056732c..5bc4998 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
>> @@ -5,7 +5,11 @@ at various speeds ranging from 100khz to 3.4Mhz.
>>
>>   Required properties:
>>     - compatible: value should be.
>> -      -> "samsung,exynos5-hsi2c", for i2c compatible with exynos5 hsi2c.
>
> Device tree bindings need to be backwards compatible, so you need to
> keep this compatible string supported, just marked as (DEPRECATED).
>
> Driver-wise, it will use the same driver data / variant struct as
> "samsung,exynos5250-hsi2c", just one more entry in OF match table is
> needed.
>
>> +    -> "samsung,exynos5250-hsi2c", for i2c compatible with HSI2C
>> available
>> +                on Exynos5250 and Exynos5420 SoCs.
>> +    -> "samsung,exynos5260-hsi2c", for i2c compatible with HSI2C
>> available
>> +                on Exynos5260 SoCs.
>> +
>>     - reg: physical base address of the controller and length of
>> memory mapped
>>       region.
>>     - interrupts: interrupt number to the cpu.
>> @@ -26,7 +30,7 @@ Optional properties:
>>   Example:
>>
>>   hsi2c at 12ca0000 {
>> -    compatible = "samsung,exynos5-hsi2c";
>> +    compatible = "samsung,exynos5250-hsi2c";
>>       reg = <0x12ca0000 0x100>;
>>       interrupts = <56>;
>>       clock-frequency = <100000>;
>
> [snip]
>
>> @@ -483,6 +514,7 @@ static void exynos5_i2c_message_start(struct
>> exynos5_i2c *i2c, int stop)
>>       u32 i2c_auto_conf = 0;
>>       u32 fifo_ctl;
>>       unsigned long flags;
>> +    unsigned short trig_lvl;
>>
>>       i2c_ctl = readl(i2c->regs + HSI2C_CTL);
>>       i2c_ctl &= ~(HSI2C_TXCHON | HSI2C_RXCHON);
>> @@ -493,13 +525,19 @@ static void exynos5_i2c_message_start(struct
>> exynos5_i2c *i2c, int stop)
>>
>>           i2c_auto_conf = HSI2C_READ_WRITE;
>>
>> -        fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(HSI2C_DEF_TXFIFO_LVL);
>> +        trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
>> +            (i2c->variant->fifo_depth * 3/4) : i2c->msg->len;
>> +        fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(trig_lvl);
>> +
>
> This is a rather serious semantic change, that doesn't look to belong to
> this patch. If this is needed, it should be done in a separate patch.
>
>>           int_en |= (HSI2C_INT_RX_ALMOSTFULL_EN |
>>               HSI2C_INT_TRAILING_EN);
>>       } else {
>>           i2c_ctl |= HSI2C_TXCHON;
>>
>> -        fifo_ctl |= HSI2C_TXFIFO_TRIGGER_LEVEL(HSI2C_DEF_RXFIFO_LVL);
>> +        trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
>> +            (i2c->variant->fifo_depth * 1/4) : i2c->msg->len;
>> +        fifo_ctl |= HSI2C_TXFIFO_TRIGGER_LEVEL(trig_lvl);
>> +
>
> Ditto.
>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
