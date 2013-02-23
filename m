From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 23 Feb 2013 16:59:25 -0700
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for secondary
 CPUs
In-Reply-To: <1361604480.1804.59.camel@jlo-ubuntu-64.nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
 <5127BAD2.8030904@wwwdotorg.org>
 <1361604480.1804.59.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <512957DD.8040406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2013 12:28 AM, Joseph Lo wrote:
> On Sat, 2013-02-23 at 02:37 +0800, Stephen Warren wrote:
>> On 02/21/2013 11:44 PM, Joseph Lo wrote:
>>> Adding the power on function for secondary CPUs in PMC driver, this can
>>> help us to remove legacy powergate driver and add generic power domain
>>> support later.
>>
>>> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
>>> +static int tegra_pmc_get_cpu_powerdomain_id(int cpuid)
>>> +{
>>> +	if (cpuid <= 0 || cpuid > num_possible_cpus())
>>
>> cpuid >= num_possible_cpus()?
>>
> Yes.
> 
>>> +static int tegra_pmc_powergate_set(int id, bool new_state)
>>> +{
>>> +	bool status;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&tegra_powergate_lock, flags);
>>> +
>>> +	status = tegra_pmc_readl(PMC_PWRGATE_STATUS) & (1 << id);
>>
>> I would perform the read and the logical operations separately. Same for
>> the write below.
>>
>> Don't you want to and with ~BIT(id) not BIT(id)?
>>
> This is what I want.
> WARN_ON(!(!!(status & BIT(id)) ^ new_state));

Oh sorry, I guess this isn't a standard read-modify-write cycle, but
something else.

So yes, the & in the register read is probably fine as you have it, but
yes there is an issue in the current WARN_ON comparison, as you say.

The WARN_ON you gave above is rather complex. Simplest might be:

u32 reg = tegra_pmc_readl(PMC_PWRGATE_STATUS);
bool old_state = (reg >> id) & 1;
WARN_ON(new_state == old_state);
