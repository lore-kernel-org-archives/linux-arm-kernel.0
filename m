From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 10 Oct 2016 13:32:06 +0200
Subject: [PATCH] Reorganize STM32 clocks in order to prepare them for
 PLLI2S and PLLSAI
In-Reply-To: <b6fd21b7-75a6-c38d-a9f1-fbf07132a1d3@linaro.org>
References: <1475791294-5804-1-git-send-email-user@localhost>
 <2d6d5c10-346e-0541-1bc0-b75ef5b40d3f@linaro.org>
 <CAFvLkMQjDZysgoT3FfkVP8UQVkqghW9=CZU-OEmGUAdMR7CO2A@mail.gmail.com>
 <b6fd21b7-75a6-c38d-a9f1-fbf07132a1d3@linaro.org>
Message-ID: <1880a125-b5ec-b64a-5c9b-90d4e9c0af86@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radoslaw,

I add Gabriel in the discussion. Gabriel is updating PLL management for 
STM32F429.

Regards
Alex

On 10/10/2016 12:31 PM, Daniel Thompson wrote:
> On 10/10/16 10:56, Rados?aw Pietrzyk wrote:
>> Hi,
>> all plls have the same clock parent which is after a main divider.
>> Currently the divider and multiplier are connected together within vco
>> clock and therefore there is no chance to reuse the divider and clearly
>> state where the conncetion "really" is. We can arrange all of them
>> separately but than the divider will be hidden for all of them
>> separately.
>
> Quoting my last mail "I can see the value of naming the "/M"
> pre-division separately". In other words I agree with the idea of the
> patch.
>
> To more explicitly state my review comments...
>
>> From: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>
> Please add a explanation of the problem and solution in the patch
> description.
>
>
>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>> ---
>>  drivers/clk/clk-stm32f4.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
>> index 02d6810..1fd3eac 100644
>> --- a/drivers/clk/clk-stm32f4.c
>> +++ b/drivers/clk/clk-stm32f4.c
>> @@ -245,9 +245,10 @@ static void stm32f4_rcc_register_pll(const char
> *hse_clk, const char *hsi_clk)
>>      const char   *pllsrc = pllcfgr & BIT(22) ? hse_clk : hsi_clk;
>>      unsigned long pllq   = (pllcfgr >> 24) & 0xf;
>>
>> -    clk_register_fixed_factor(NULL, "vco", pllsrc, 0, plln, pllm);
>> -    clk_register_fixed_factor(NULL, "pll", "vco", 0, 1, pllp);
>> -    clk_register_fixed_factor(NULL, "pll48", "vco", 0, 1, pllq);
>> +    clk_register_fixed_factor(NULL, "vco-div", pllsrc, 0, 1, pllm);
>
> This strikes me as a bad name for a clock that is shared by all three
> PLLs (the vco being an internal component of the PLL) however since the
> clock is not named in the datasheet we are forced to invent a name [I
> suspect that's why I gave up trying to name it when I wrote the driver
> originally ;-) ].
>
> Perhaps "pllin-prediv"?
>
>
>> +    clk_register_fixed_factor(NULL, "vco-mul", "vco-div", 0, plln, 1);
>
> Why rename this clock? Multiplying is a what the vco (and its control
> circuits) is *for*. Tagging it "-mul" is meaningless.
>
>
> Daniel.
