From: slash.tmp@free.fr (Mason)
Date: Fri, 20 Mar 2015 22:40:09 +0100
Subject: ERRATA work-arounds in the kernel
In-Reply-To: <20150320172041.GI3421@e104818-lin.cambridge.arm.com>
References: <550C4B12.1030608@free.fr>
 <20150320172041.GI3421@e104818-lin.cambridge.arm.com>
Message-ID: <550C93B9.7010203@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/2015 18:20, Catalin Marinas wrote:
> On Fri, Mar 20, 2015 at 05:30:10PM +0100, Mason wrote:
>> I also looked at ARM's "Errata Summary Table" for the Cortex A9. There are
>> roughly 90 errata documented there. (This document is 2 years old.)
>>
>> I assume that some (most?) of these do not apply to Linux, but it seems
>> likely that some do?
>>
>> I'm wondering why there are not more work-arounds available in Kconfig?
> 
> There are a few reasons:
> 
> - erratum cannot be triggered in Linux
> - erratum cannot be worked around in Linux (e.g. it requires some
>   undocumented control bits to be set by firmware or even hw workaround
>   like the system errata)
> - cat A erratum with no feasible workaround (and partners usually take
>   an ECO fix)

What's an ECO fix?

> - erratum does not affect any CPU revision in production (not all rxpy
>   revisions are in the field; I would include here early CPU revisions
>   that were licensed as development chips but not widely used)
> - we simply missed them. So if you think there is any that needs to be
>   upstreamed, let us know or submit a patch
> 
>> I'm wondering if it is possible to trigger some of these with a "normal"
>> work-load on a "normal" kernel? Has anyone (perhaps ARM employees) looked
>> at that? (I suppose they have.)
> 
> Define "normal". It's really hard to quantify as the workloads can vary
> widely between different use cases (e.g. mobile vs server).

Well, the quotes around "normal" were a tongue-in-cheek cop-out
recognizing that defining "norm" here is tricky business ;-)

That being said, there are errata (speaking generally, not just
about ARM) that only trigger in the lab (or in simulation) and
there are errata that fire more readily (more hand-waving, sorry).

And #782772 looked like the latter to me (but I would defer to
your experience).

>> For example, errata #782772
>> "Speculative execution of a Load-Exclusive or Store-Exclusive instruction
>> after a write to Strongly Ordered memory might deadlock the processor."
>> (The recommended work-around is a strategically-placed DMB.)
>>
>> Since ldrex is used in low-level code, it seems possible to hit that one?
>> Or perhaps Linux does not support "Strongly Ordered" memory regions?
> 
> It support SO memory and it's used in some cases.

Therefore, errata 782772 could trigger on a "typical" system,
right?

Looking more closely at mmu.c

static struct mem_type mem_types[] = {
	[MT_DEVICE] = {		  /* Strongly ordered / ARMv6 shared device */
		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
				  L_PTE_SHARED,
		.prot_pte_s2	= s2_policy(PROT_PTE_S2_DEVICE) |
				  s2_policy(L_PTE_S2_MT_DEV_SHARED) |
				  L_PTE_SHARED,
		.prot_l1	= PMD_TYPE_TABLE,
		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
		.domain		= DOMAIN_IO,
	},


Perhaps, I'll come back to the list of errata once I've taken
care of more trivial matters. (And once I have a better grasp
of Linux internals.)

Regards.
