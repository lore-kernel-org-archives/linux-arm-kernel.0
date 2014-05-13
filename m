From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 14:52:05 +0200
Subject: [PATCHv2 4/4] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <11503675.BOHdnE4xD3@wuerfel>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <11503675.BOHdnE4xD3@wuerfel>
Message-ID: <20140513145205.1dad280f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 13 May 2014 13:13:39 +0200, Arnd Bergmann wrote:

> Hmm, I think this needs some more explanation about which flags
> you are actually interested in. 
> 
> These are the three common mem types for ioremap:
> 
> #define PROT_PTE_DEVICE         L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
> #define PROT_SECT_DEVICE        PMD_TYPE_SECT|PMD_SECT_AP_WRITE
> 
>         [MT_DEVICE] = {           /* Strongly ordered / ARMv6 shared device */
>                 .prot_pte       = PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
>                                   L_PTE_SHARED,
>                 .prot_pte_s2    = s2_policy(PROT_PTE_S2_DEVICE) |
>                                   s2_policy(L_PTE_S2_MT_DEV_SHARED) |
>                                   L_PTE_SHARED,
>                 .prot_sect      = PROT_SECT_DEVICE | PMD_SECT_S,
>                 .domain         = DOMAIN_IO, 
>         },                      
>         [MT_DEVICE_CACHED] = {    /* ioremap_cached */
>                 .prot_pte       = PROT_PTE_DEVICE | L_PTE_MT_DEV_CACHED,
>                 .prot_sect      = PROT_SECT_DEVICE | PMD_SECT_WB,
>                 .domain         = DOMAIN_IO,
>         },
>         [MT_DEVICE_WC] = {      /* ioremap_wc */
>                 .prot_pte       = PROT_PTE_DEVICE | L_PTE_MT_DEV_WC,
>                 .prot_sect      = PROT_SECT_DEVICE,
>                 .domain         = DOMAIN_IO,
>         },
> 
> and this is the one you enforce here:
> 
>         [MT_MEMORY_RW_SO] = {
>                 .prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
>                                 L_PTE_MT_UNCACHED | L_PTE_XN,
>                 .prot_l1   = PMD_TYPE_TABLE,
>                 .prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
>                                 PMD_SECT_UNCACHED | PMD_SECT_XN,
>                 .domain    = DOMAIN_KERNEL,
>         },
> 
> So you set a different domain, and turn write-combined and cached mappings
> into uncached mappings, and for uncached mappings you remove the "shared"
> flag. Which of these changes is the one you actually need?

I *believe* the important part is the change from L_PTE_MT_DEV_SHARED
to L_PTE_MT_UNCACHED, because:

#define L_PTE_MT_UNCACHED       (_AT(pteval_t, 0x00) << 2)
#define L_PTE_MT_DEV_SHARED     (_AT(pteval_t, 0x04) << 2)

So the former is "Strongly-Ordered" according to the ARM ARM, while the
latter is "Device Shareable".

The only detail I have access to is that the workaround is "Reads
targeting PCIe End Point must be marked Strongly Ordered", so it's
pretty limited in details.

Do you think I should create a different memory type MT_DEVICE_SO, that
remains in the DOMAIN_IO domain, but uses L_PTE_MT_UNCACHED instead of
L_PTE_MT_DEV_SHARED ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
