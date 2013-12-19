From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 12:41:19 -0700
Subject: [PATCH 2/4] clk: tegra: add EMC clock driver
In-Reply-To: <1387446199.13057.26.camel@jlo-ubuntu-64.nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>	
 <1387272400-4689-3-git-send-email-josephl@nvidia.com>	
 <52B0D6FA.2060101@wwwdotorg.org>	
 <1387359758.2576.38.camel@jlo-ubuntu-64.nvidia.com>	
 <52B1E950.1040001@wwwdotorg.org>
 <1387446199.13057.26.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <52B34BDF.7010200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 02:43 AM, Joseph Lo wrote:
> On Thu, 2013-12-19 at 02:28 +0800, Stephen Warren wrote:
>> On 12/18/2013 02:42 AM, Joseph Lo wrote:
>>> On Wed, 2013-12-18 at 06:58 +0800, Stephen Warren wrote:
>>>> On 12/17/2013 02:26 AM, Joseph Lo wrote:
>>>>> Add External Memory Controller (EMC) clock interface for the Tegra CCF
>>>>> driver to support EMC scaling.
>>>>
>>>>> diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
>>>>
>>>>> +static long clk_emc_round_rate(struct clk_hw *hw, unsigned long rate,
>>>>> +			       unsigned long *prate)
>>>>> +{
>>>>> +	struct tegra_clk_emc *emc = to_clk_emc(hw);
>>>>> +	struct clk *parent_clk = __clk_get_parent(hw->clk);
>>>>> +	unsigned long parent_rate = __clk_get_rate(parent_clk);
>>>>> +	unsigned long ret;
>>>>> +
>>>>> +	if (!emc->emc_ops)
>>>>> +		return parent_rate;
>>>>> +
>>>>> +	ret = emc->emc_ops->emc_round_rate(rate);
>>>>> +	if (!ret)
>>>>> +		return parent_rate;
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>
>>>> Rather than implementing this custom "emc_ops" feature, isn't there a
>>>> standard clock notifier feature that the EMC driver can use?
>>>>
>>>> Isn't the EMC driver the only thing that will be changing the EMC clock
>>>> rate? If so, why not just have the EMC driver perform the appropriate
>>>> pre-/post-rate-change actions before/after calling clk_set_rate()?
>>>
>>> We have two HW components needs to be updated when EMC rate change. One
>>> is the EMC clock for tuning the frequency, the other is the EMC for
>>> updating the timing and configuration for external memory (DRAM). So
>>> this question looks like to me is that can we separate the operation of
>>> the two components when rate changing?
>>>
>>> We have two modes that depend on what memory type (DDR2, LPDDR2,
>>> DDR3/LP) we used on the platform to support EMC scaling.
>>> 1. power down mode (Tegra20 used this mode only.)
>>> In this mode, we update the EMC timing and configurations to EMC shadow
>>> registers. Then updating the rate in the EMC clock register. The HW will
>>> trigger the rate changing and timing/configurations updating for EMC.
>>> 2. self-refresh mode (Tegra30/114/124 if DDR3)
>>> More complicate in this mode. Putting DRAM in self-refresh, updating EMC
>>> settings, updating EMC clock, then we still need auto calibration before
>>> restores DRAM from the self-refresh mode. So the difference was the EMC
>>> clock operation was part of EMC scaling procedures.
>>>
>>> I guess using the clk_notifier may be OK for the 1st case.
>>
>> In both cases, isn't the overall operation something like:
>>
>> a) Do some work before changing the EMC clock
>> b) Change the EMC clock
>> c) Do some work after changing the EMC clock
>>
> Roughly say, yes. But ...
> 
> We still need an EMC clock driver. Currently there is no clock function
> in Tegra clock driver can just support it.
> 
> For example,
> 
> * the set_rate function
> We had an EMC table that includes whole the rates, EMC settings and EMC
> clock settings that we should run at the rate of MC/2 or same with MC.
> We can't just set the EMC clock rate without the info came from the
> table. It's pre-define, pre-setup for the platform and SDRAM module. So
> the operation can't be separated into PRE_RATE_CHANGE or
> POST_RATE_CHANGE.
> 
> * the round_rate function
> We also need to get a supported rate for the EMC/EMC clock from the EMC
> table.
> 
> If we ignore the case above, then we need a totally new EMC table that
> only supports fixed rate of MC rate and only support one mode for rate
> changing. That means only Tegra20 support it currently.

Isn't the EMC scaling driver the only driver that will call
clk_set_rate() on the EMC clock? As such, can't we assume that any value
passed to set_rate/round_rate for this one clock have already been
validated by the EMC driver, and hence the clock driver should just
blindly accept/apply it?
