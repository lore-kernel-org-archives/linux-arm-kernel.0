From: rjui@broadcom.com (Ray Jui)
Date: Tue, 6 Jan 2015 18:29:07 -0800
Subject: [PATCH v2 4/5] clk: cygnus: add clock support for Broadcom Cygnus
In-Reply-To: <2048376.BFrtW5tszK@wuerfel>
References: <1420500076-18302-5-git-send-email-rjui@broadcom.com>
 <2048376.BFrtW5tszK@wuerfel>
Message-ID: <54AC99F3.8040703@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/6/2015 12:21 PM, Arnd Bergmann wrote:
> On Monday 05 January 2015 15:21:15 Ray Jui wrote:
>> +static const struct iproc_clk_ctrl mipipll_clk[BCM_CYGNUS_NUM_MIPIPLL_CLKS] = {
>> +	[BCM_CYGNUS_MIPIPLL_CH0_UNUSED] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH0_UNUSED,
>> +		.enable = enable_val(0x4, 12, 6, 18),
>> +		.mdiv = reg_val(0x20, 0, 8),
>> +	},
>> +	[BCM_CYGNUS_MIPIPLL_CH1_LCD] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH1_LCD,
>> +		.enable = enable_val(0x4, 13, 7, 19),
>> +		.mdiv = reg_val(0x20, 10, 8),
>> +	},
>> +	[BCM_CYGNUS_MIPIPLL_CH2_UNUSED] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH2_UNUSED,
>> +		.enable = enable_val(0x4, 14, 8, 20),
>> +		.mdiv = reg_val(0x20, 20, 8),
>> +	},
>> +	[BCM_CYGNUS_MIPIPLL_CH3_UNUSED] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH3_UNUSED,
>> +		.enable = enable_val(0x4, 15, 9, 21),
>> +		.mdiv = reg_val(0x24, 0, 8),
>> +	},
>> +	[BCM_CYGNUS_MIPIPLL_CH4_UNUSED] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH4_UNUSED,
>> +		.enable = enable_val(0x4, 16, 10, 22),
>> +		.mdiv = reg_val(0x24, 10, 8),
>> +	},
>> +	[BCM_CYGNUS_MIPIPLL_CH5_UNUSED] = {
>> +		.channel = BCM_CYGNUS_MIPIPLL_CH5_UNUSED,
>> +		.enable = enable_val(0x4, 17, 11, 23),
>> +		.mdiv = reg_val(0x24, 20, 8),
>> +	},
>> +};
> 
> The tables look fairly regular. Is it possible that it's common
> to all iproc variants with a standard way to derive all other
> values from the channel index?
> 
Ah no. Not only it's different between different iproc variants, it's
also different between plls on the same soc.

>> +static const struct iproc_asiu_gate asiu_gate[BCM_CYGNUS_NUM_ASIU_CLKS] = {
>> +	[BCM_CYGNUS_ASIU_KEYPAD_CLK] =
>> +		asiu_gate_val(0x0, 7),
>> +	[BCM_CYGNUS_ASIU_ADC_CLK] =
>> +		asiu_gate_val(0x0, 9),
>> +	[BCM_CYGNUS_ASIU_PWM_CLK] =
>> +		asiu_gate_val(IPROC_CLK_INVALID_OFFSET, 0),
>> +};
> 
> Here I think a better binding would be to pass the gate value in the
> clock specifier, rather than an artificial index. That would let
> you get rid of the BCM_CYGNUS_ASIU_KEYPAD_CLK/BCM_CYGNUS_ASIU_ADC_CLK
> macros.
> 
You meant to pass in both the gate register offset and its bit shift
through the clock specifier? But isn't the current ASIU clock code much
more consistent with the rest of the iProc clock code?

>> +static void __init cygnus_armpll_init(struct device_node *node)
>> +{
>> +	iproc_armpll_setup(node);
>> +}
>> +CLK_OF_DECLARE(cygnus_armpll, "brcm,cygnus-armpll", cygnus_armpll_init);
> 
> How about moving all of these directly next to the tables, to keep
> each clock controller?
> 
Good suggestion. That would make it more clear and easier to read. Will do.

>> +static void __init cygnus_genpll_clk_init(struct device_node *node)
>> +{
>> +	iproc_clk_setup(node, genpll_clk, BCM_CYGNUS_NUM_GENPLL_CLKS);
>> +}
> 
> If you use ARRAY_SIZE here, you can remove the BCM_CYGNUS_NUM_GENPLL_CLKS
> macro that is not useful to the DT binding.
> 
Agreed. Will do this for all iproc clock setup calls. Thanks.

> 	Arnd
> 
