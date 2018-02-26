From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Mon, 26 Feb 2018 13:09:26 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDAxLzExXSBJbml0aWFsaXplIHRoZSBtYXBwaW5nIG9m?=
 =?gb2312?Q?_KASan_shadow_memory?=
In-Reply-To: <20171019120137.GT20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <31b16c9d-48c7-bc0a-51d1-cc6cf892329b@gmail.com>
 <20171019120137.GT20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0072FE7@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 19, 2017 at 19:09, Russell King - ARM Linux [mailto:linux at armlinux.org.uk] wrote:
>On Thu, Oct 12, 2017 at 02:42:49AM +0300, Dmitry Osipenko wrote:
>> On 11.10.2017 11:22, Abbott Liu wrote:
>> > +void __init kasan_map_early_shadow(pgd_t *pgdp)
>> > +{
>> > +	int i;
>> > +	unsigned long start = KASAN_SHADOW_START;
>> > +	unsigned long end = KASAN_SHADOW_END;
>> > +	unsigned long addr;
>> > +	unsigned long next;
>> > +	pgd_t *pgd;
>> > +
>> > +	for (i = 0; i < PTRS_PER_PTE; i++)
>> > +		set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
>> > +			&kasan_zero_pte[i], pfn_pte(
>> > +				virt_to_pfn(kasan_zero_page),
>> > +				__pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN)));
>> 
>> Shouldn't all __pgprot's contain L_PTE_MT_WRITETHROUGH ?
>
>One of the architecture restrictions is that the cache attributes of
>all aliases should match (but there is a specific workaround that
>permits this, provided that the dis-similar mappings aren't accessed
>without certain intervening instructions.)
>
>Why should it be L_PTE_MT_WRITETHROUGH, and not the same cache
>attributes as the lowmem mapping?
>

Here is mapping the kasan shadow which is used at the early stage of kernel start(from start
of start_kernel to paging_init). At this stage we only read the kasan shadows, never write the
kasan shadows which is initialized to be zero. 

We will map the kasan shadows again with flags PAGE_KERNEL:
pte_t * __meminit kasan_pte_populate(pmd_t *pmd, unsigned long addr, int node)
{
	pte_t *pte = pte_offset_kernel(pmd, addr);
	if (pte_none(*pte)) {
		pte_t entry;
		void *p = kasan_alloc_block(PAGE_SIZE, node);
 		if (!p)
			return NULL;
		entry = pfn_pte(virt_to_pfn(p), __pgprot(pgprot_val(PAGE_KERNEL)));
			set_pte_at(&init_mm, addr, pte, entry);
	}
	return pte;
}
