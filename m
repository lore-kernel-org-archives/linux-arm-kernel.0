From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 23 Jan 2011 18:34:24 +0200
Subject: HIGHMEM is broken when working in SMP V6 mode
In-Reply-To: <20110123145639.GB30094@n2100.arm.linux.org.uk>
References: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
	<20110123145639.GB30094@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=HtLjnOLGVVqWvqToiXdQAm_+cDdZf51M+ABV4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 4:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 23, 2011 at 04:38:01PM +0200, saeed bishara wrote:
>> Hi,
>> I've port 2.6.35 to SMP system that runs in V6 mode, this system
>> doesn't support TLB operations broadcasting by hw, so it uses IPI
>> messages for that. ?when enabling DEBUG_LOCKDEP, I got the following
>> error message while booting the system from NFS:
>
> You've bypassed this check:
>
> ? ? ? ? ? ? ? ?if (is_smp() && tlb_ops_need_broadcast()) {
> ? ? ? ? ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? ? ? ? ? * kmap_high needs to occasionally flush TLB entries,
> ? ? ? ? ? ? ? ? ? ? ? ? * however, if the TLB entries need to be broadcast
> ? ? ? ? ? ? ? ? ? ? ? ? * we may deadlock:
> ? ? ? ? ? ? ? ? ? ? ? ? * ?kmap_high(irqs off)->flush_all_zero_pkmaps->
> ? ? ? ? ? ? ? ? ? ? ? ? * ?flush_tlb_kernel_range->smp_call_function_many
> ? ? ? ? ? ? ? ? ? ? ? ? * ? (must not be called with irqs off)
> ? ? ? ? ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ? ? ? ? ?reason = "without hardware TLB ops broadcasting";
> ? ? ? ? ? ? ? ?}
>
> so you lose. ?There's reasons why such checks are put in. ?We can not
> support SMP and highmem on systems which do not have TLB broadcasting.
> That's not because the code doesn't support it, it's because there are
> deadlocks which will occur.
thanks, I missed that
>
> The fact is that it is unsafe to send IPIs with IRQs disabled, which
> means you can't IPI a TLB operation and wait for it to complete with IRQs
> disabled.
as I understand it, the lock_kmap() started to disable IRQs in order
to support the vivt and vipt caches, but in SMP (at least in my case),
the caches are PIPT, so I think I can do the following:
1. undef  the  ARCH_NEEDS_KMAP_HIGH_GET
2. use page_address instead of kmap_high_get()
do you think it will work?
saeed

>
> The kmap code sets up and tears down mappings with IRQs disabled because
> of the need to work with the DMA API. ?This means that it when it wants
> to do a TLB operation (to flush out old mappings) its calling context is
> incompatible with what's required to broadcast that operation in
> software.
>
> There is no solution to this. ?SMP without hardware TLB broadcast is
> incompatible with the requirements of highmem.
>
