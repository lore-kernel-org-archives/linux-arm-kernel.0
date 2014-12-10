From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Dec 2014 22:33:22 +0100
Subject: [PATCH V3] arm: imx: correct the hardware clock gate setting
 for shared nodes
In-Reply-To: <ac72cb8f6219888aaf467648efd5a675@agner.ch>
References: <1418205102-14598-1-git-send-email-b20788@freescale.com>
 <ac72cb8f6219888aaf467648efd5a675@agner.ch>
Message-ID: <5f1fa200cd9ff9c8022b53b32578dfb2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-10 22:24, Stefan Agner wrote:
> On 2014-12-10 10:51, Anson Huang wrote:
>> For those clk gates which hold share count, since its is_enabled
>> callback is only checking the share count rather than reading
>> the hardware register setting, in the late phase of kernel bootup,
>> the clk_disable_unused action will NOT handle the scenario of
>> share_count is 0 but the hardware setting is enabled, actually,
>> U-Boot normally enables all clk gates, then those shared clk gates
>> will be always enabled until they are used by some modules.
> 
> Wow, this is one long sentence! :-) Could you split that up and simplify
> it a bit? Especially the "hold share count" part confused me at first, I
> thought you mean *share_count > 0, but you actually ment share_count !=
> NULL (maybe "clk gates which have share count allocated").
> 
>>
>> So the problem would be: when kernel boot up, the usecount cat
>> from clk tree is 0, but the clk gates actually is enabled in
>> hardware register, it will confuse user and bring unnecessary power
>> consumption.
>>
>> This patch adds .disable_unused callback and using hardware register
>> check for .is_enabled callback of shared nodes to handle such scenario
>> in late phase of kernel boot up, then the hardware status will match the
>> clk tree info.
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>> changes from V2:
>> 	1. uboot -> U-Boot;
>> 	2. add .is_enabled change into commit log;
>> 	3. improve the condition check code.
>>  arch/arm/mach-imx/clk-gate2.c |   23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
>> index 5a75cdc..8935bff 100644
>> --- a/arch/arm/mach-imx/clk-gate2.c
>> +++ b/arch/arm/mach-imx/clk-gate2.c
>> @@ -96,15 +96,30 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
>>  {
>>  	struct clk_gate2 *gate = to_clk_gate2(hw);
>>
>> -	if (gate->share_count)
>> -		return !!__clk_get_enable_count(hw->clk);
>> -	else
>> -		return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
>> +	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
>> +}
>> +
>> +static void clk_gate2_disable_unused(struct clk_hw *hw)
>> +{
>> +	struct clk_gate2 *gate = to_clk_gate2(hw);
>> +	unsigned long flags = 0;
>> +	u32 reg;
>> +
>> +	spin_lock_irqsave(gate->lock, flags);
>> +
>> +	if (!gate->share_count || *gate->share_count == 0) {
> 
> By introducing the .disable_unused callback the framework won't call the
> .disable callback anymore, even if enable_count is 0 and the clock is
> enabled according to .is_enabled. Wouldn't this interfere the disabling
> of normal, non-shared clock gates?
> 

Ok, see it now, we disable the clock in this if statement in the
share_count == NULL case... Sorry about that.

--
Stefan

>> +		reg = readl(gate->reg);
>> +		reg &= ~(3 << gate->bit_idx);
>> +		writel(reg, gate->reg);
>> +	}
>> +
>> +	spin_unlock_irqrestore(gate->lock, flags);
>>  }
>>
>>  static struct clk_ops clk_gate2_ops = {
>>  	.enable = clk_gate2_enable,
>>  	.disable = clk_gate2_disable,
>> +	.disable_unused = clk_gate2_disable_unused,
>>  	.is_enabled = clk_gate2_is_enabled,
>>  };
> 
> --
> Stefan
