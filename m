From: pwaechtler@mac.com (Peter =?iso-8859-1?q?W=E4chtler?=)
Date: Thu, 7 Apr 2011 20:26:36 +0200
Subject: howto set some kernel pages to readonly?
Message-ID: <201104072026.37303.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linux ARM developers,

on Linux x86 there is infrastructure to set rodata to, aeh, readonly. ;)

I also want to protect some pages to readonly  as a guard.
So if some kernel code writes to the memory the kernel panics.

I tried the following without success:

And I have to admit that I don't understand all the macros for 
manipulating the page table entries ;(
Any clue what's wrong?


int set_page_ro(unsigned long addr)
{
        pte_t new_pte;
        unsigned long pfn;
        pte_t *pte;
        pgd_t *pgd;
        pmd_t *pmd;
 
        pgd = pgd_offset_k(addr);
        pmd = pmd_offset(pgd, addr);
 
        pfn = __phys_to_pfn(virt_to_phys((void*)addr));
 
        pte = pte_offset_kernel(pmd, addr);
        new_pte = pfn_pte(pfn, __pgprot(pgprot_val(pgprot_kernel) | 
                                                      (__PAGE_READONLY)) );
 
        set_pte_ext(pte, new_pte, 0);
 
        return 0;
}
 

set_page_ro( (unsigned long)pa );
flush_tlb_kernel_page((long)pa);

--
   Peter
