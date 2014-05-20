From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 20 May 2014 08:17:40 +0200
Subject: [PATCH] ARM: imx: powerdown PLL before changing of its setting
In-Reply-To: <CAOMZO5CU4WQSpH3eR719p8JBi8=xumGwLtxA-GqKRm8Jh0Rwng@mail.gmail.com>
References: <1400060197-706-1-git-send-email-jiada_wang@mentor.com>
 <CAOMZO5CU4WQSpH3eR719p8JBi8=xumGwLtxA-GqKRm8Jh0Rwng@mail.gmail.com>
Message-ID: <537AF384.9070900@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 19.05.2014 19:31, Fabio Estevam wrote:
> Hi Jiada,
>
> On Wed, May 14, 2014 at 6:36 AM, Jiada Wang <jiada_wang@mentor.com> wrote:
>> According to i.MX6 user manual,  "Before changing the PLL setting,
>> power it down. Power up the PLL after the change"
>> But currently PLL setting is being updated without power-down
>> it first. This may end up with improper output/gitches which
>> prevents furture operation.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   arch/arm/mach-imx/clk-pllv3.c | 72 +++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 66 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
>> index 6136405..f77edd6 100644
>> --- a/arch/arm/mach-imx/clk-pllv3.c
>> +++ b/arch/arm/mach-imx/clk-pllv3.c
>> @@ -67,6 +67,42 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>>          return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
>>   }
>>
>> +static void clk_pllv3_powerdown(struct clk_pllv3 *pll)
>> +{
>> +       u32 val;
>> +
>> +       val = readl_relaxed(pll->base);
>> +       val |= BM_PLL_BYPASS;
>> +       writel_relaxed(val, pll->base);
>> +
>> +       if (pll->powerup_set)
>> +               val &= ~BM_PLL_POWER;
>> +       else
>> +               val |= BM_PLL_POWER;
>> +       writel_relaxed(val, pll->base);
>> +}
>> +
>> +static int clk_pllv3_powerrestore(struct clk_pllv3 *pll, u32 power, u32 bypass)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       val = readl_relaxed(pll->base);
>> +       val &= ~BM_PLL_POWER;
>
> Shouldn't this be:
>        if (pll->powerup_set)
>               val |= BM_PLL_POWER;
>         else
>               val &= ~BM_PLL_POWER;
>

Jiada will correct me if I'm wrong, but to my understanding the job of 
this function is to *restore* the previously configured power state (not 
to set any particular one).

The previously configured power state is passed in 'u32 power'. So we 
just mask out the POWER bit here to be able to restore the old power 
state, independent if it is 0 or 1. So I would think

+	val = readl_relaxed(pll->base);
+	val &= ~BM_PLL_POWER;
+	val |= power;
+	writel_relaxed(val, pll->base);

is correct here.

Best regards

Dirk
