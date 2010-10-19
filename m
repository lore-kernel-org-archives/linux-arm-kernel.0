From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Oct 2010 19:12:49 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTikZAt-KWFF_MXxXGruia-=AieStQgird2XWgr6y@mail.gmail.com>
References: <20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimQJLmDZPHtVJLCv9ZQgx_Yjh9=MOwOxMSAz4QX@mail.gmail.com>
	<20101011152516.GF27153@n2100.arm.linux.org.uk>
	<AANLkTikZAt-KWFF_MXxXGruia-=AieStQgird2XWgr6y@mail.gmail.com>
Message-ID: <20101019181249.GA9789@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 01:13:36AM -0700, Colin Cross wrote:
> If memblock_remove is used on the end of memory with this patch,
> mem_init accesses off the end of the array of page structures because
> of the discrepancy between memblock.memory and membank on the number
> of the last pfn.   memblock.memory is used to determine the memory
> zones in arm_bootmem_free, which eventually  is used to create the
> array of page structures, but mem_init iterates over membank and calls
> pfn_to_page on pfns up to bank_pfn_end.
> 
> Converting show_mem and mem_init to use memblock.memory fixes it:

I intentionally did not do this because it won't work.  membank
information is purposely not coalesced together when you have full
sparsemem regions - which may result in

	pfn_to_page(pfn) != pfn_to_page(pfn + 1) - 1

However, memblock information is coalesced, and so will cross these
boundaries.  This means using memblock instead of membank will make
things go pop.
