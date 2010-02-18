From: hli@broadcom.com (Henry Li)
Date: Wed, 17 Feb 2010 16:33:00 -0800
Subject: Alignment Requirement for MT_MEMORY type
Message-ID: <B125D8217ABC4B43826503DE00A2D44910F4639A8D@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Can someone tell me why there is a requirement for the virtual and physical
addresses and size using MT_MEMORY memtype (where prot_l1=0) to be aligned
to section boundary (1MB) in linux-2.6.32/arch/arm/mm/mmu.c/create_mapping
during IO table init?


Following is the relevent code snippet:

addr = md->virtual & PAGE_MASK;
phys = (unsigned long)__pfn_to_phys(md->pfn);
length = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));

if (type->prot_l1 == 0 && ((addr | phys | length) & ~SECTION_MASK)) {
	printk(KERN_WARNING "BUG: map for 0x%08lx at 0x%08lx can not "
	       "be mapped using pages, ignoring.\n",
	       __pfn_to_phys(md->pfn), addr);
	return;
}


Thanks,

- Henry
