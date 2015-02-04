From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Feb 2015 15:33:27 -0800
Subject: [PATCH v4 2/5] clk: iproc: add initial common clock support
In-Reply-To: <54D2A7B7.6020007@codeaurora.org>
References: <Ray Jui <rjui@broadcom.com>
 <1422988390-24369-1-git-send-email-rjui@broadcom.com>
 <1422988390-24369-3-git-send-email-rjui@broadcom.com>
 <54D2A7B7.6020007@codeaurora.org>
Message-ID: <54D2AC47.8080201@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/4/2015 3:13 PM, Stephen Boyd wrote:
> On 02/03/15 10:33, Ray Jui wrote:
>> +/*
>> + * Get the clock rate based on name
>> + */
>> +static unsigned long __get_rate(const char *clk_name)
>> +{
>> +	struct clk *clk;
>> +
>> +	clk = __clk_lookup(clk_name);
>> +	if (!clk) {
>> +		pr_err("%s: unable to find clock by name: %s\n", __func__,
>> +				clk_name);
>> +		return 0;
>> +	}
>> +
>> +	return clk_get_rate(clk);
>> +}
>> +
> 
> This looks like something we should be providing in the core framework.
> Care to make it into an of_clk_get_parent_rate() API?
> 

I would love to! Note __get_rate here is really getting the clock rate
with a name provided. Can you be more specific on what you want? If I'm
not mistaken, what you really want is this?

unsigned long of_clk_get_parent_rate(struct device_node *np, int index);

>> +extern void __init iproc_armpll_setup(struct device_node *node);
>> +extern void __init iproc_pll_setup(struct device_node *node,
>> +		const struct iproc_pll_ctrl *ctrl,
>> +		const struct iproc_pll_vco_freq_param *vco_param,
>> +		unsigned int num_freqs);
>> +extern void __init iproc_clk_setup(struct device_node *node,
>> +		const struct iproc_clk_ctrl *ctrl, unsigned int num_clks);
>> +extern void __init iproc_asiu_setup(struct device_node *node,
>> +		const struct iproc_asiu_div *div,
>> +		const struct iproc_asiu_gate *gate, unsigned int num_clks);
> 
> __init is not necessary in header files.
> 

Okay I'll remove __init. Thanks.

Ray
