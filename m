From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 May 2014 16:24:13 +0100
Subject: [PATCHv2 4/4] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <20140513145205.1dad280f@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <11503675.BOHdnE4xD3@wuerfel>
 <20140513145205.1dad280f@free-electrons.com>
Message-ID: <20140514152413.GH19866@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 01:52:05PM +0100, Thomas Petazzoni wrote:
> On Tue, 13 May 2014 13:13:39 +0200, Arnd Bergmann wrote:
> > and this is the one you enforce here:
> > 
> >         [MT_MEMORY_RW_SO] = {
> >                 .prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> >                                 L_PTE_MT_UNCACHED | L_PTE_XN,
> >                 .prot_l1   = PMD_TYPE_TABLE,
> >                 .prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
> >                                 PMD_SECT_UNCACHED | PMD_SECT_XN,
> >                 .domain    = DOMAIN_KERNEL,
> >         },
> > 
> > So you set a different domain, and turn write-combined and cached mappings
> > into uncached mappings, and for uncached mappings you remove the "shared"
> > flag. Which of these changes is the one you actually need?
> 
> I *believe* the important part is the change from L_PTE_MT_DEV_SHARED
> to L_PTE_MT_UNCACHED, because:
> 
> #define L_PTE_MT_UNCACHED       (_AT(pteval_t, 0x00) << 2)
> #define L_PTE_MT_DEV_SHARED     (_AT(pteval_t, 0x04) << 2)
> 
> So the former is "Strongly-Ordered" according to the ARM ARM, while the
> latter is "Device Shareable".
> 
> The only detail I have access to is that the workaround is "Reads
> targeting PCIe End Point must be marked Strongly Ordered", so it's
> pretty limited in details.
> 
> Do you think I should create a different memory type MT_DEVICE_SO, that
> remains in the DOMAIN_IO domain, but uses L_PTE_MT_UNCACHED instead of
> L_PTE_MT_DEV_SHARED ?

I don't think it's worth, we no longer use domains on ARMv7. You could
even change the domain to IO here (it seems to be used only by omap for
a workaround) or collapse both into MT_UNCACHED which seems to have
similar needs (and used by iop3xx only).

-- 
Catalin
