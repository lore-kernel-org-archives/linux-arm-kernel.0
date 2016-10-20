From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 20 Oct 2016 17:44:44 +0200
Subject: [PATCH v2 5/6] clk: stm32f469: Add QSPI clock
In-Reply-To: <20161019203228.GC8871@codeaurora.org>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-6-git-send-email-gabriel.fernandez@st.com>
 <20161019203228.GC8871@codeaurora.org>
Message-ID: <ce7829db-a858-2de9-f9e5-89c6642262b1@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen


On 10/19/2016 10:32 PM, Stephen Boyd wrote:
> On 10/14, gabriel.fernandez at st.com wrote:
>> @@ -532,10 +618,42 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
>>   	{ 0 },
>>   };
>>   
>> +struct stm32f4_clk_data {
>> +	const struct stm32f4_gate_data *gates_data;
>> +	const u64 *gates_map;
>> +	int gates_num;
>> +};
>> @@ -549,6 +667,19 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>>   		goto fail;
>>   	}
>>   
>> +	match = of_match_node(stm32f4_of_match, np);
>> +	if (WARN_ON(!match))
>> +		return;
>> +
>> +	data = match->data;
>> +
>> +	clks = kmalloc_array(data->gates_num + END_PRIMARY_CLK,
>> +			sizeof(struct clk_hw *), GFP_KERNEL);
> sizeof(*clks)?
ok

>
>> +	if (!clks)
>> +		goto fail;
>> +
>> +	stm32f4_gate_map = data->gates_map;
>> +
>>   	hse_clk = of_clk_get_parent_name(np, 0);
>>   
>>   	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
>> @@ -581,11 +712,15 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>>   	clks[FCLK] = clk_hw_register_fixed_factor(NULL, "fclk", "ahb_div",
>>   					       0, 1, 1);
>>   
>> -	for (n = 0; n < ARRAY_SIZE(stm32f4_gates); n++) {
>> -		const struct stm32f4_gate_data *gd = &stm32f4_gates[n];
>> -		unsigned int secondary =
>> -		    8 * (gd->offset - STM32F4_RCC_AHB1ENR) + gd->bit_idx;
>> -		int idx = stm32f4_rcc_lookup_clk_idx(0, secondary);
>> +	for (n = 0; n < data->gates_num; n++) {
>> +		const struct stm32f4_gate_data *gd;
>> +		unsigned int secondary;
>> +		int idx;
>> +
>> +		gd = (struct stm32f4_gate_data *) &data->gates_data[n];
> Why do we cast here? Get rid of const? Perhaps the struct
> shouldn't have const on the member instead?
we don't need cast here.

Thank's Stephen

BR
Gabriel
>
>> +		secondary = 8 * (gd->offset - STM32F4_RCC_AHB1ENR) +
>> +			gd->bit_idx;
>> +		idx = stm32f4_rcc_lookup_clk_idx(0, secondary);
>>   
>>   		if (idx < 0)
