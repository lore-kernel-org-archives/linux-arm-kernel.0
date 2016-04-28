From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Apr 2016 16:38:49 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428143332.GC12470@localhost>
References: <20160427225827.GC17629@localhost>
 <20160428143332.GC12470@localhost>
Message-ID: <20160428163849.2fb5607b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Apr 2016 09:33:32 -0500, Bjorn Helgaas wrote:
> [+cc linux-pci, manually inserted reply, sorry again]
> 
> Liviu wrote:
> > On Wed, Apr 27, 2016 at 05:58:27PM -0500, Bjorn Helgaas wrote:
> >> Looking at __arm_ioremap_pfn_caller() makes me
> >> suspect that pci_remap_iospace() is not safe on arm.
> 
> > Hmm, not sure how you reached that conclusion. __arm_ioremap_pfn_caller()
> > does call in the end ioremap_page_range() for ARMv7 || ARM_LPAE, which is
> > what pci_remap_iospace() does as well. Beside the possibly different
> > pgprot_t values, what would make it unsafe for arm?
> 
> The different pgprot_t is exactly what I'm worried about.  The callers of
> pci_ioremap_io() probably get the right thing (a pgprot tweaked to deal
> with this Cortex problem), but other callers of ioremap_page_range(),
> pci_remap_iospace() in particular, don't get that tweak:
> 
>   pci_ioremap_io
>     ioremap_page_range(..., __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte))
> 
>   pci_remap_iospace
>     ioremap_page_range(..., pgprot_device(PAGE_KERNEL))
>       ioremap_pud_range(..., pgprot_device(PAGE_KERNEL))
>         ioremap_pmd_range(..., pgprot_device(PAGE_KERNEL))
>           ioremap_pte_range(..., pgprot_device(PAGE_KERNEL))
>             set_pte_at(..., pfn_pte(pfn, pgprot_device(PAGE_KERNEL)))

Indeed. Which is why we should get rid of one of the two interfaces.
Since pci_remap_iospace() is the generic one, I guess that's the one we
should migrate to.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
