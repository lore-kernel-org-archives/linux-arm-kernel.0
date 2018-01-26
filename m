From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jan 2018 14:23:55 +0000
Subject: [PATCH 4/7] arm64: kpti: Add ->enable callback to remap swapper
 using nG mappings
In-Reply-To: <20180126140546.GA25364@arm.com>
References: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
 <1516968197-23206-5-git-send-email-will.deacon@arm.com>
 <2d89624a-ccc2-78a0-deaf-e0494636659a@arm.com>
 <20180126140546.GA25364@arm.com>
Message-ID: <4e3fa769-fcd8-c81f-c222-bbb2505d12ae@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/18 14:05, Will Deacon wrote:
> Hi Marc,
> 
> On Fri, Jan 26, 2018 at 01:40:50PM +0000, Marc Zyngier wrote:
>> On 26/01/18 12:03, Will Deacon wrote:
>>> +/*
>>> + * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
>>> + *
>>> + * Called exactly once from stop_machine context by each CPU found during boot.
>>> + */
>>> +__idmap_kpti_flag:
>>> +	.long	1
>>
>> I'm a bit concerned that we're placing the counter in a section that is
>> not writeable (at least in theory). We can either have the idmap
>> writeable entirely, or have a idmap data section (which means extending
>> it to be more than a single page).
> 
> The idmap is mapped using the same attributes as the initial swapper
> mappings (SWAPPER_MM_MMUFLAGS) but, unlike swapper, it is not subsequently
> remapped and therefore remains writeable.
> 
> I could update the .pushsection flags to reflect this with "awx"?

I think it would at least reflect both the expectations of this code and
what the mapping code does.

> 
> Also, whilst looking around in head.S, I noticed phys_to_pte. I'll move
> that into assembler.h and switch the argument order as a separate patch.
> 
>> Not sure if that's a concern, but I thought I'd raise it. The core works
>> pretty well as is, so  it cannot be completely wrong... ;-)
> 
> Is that a Tested-by? ;)

Since I'm lucky enough to have access to a ThunderX, here's one ;-)
Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Also:
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
