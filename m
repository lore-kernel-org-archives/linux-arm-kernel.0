From: msalter@redhat.com (Mark Salter)
Date: Fri, 06 Dec 2013 09:55:54 -0500
Subject: [PATCH 1/3] arm64: add EFI stub
In-Reply-To: <20131205141853.GA974@darko.cambridge.arm.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-2-git-send-email-msalter@redhat.com>
 <20131205141853.GA974@darko.cambridge.arm.com>
Message-ID: <1386341754.1861.188.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-05 at 14:18 +0000, Catalin Marinas wrote:
> Hi Mark,
> 
> On Fri, Nov 29, 2013 at 10:05:10PM +0000, Mark Salter wrote:
> > +#include <linux/linkage.h>
> > +#include <linux/init.h>
> > +
> > +#include <asm/assembler.h>
> > +
> > +#define EFI_LOAD_ERROR 0x8000000000000001
> 
> It's defined already but I see why you can't include efi.h here. Maybe a
> comment.

okay

> 
> > +
> > +       __INIT
> > +
> > +       /*
> > +        * We arrive here from the EFI boot manager with:
> > +        *
> > +        *    * MMU on with identity-mapped RAM.
> > +        *    * Icache and Dcache on
> > +        *
> > +        * We will most likely be running from some place other than where
> > +        * we want to be. The kernel image wants to be placed at TEXT_OFFSET
> > +        * from start of RAM.
> > +        */
> > +ENTRY(efi_stub_entry)
> > +       stp     x29, x30, [sp, #-32]!
> > +
> > +       /*
> > +        * Call efi_entry to do the real work.
> > +        * x0 and x1 are already set up by firmware. Current runtime
> > +        * address of image is calculated and passed via *image_addr.
> > +        *
> > +        * unsigned long efi_entry(void *handle,
> > +        *                         efi_system_table_t *sys_table,
> > +        *                         unsigned long *image_addr) ;
> > +        */
> > +       adrp    x8, _text
> > +        add    x8, x8, #:lo12:_text
> 
> Minor: some wrong whitespace (but I don't trust our incoming mail server
> either, it corrupts patches usually).

I will fix it. (the whitespace, not your mail server)

> 
> > +       add     x2, sp, 16
> > +       str     x8, [x2]
> > +       bl      efi_entry
> > +       cmn     x0, #1
> > +       b.eq    efi_load_fail
> > +
> > +       /*
> > +        * efi_entry() will have relocated the kernel image if necessary
> > +        * and we return here with device tree address in x0 and the kernel
> > +        * entry point stored at *image_addr. Save those values in registers
> > +        * which are preserved by __flush_dcache_all.
> > +        */
> > +       ldr     x1, [sp, #16]
> > +       mov     x20, x0
> > +       mov     x21, x1
> > +
> > +       bl      __flush_dcache_all
> 
> Regarding __flush_dcache_all, I plan to remove it for all cases apart
> from power management with the MMU disabled. With MMU enabled, there is
> no guarantee that this function does the right thing. It's even worse in
> the guest context.

According to booting.txt, the dcache needs to be invalidated. Is there
something existing I can use or do I need to write it?
> 
> > +       /* Turn off Dcache and MMU */
> > +       mrs     x0, sctlr_el1
> > +       bic     x0, x0, #1 << 0 // clear SCTLR.M
> > +       bic     x0, x0, #1 << 2 // clear SCTLR.C
> > +       msr     sctlr_el1, x0
> > +       isb
> 
> I assume an EFI app is running with the MMU enabled (and UP only). Do we
> always run it in EL1? What about EL2 mode (needed by KVM and Xen)?

Good point. It could be non-secure EL2.

> 
> > +
> > +       /* Jump to real entry point */
> > +       mov     x0, x20
> > +       mov     x1, xzr
> > +       mov     x2, xzr
> > +       mov     x3, xzr
> > +       br      x21
> > +
> > +efi_load_fail:
> > +       mov     x0, EFI_LOAD_ERROR
> 
> Needs #EFI_LOAD_ERROR (strange that gas doesn't complain).

Hmm, no complaint but it DTRT.

> > +/*
> > + * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
> > + * start of kernel and may not cross a 2MiB boundary. We set alignment to
> > + * equal max size so we know it won't cross a 2MiB boudary.
> > + */
> > +#define MAX_DTB_SIZE   0x40000
> 
> 2MB is 0x200000 (or I don't understand the comment).

I had a little trouble with it myself. :) The size was left over from
older code which used it directly in an allocation. I'll fix the
comment, drop MAX_DTB_SIZE, and fix DTB_ALIGN to be 2MiB.

> > +
> > +static unsigned long __init get_dram_base(efi_system_table_t *sys_table)
> > +{
> > +       efi_status_t status;
> > +       unsigned long map_size, desc_size;
> > +       unsigned long membase = EFI_ERROR;
> > +       efi_memory_desc_t *memory_map;
> > +       int i;
> > +
> > +       status = efi_get_memory_map(sys_table, &memory_map, &map_size,
> > +                                   &desc_size, NULL, NULL);
> > +       if (status == EFI_SUCCESS) {
> 
> Can you exit earlier here if !EFI_SUCCESS? It reduces the indentation
> level.
> 
Yes.
