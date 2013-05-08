From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 May 2013 12:44:26 -0600
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
In-Reply-To: <518A2EB2.70006@linaro.org>
References: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
 <518A2EB2.70006@linaro.org>
Message-ID: <518A9D0A.3010908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2013 04:53 AM, Daniel Lezcano wrote:
> On 05/06/2013 10:39 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
>> they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
>> this, simply disable LP2 if the PCI driver and DT node are both enabled.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Thierry,
>>
>> This patch is physically based on next-20130506 so that it doesn't
>> conflict with any of the recent cpuidle cleanup work. I'm sending it with
>> the expectation that you'll apply it to your PCIe development branch
>> though. If you do that, you'll see some conflicts unless you rebase your
>> dev branch onto something more recent than next-20130422; I assume you'll
>> do that rebase soon enough anyway, but if you weren't planning to, I can
>> resend the patch based on your current dev branch.
>>
>>  arch/arm/mach-tegra/cpuidle-tegra20.c |   30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> index 0cdba8d..d2c9349 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/cpu_pm.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/clk/tegra.h>
>> +#include <linux/of.h>
>>  
>>  #include <asm/cpuidle.h>
>>  #include <asm/proc-fns.h>
>> @@ -212,10 +213,39 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
>>  }
>>  #endif
>>  
>> +static const struct of_device_id pcie_matches[] __initconst = {
>> +	{ .compatible = "nvidia,tegra20-pcie" },
>> +	{ }
>> +};
>> +
>> +/*
>> + * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
>> + * they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
>> + * this, simply disable LP2 if the PCI driver and DT node are both enabled.
>> + */
>> +static void __init tegra20_cpuidle_disable_lp2_with_pcie(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	if (!IS_ENABLED(CONFIG_PCI_TEGRA))
>> +		return;
>> +
>> +	np = of_find_matching_node(NULL, pcie_matches);
>> +	if (!np)
>> +		return;
>> +
>> +	if (!of_device_is_available(np))
>> +		return;
>> +
>> +	pr_info("Disabling LP2 cpuidle state, since PCIe is enabled\n");
>> +	tegra_idle_driver.state_count = 1;
> 
> Won't be more clear to have the state disabled in the init function like
> this ?
> 
> int __init tegra20_cpuidle_init(void)
> {
> 	...
> 	if (tegra20_has_lp2_pcie_bug(void))
> 		tegra_idle_driver.states[1].disabled = true;
> 	...
> }

I'm not sure that's any clearer on its own. One big advantage of that
technique is that if we end up with 3 cpuidle states and need to disable
the one in the middle, this alternative technique does work, whereas the
one in my patch doesn't. So, I'll convert to this technique.
