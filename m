From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Feb 2012 01:57:08 +0100
Subject: [PATCH v6 13/15] ARM: hotplug: Introduce
 =?UTF-8?Q?dummy=5Fcpu=5Fkill?=
In-Reply-To: <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-14-git-send-email-marc.zyngier@arm.com>
 <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
Message-ID: <6744403449c559f689ca7322eb0393b8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 8 Feb 2012 16:16:24 -0800 (PST), Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Wed, 8 Feb 2012, Marc Zyngier wrote:
> 
>> Most platforms don't implement their cpu_kill method.
>> Some because they simply don't offer the capability, some other
>> because nobody cared enough to implement the necessary code.
>> 
>> Either way, this code is duplicated all over the place. Implement
>> a global dummy_cpu_kill method and convert all SMP (but shmobile)
>> to use it. Hopefully the "dummy" prefix will be an incentive
>> for people to do the right thing.
>> 
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Colin Cross <ccross@android.com>
>> Cc: David Brown <davidb@codeaurora.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Nicolas Pitre <nico@fluxnic.net>
>> Cc: Paul Mundt <lethal@linux-sh.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> What avout this instead:
> 
> int __weak __cpuinit platform_cpu_kill(unsigned int cpu)
> {
> 	if (!soc_smp_ops)
> 		return 0;
> 	if (!soc_smp_ops->cpu_kill)
> 		return 1;
> 	return soc_smp_ops->cpu_kill(cpu);
> }
> 
> and get rid of the dummy handler entirely?

I thought the "dummy" prefix would maybe give maintainers a chance to
think whether or not this is the best they can do (given that they mostly
copied the RealView code, I'm quite sure it is possible...). I'll use your
approach if you think it's better.

        M.
-- 
Fast, cheap, reliable. Pick two.
