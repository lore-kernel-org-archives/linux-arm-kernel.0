From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 17 Jul 2018 15:30:08 +0200
Subject: [PATCH 2/2] pinctrl: stm32: add syscfg mask parameter
In-Reply-To: <4acc415d-f162-67a2-57d6-0a7defda434f@st.com>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
 <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
 <4acc415d-f162-67a2-57d6-0a7defda434f@st.com>
Message-ID: <c698126e-3b45-b5d1-b1eb-8503a06050aa@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/17/2018 03:11 PM, Ludovic BARRE wrote:
> Hi
> 
> add Rob, I forgotten rob's mail.
> 
> On 07/17/2018 11:56 AM, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds mask parameter to define IRQ mux field.
>> This field could vary depend of IRQ mux selection register.
>> To avoid backward compatibility, the drivers set
>> the legacy value by default.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>


>> ---
>> ? drivers/pinctrl/stm32/pinctrl-stm32.c | 16 ++++++++++++++--
>> ? 1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c 
>> b/drivers/pinctrl/stm32/pinctrl-stm32.c
>> index dfed609..f756232 100644
>> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
>> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
>> @@ -46,6 +46,8 @@
>> ? #define STM32_GPIO_PINS_PER_BANK 16
>> ? #define STM32_GPIO_IRQ_LINE???? 16
>> +#define SYSCFG_IRQMUX_MASK GENMASK(3, 0)
>> +
>> ? #define gpio_range_to_bank(chip) \
>> ????????? container_of(chip, struct stm32_gpio_bank, range)
>> @@ -1033,6 +1035,7 @@ static int stm32_pctrl_dt_setup_irq(struct 
>> platform_device *pdev,
>> ????? struct device *dev = &pdev->dev;
>> ????? struct regmap *rm;
>> ????? int offset, ret, i;
>> +??? int mask, mask_width;
>> ????? parent = of_irq_find_parent(np);
>> ????? if (!parent)
>> @@ -1052,12 +1055,21 @@ static int stm32_pctrl_dt_setup_irq(struct 
>> platform_device *pdev,
>> ????? if (ret)
>> ????????? return ret;
>> +??? ret = of_property_read_u32_index(np, "st,syscfg", 2, &mask);
>> +??? if (ret)
>> +??????? mask = SYSCFG_IRQMUX_MASK;
>> +
>> +??? mask_width = fls(mask);
>> +
>> ????? for (i = 0; i < STM32_GPIO_PINS_PER_BANK; i++) {
>> ????????? struct reg_field mux;
>> ????????? mux.reg = offset + (i / 4) * 4;
>> -??????? mux.lsb = (i % 4) * 4;
>> -??????? mux.msb = mux.lsb + 3;
>> +??????? mux.lsb = (i % 4) * mask_width;
>> +??????? mux.msb = mux.lsb + mask_width - 1;
>> +
>> +??????? dev_dbg(dev, "irqmux%d: reg:%#x, lsb:%d, msb:%d\n",
>> +??????????? i, mux.reg, mux.lsb, mux.msb);
>> ????????? pctl->irqmux[i] = devm_regmap_field_alloc(dev, rm, mux);
>> ????????? if (IS_ERR(pctl->irqmux[i]))
>>
