From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Dec 2012 15:14:02 -0700
Subject: [PATCH 4/4] ARM: tegra: Set SCU base address dynamically from DT
In-Reply-To: <50CF258E.2080207@gmail.com>
References: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
 <1355725087-11363-4-git-send-email-hdoyu@nvidia.com>
 <50CF258E.2080207@gmail.com>
Message-ID: <50CF992A.8080008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 07:00 AM, Rob Herring wrote:
> On 12/17/2012 12:18 AM, Hiroshi Doyu wrote:
>> Set Snoop Control Unit(SCU) register base address dynamically from DT.

>> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c

>>  static void __init tegra_smp_init_cpus(void)
>>  {
>> -	unsigned int i, ncores = scu_get_core_count(scu_base);
>> +	struct device_node *np;
>> +	unsigned int i, ncores = 1;
>> +
>> +	np = of_find_matching_node(NULL, cortex_a9_scu_match);
>> +	if (!np)
>> +		return;
>> +	scu_base = of_iomap(np, 0);
> 
> Did you actually test this? Unless something changed, ioremap does not
> work this early. The only reason to have it mapped this early is to get
> the core count, but that doesn't work on A15 or A7. So we really need to
> get core count/mask in a standard way. At least some work to get core
> count from DT went into 3.8.

Does it work if the machine's .map_io() function has set up a static
mapping that includes the specified region? I believe that is the case
on Tegra. What is the alternative if the registers can't be mapped;
should the code count the number of child nodes in /cpus?
