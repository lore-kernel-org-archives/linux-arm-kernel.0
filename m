From: james.morse@arm.com (James Morse)
Date: Thu, 21 Jun 2018 11:24:07 +0100
Subject: [PATCH 3/3] arm64: IPI each CPU after invalidating the I-cache
 for kernel mappings
In-Reply-To: <20180619165019.GU13984@arm.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
 <1529412495-17525-4-git-send-email-will.deacon@arm.com>
 <20180619135528.4rxgluvroybxgxem@lakrids.cambridge.arm.com>
 <20180619165019.GU13984@arm.com>
Message-ID: <280d8fd6-6767-121f-b432-83013184630b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Will

On 19/06/18 17:50, Will Deacon wrote:
> On Tue, Jun 19, 2018 at 02:55:28PM +0100, Mark Rutland wrote:
>> On Tue, Jun 19, 2018 at 01:48:15PM +0100, Will Deacon wrote:
>>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>>> index 816d03c4c913..4cc41864f277 100644
>>> --- a/arch/arm64/kernel/insn.c
>>> +++ b/arch/arm64/kernel/insn.c
>>> @@ -249,7 +249,6 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>>>  	} else {
>>>  		while (atomic_read(&pp->cpu_count) <= num_online_cpus())
>>>  			cpu_relax();
>>> -		isb();
>>>  	}
>>
>> Something seems amiss here. 
>>
>> We call __apply_alternatives_multi_stop() via stop_machine(), and I
>> thought that ensured that all CPUs had IRQs masked.
>>
>> If so, the IPI from flush_icache_range() will deadlock.
>>
>> If not, we can take IRQs, and execute potentially patched code.
> 
> Yes, I think you're right, and I think this only applies to kprobes (since
> it patches arbitrary instructions and requires the stop_machine()). However,
> I think that highlights another issue, which is that the "nosync" patching
> cases as used by things like jump_labels are still going to want this IPI,
> so actually the fastpath stuff can all be ripped out. ftrace can probably
> be left as-is, since I doubt it's critical that new CPUs immediately see
> dynamic tracepoints.
>
> I'll cook a patch sorting this out and include it in v2.
> 
>> I think there's also an existing problem here. Even if with have IRQs
>> masked, we could take SDEI events (or GICv3 psudeo-NMIs, once we have
>> those). I don't know how we can manage those.
> 
> I guess there are just some places where we can't deal with an SDEI event.
> That said, it's fine as long as the SDEI path is careful about what it runs
> (and SDEI is masked until the worst of the patching is over during boot).

Yup, its setup as late as possible, so cpufeature stuff should be safe.

I think break-pointing code we expect to run in_nmi() is a disaster waiting to
happen. e.g. taking an SDEI-event out of a guest, we run the handler before KVM
does it's guest exit, so if you tread on a breakpoint KVM's el2_sync is going to
bring the machine down.

The SDEI stuff has __kprobes all over it, I probably need to add some more
'notrace'.


I think forbidding code-patch on NMI code-regions is the easiest thing to do.

If this is something we needed to support, we could get stop_machine() to mask
SDEI and GIC psuedo_NMIs as part of its work. We could mask SError and disable
debug exceptions while we're at it.



Thanks,

James
