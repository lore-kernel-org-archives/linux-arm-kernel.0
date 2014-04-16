From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 11:47:40 -0400 (EDT)
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140416152946.GA13564@redhat.com>
References: <20140416150646.GB11039@redhat.com>
 <20140416.111028.831710940640195974.davem@davemloft.net>
 <20140416152946.GA13564@redhat.com>
Message-ID: <20140416.114740.1805744923904673839.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 16 Apr 2014 17:29:46 +0200

> On 04/16, David Miller wrote:
>>
>> From: Oleg Nesterov <oleg@redhat.com>
>> Date: Wed, 16 Apr 2014 17:06:46 +0200
>>
>> > Off-topic, I am just curious... can't someone explain why flush_pfn_alias()
>> > or flush_icache_alias() can't race with itself ? I have no idea what they do,
>> > but what if another thread calls the same function with the same CACHE_COLOUR()
>> > right after set_pte_ext?
>>
>> PTE modifications are supposed to run with the page table lock held.
> 
> OK, but __access_remote_vm() doesn't take ptl?
> 
> And on arm copy_to_user_page()->flush_ptrace_access()->flush_pfn_alias()
> does this.

Well, for one thing, PTE's can't gain permissions except under mmap_sem
which __access_remote_vm() does hold.

But I see what you're saying, flush_pfn_alias() is doing something
different.  It's not making user mappings, but kernel ones in order
to implement the cache flush.

On sparc64 we handle this situation by hand-loading the mappings into
the TLB, doing the operation using the mappings, then flushing it out
of the TLB, all with interrupts disabled.

Furthermore, in ARMs case, the code explicitly states that these
mappings are not used on SMP.  See the comment above the FLUSH_ALIAS_START
definition in arch/arm/mm/mm.h
