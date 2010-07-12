From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 13:42:25 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100712122816.GA1889@barrios-desktop>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<20100712104541.GA6577@n2100.arm.linux.org.uk>
	<20100712122816.GA1889@barrios-desktop>
Message-ID: <20100712124225.GB6577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 09:28:16PM +0900, Minchan Kim wrote:
> It just checks that there is a section and section_mem_map has SECTION_HAS_MEM_MAP.
> The first section in above case has just 80M memory but section has 256M. 
> So, 0x25000000 - 28000000 is the hole. If you pass pfn whihc is 0x2500000,
> let's see pfn_valid.

That's not a hole as such.  It's an incompletely filled section, which is
precisely what sparsemem is all about.

> 1. We pass pfn_to_section_nr check 
> 2. Both __nr_to_section and valid_section is vaild.
> 
> static inline int pfn_valid(unsigned long pfn) 
> {
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
>         return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> }
> 
> 
> What prevent above hole's case?

That looks too loose to be useful - that means invalid page table entries
can pass the pfn_valid() test when they should actually fail, and I'd
imagine there will be many more such problems like that.

> I think at least pfn_valid in sparsemem need bank range check like pfn_valid of ARM 
> in FLATMEM.

I agree - pfn_valid() on sparsemem needs to be tightened.
