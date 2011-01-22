From: ccross@google.com (Colin Cross)
Date: Fri, 21 Jan 2011 20:53:18 -0800
Subject: __arm_ioremap creates page table with domain set to kernel
In-Reply-To: <alpine.LFD.2.00.1101212253070.8580@xanadu.home>
References: <AANLkTi=iD_ipD=KBdgB+xT4dP2Yd7UYu1fmpQ4NO5OJx@mail.gmail.com>
	<alpine.LFD.2.00.1101212232000.8580@xanadu.home>
	<AANLkTi=nxMUNBGGVWjn+0JtEPGt3RZa5Y4BmH4=ytSiX@mail.gmail.com>
	<alpine.LFD.2.00.1101212253070.8580@xanadu.home>
Message-ID: <AANLkTikTDknegJFLFYLXW=KZTDgubY3jy-Z1qJ=GEPbO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 8:00 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 21 Jan 2011, Colin Cross wrote:
>
>> On Fri, Jan 21, 2011 at 7:37 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Fri, 21 Jan 2011, Colin Cross wrote:
>> >
>> >> If this is a real problem, I don't see any quick fix. ?The domain bits
>> >> are set in the pmd, so ioremapped memory can not share a pmd with
>> >> regular vmalloc memory, and ioremap_page_range has no way to carry a
>> >> domain to pte_alloc_kernel.
>> >
>> > This has been fixed already. Have a look at:
>> >
>> > |commit 247055aa21ffef1c49dd64710d5e94c2aee19b58
>> > |Author: Catalin Marinas <catalin.marinas@arm.com>
>> > |Date: ? Mon Sep 13 16:03:21 2010 +0100
>> > |
>> > | ? ?ARM: 6384/1: Remove the domain switching on ARMv6k/v7 CPUs
>> > |
>> > |[...]
>>
>> Ah, thanks. ?For the linux-tegra-2.6.36 kernel I worked around the
>> problem by statically mapping all of the IO regions and preventing
>> ioremaps outside of the static mappings or physical memory.
>
> Beware that the ARM ARM also mention that multiple mappings of the same
> physical memory but with different caching attributes is undefined. ?So
> you should not ioremap memory if it is already mapped in the direct
> kernel memory space. ?I think 2.6.36 would produce a warning, but now
> this also returns NULL.

I use memblock_remove on any area of memory that will later be ioremapped.
