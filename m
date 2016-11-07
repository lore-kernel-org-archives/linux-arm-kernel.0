From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Mon, 7 Nov 2016 15:14:18 +0100
Subject: [PATCH 3/6] clk: stm32f4: Add post divisor for I2S & SAI PLLs and
 Add lcd-tft clock
In-Reply-To: <860ce6a2-066f-2b44-3cf5-2d73720ed588@linaro.org>
References: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
 <1478523943-23142-4-git-send-email-gabriel.fernandez@st.com>
 <860ce6a2-066f-2b44-3cf5-2d73720ed588@linaro.org>
Message-ID: <e7cf5464-f6e7-37b3-dccb-294ab8231256@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,


On 11/07/2016 02:58 PM, Daniel Thompson wrote:
> On 07/11/16 13:05, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch adds post dividers of I2S & SAI PLLs.
>> These dividers are managed by a dedicated register (RCC_DCKCFGR).
>> The PLL should be off before a set rate.
>> This patch also introduces the lcd-tft clock.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>  drivers/clk/clk-stm32f4.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
>> index dda15bc..5fa5d51 100644
>> --- a/drivers/clk/clk-stm32f4.c
>> +++ b/drivers/clk/clk-stm32f4.c
>> @@ -215,6 +215,7 @@ struct stm32f4_gate_data {
>>  enum {
>>      SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC,
>>      PLL_VCO_I2S, PLL_VCO_SAI,
>> +    CLK_LCD,
>>      END_PRIMARY_CLK
>>  };
>>
>> @@ -599,6 +600,9 @@ static struct clk_hw *clk_register_pll_div(const 
>> char *name,
>>  static const struct clk_div_table pll_divp_table[] = {
>>      { 0, 2 }, { 1, 4 }, { 2, 6 }, { 3, 8 },
>>  };
>> +static const struct clk_div_table pll_lcd_div_table[] = {
>> +    { 0, 2 }, { 1, 4 }, { 2, 8 }, { 3, 16 },
>> +};
>>
>>  /*
>>   * Decode current PLL state and (statically) model the state we 
>> inherit from
>> @@ -659,16 +663,35 @@ static struct clk_hw 
>> *stm32f4_rcc_register_pll(const char *pllsrc,
>>          clk_register_pll_div(data->p_name, data->vco_name, 0, reg,
>>                  16, 2, 0, pll_divp_table, pll_hw, lock);
>>
>> -    if (data->q_name)
>> +    if (data->q_name) {
>>          clk_register_pll_div(data->q_name, data->vco_name, 0, reg,
>>                  24, 4, CLK_DIVIDER_ONE_BASED, NULL,
>>                  pll_hw, lock);
>>
>> -    if (data->r_name)
>> +        if (data->pll_num == PLL_I2S)
>> +            clk_register_pll_div("plli2s-q-div", data->q_name,
>> +                0, base + STM32F4_RCC_DCKCFGR,
>> +                0, 5, 0, NULL, pll_hw, &stm32f4_clk_lock);
>> +
>> +        if (data->pll_num == PLL_SAI)
>> +            clk_register_pll_div("pllsai-q-div", data->q_name,
>> +                0, base + STM32F4_RCC_DCKCFGR,
>> +                8, 5, 0, NULL, pll_hw, &stm32f4_clk_lock);
>> +    }
>
> Shouldn't this be in the config structures?
>
> It seems very odd to me to allow the config structures to control 
> whether we take the branch or not and then add these hard coded hacks.
>
ok i will put it in the config structure.

BR
Gabriel.

>
> Daniel.
