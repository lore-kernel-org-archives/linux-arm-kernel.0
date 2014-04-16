From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 16 Apr 2014 11:33:15 -0700
Subject: kmalloc and uncached memory
In-Reply-To: <CAF1ivSaAQ_8byv+a9NQebtL4kBYFEPOTJHn-JA-bYY=wLFpv2Q@mail.gmail.com>
References: <CAF1ivSaAQ_8byv+a9NQebtL4kBYFEPOTJHn-JA-bYY=wLFpv2Q@mail.gmail.com>
Message-ID: <534ECCEB.6090007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2014 11:11 AM, Lin Ming wrote:
> Hi Peter,
> 
> I have a performance problem(on ARM board) that cpu is very bus at
> cache invalidation.
> So I'm trying to alloc an uncached memory to eliminate cache invalidation.
> 
> But I also have problem with dma_alloc_coherent().
> If I don't use dma_alloc_coherent(), is it OK to use below code to
> alloc uncached memory?
> 
> struct page *page;
> pgd_t *pgd;
> pud_t *pud;
> pmd_t *pmd;
> pte_t *pte;
> void *cpu_addr;
> dma_addr_t dma_addr;
> unsigned int vaddr;
> 
> cpu_addr = kmalloc(PAGE_SIZE, GFP_KERNEL);
> dma_addr = pci_map_single(NULL, cpu_addr, PAGE_SIZE, (int)DMA_FROM_DEVICE);
> vaddr = (unsigned int)uncached->cpu_addr;
> pgd = pgd_offset_k(vaddr);
> pud = pud_offset(pgd, vaddr);
> pmd = pmd_offset(pud, vaddr);
> pte = pte_offset_kernel(pmd, vaddr);
> page = virt_to_page(vaddr);
> set_pte_ext(pte, mk_pte(page,  pgprot_dmacoherent(pgprot_kernel)), 0);
> 
> /* This kmalloc memory won't be freed  */
> 

No, that will not work. lowmem pages are mapped with 1MB sections underneath
which cannot be (easily) changed at runtime. You really want to be using
dma_alloc_coherent here.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
