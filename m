From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 21 Apr 2017 14:30:32 +0000
Subject: [PATCH 1/3] arm64: extend ioremap for cacheable non-shareable
 memory
In-Reply-To: <20170421091156.GA6406@leverpostej>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
 <1492716858-24509-2-git-send-email-Haiying.Wang@nxp.com>
 <20170421091156.GA6406@leverpostej>
Message-ID: <7C745CC3-3E91-4A8A-8DAB-0FA4E50DF08B@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These transactions are done in HW via an ACP port which if I remember correctly only supports non coherent transactions.  I will need to go back and check through email conversations I had with Catalin last year when debugging an issue using this mechanism (cacheable/nonshareable mapping) but it was deemed to be valid ARM setup architecturally for this type of device.

Just for some background the page the QBMan device presented to a core is only accessed by a single core (i.e. SW portals are core affine). In this model each page is always mapped as non shareable and another core will never access it. The important factor is that it is not DDR memory being mapped non sharable, but a non-coherent master on the bus in our SoC.  I agree regular RAM shouldn?t be mapped this way but we cannot map this device as cacheable/shareable (coherent) on CCN-504 devices without getting exceptions from the CCN-504. Treating it as non cacheable is functionally OK but performance suffers in that case.

Your help will be appreciated as we want to get support for these devices with good performance in upstream kernels.

Roy

On 2017-04-21, 5:11 AM, "Mark Rutland" <mark.rutland@arm.com> wrote:

    Hi,
    
    I notice you missed Catalin and Will from Cc. In future, please ensure
    that you Cc them when altering arm64 arch code.
    
    On Thu, Apr 20, 2017 at 03:34:16PM -0400, Haiying Wang wrote:
    > NXP arm64 based SoC needs to allocate cacheable and
    > non-shareable memory for the software portals of
    > Queue manager, so we extend the arm64 ioremap support
    > for this memory attribute.
    
    NAK to this patch.
    
    It is not possible to safely use Non-Shareable attributes in Linux page
    tables, given that these page tables are shared by all PEs (i.e. CPUs).
    
    My understanding is that if several PEs map a region as Non-Shareable,
    the usual background behaviour of the PEs (e.g. speculation,
    prefetching, natural eviction) mean that uniprocessor semantics are not
    guaranteed (i.e. a read following a write may see stale data).
    
    For example, in a system like:
    
        +------+  +------+
        | PE-a |  | PE-b |
        +------+  +------+
        | L1-a |  | L1-b |
        +------+  +------+
           ||        ||
        +----------------+
        |  Shared cache  |
        +----------------+
                ||
        +----------------+
        |     Memory     |
        +----------------+
    
    ... you could have a sequence like:
    
    1) PE-a allocates a line into L1-a for address X in preparation for a
       store.
    
    2) PE-b allocates a line into L1-b for the same address X as a result of
       speculation.
    
    3) PE-a makes a store to the line in L1-a. Since address X is mapped as
       Non-shareable, no snoops are performed to keep other copies of the
       line in sync.
    
    4) As a result of explicit maintenance or as a natural eviction, L1-a
       evicts its line into shared cache. The shared cache subsequently
       evicts this to memory.
    
    5) L1-b evicts its line to shared cache as a natural eviction.
    
    6) L1-a fetches the line from shared cache in response to a load by
       PE-a, returning stale data (i.e. the store is lost).
    
    No amount of cache maintenance can avoid this. In general, Non-Shareable
    mappings are a bad idea.
    
    Thanks,
    Mark.
    
    > Signed-off-by: Haiying Wang <Haiying.Wang@nxp.com>
    > ---
    >  arch/arm64/include/asm/io.h           | 1 +
    >  arch/arm64/include/asm/pgtable-prot.h | 1 +
    >  2 files changed, 2 insertions(+)
    > 
    > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
    > index 0c00c87..b6f03e7 100644
    > --- a/arch/arm64/include/asm/io.h
    > +++ b/arch/arm64/include/asm/io.h
    > @@ -170,6 +170,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
    >  #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
    >  #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
    >  #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
    > +#define ioremap_cache_ns(addr, size)	__ioremap((addr), (size), __pgprot(PROT_NORMAL_NS))
    >  #define iounmap				__iounmap
    >  
    >  /*
    > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
    > index 2142c77..7fc7910 100644
    > --- a/arch/arm64/include/asm/pgtable-prot.h
    > +++ b/arch/arm64/include/asm/pgtable-prot.h
    > @@ -42,6 +42,7 @@
    >  #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
    >  #define PROT_NORMAL_WT		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
    >  #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
    > +#define PROT_NORMAL_NS		(PTE_TYPE_PAGE | PTE_AF | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
    >  
    >  #define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
    >  #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
    > -- 
    > 2.7.4
    > 
    > 
    > _______________________________________________
    > linux-arm-kernel mailing list
    > linux-arm-kernel at lists.infradead.org
    > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
    
