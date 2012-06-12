From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 11:39:01 +0100
Subject: [PATCH v7 00/12] Per SoC descriptor
In-Reply-To: <201206081454.46422.arnd@arndb.de>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <201206081454.46422.arnd@arndb.de>
Message-ID: <4FD71C45.3010206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/12 15:54, Arnd Bergmann wrote:
> On Thursday 07 June 2012, Marc Zyngier wrote:
>> [As per Arnd request, I've updated this patch series, in the hope that
>> it could be useful to the single zImage work]
>>
>> This patch series introduces a per-soc descriptor which should, in the
>> end, contain most of the SoC specific operations.
>>
>> This first patch series introduces the arm_soc_desc structure, adds
>> per-soc SMP and CPU hotplug operations, and converts all SMP platform
>> to this new scheme.
>>
>> Patches against v3.5-rc1. Tested on VExpress (Cortex A15).
>>
>> Also available at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git soc_desc-v3.5-rc1
> 
> With my experimental multiplatform kernel tree, it let me actually build
> an allyesconfig including SMP enabled, so just for that you get an
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

> Two comments though:
> 
> 1. I needed the patch below to avoid conflicting pen_release symbols.
> I was not sure if any of the platforms rely on the pen_release variable
> being located in the same cache line or page as the code accessing it,
> or why else it is defined in assembly. If we don't have a reason for that,
> we should probably pick the simpler approach and just have a single
> definition for this in common ARM SMP code.

I have mixed feelings about this. On most hardware, CPU power management
should make the use of pen_release obsolete (it only makes sense if you
cannot turn off the power).

On the other hand, given how "popular" the versatile implementation is,
we might as well consolidate it. I've queued a patch to that effect, but
I'd really like platform maintainers to realize how wrong they are.

> 2. Sorry for having to bring it up yet again, but it still feels silly
> to have the split data structures when nothing in the code actually
> checks whether the functions are __init or __cpuinit, which was the
> intention for splitting the struct in the first place according to
> Nico. If people still like the split, I'll just shut up, but I would
> prefer if this could be converted (back) into a single 'struct smp_ops'
> with function pointers and no "name" field or the ambition to add
> stuff other than SMP callbacks.

Right. I now have a slightly simpler/smaller series, which only cares
about SMP and have a single structure approach (though it still uses
split structures internally):

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
smp_ops-v3.5-rc2

I'll post it later today.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
