From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Nov 2014 16:38:26 +0000
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <1415845188.15847.79.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
 <20141024102838.GB24265@leverpostej>
 <1415845188.15847.79.camel@smoke>
Message-ID: <20141117163826.GD25416@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 02:19:48AM +0000, Geoff Levand wrote:
> Hi Mark,

Hi Geoff,

> On Fri, 2014-10-24 at 11:28 +0100, Mark Rutland wrote:
> > > +++ b/arch/arm64/Kconfig
> > > @@ -313,6 +313,15 @@ config ARCH_HAS_CACHE_LINE_SIZE
> > >
> > >  source "mm/Kconfig"
> > >
> > > +config KEXEC
> > > +       depends on (!SMP || PM_SLEEP_SMP)
> > 
> > In its current state this also depends on !KVM && !EFI (technically you
> > could detect those cases at runtime, but I don't see that in this
> > series).
> 
> A kernel built with CONFIG_EFI is OK if run on a non-EFI system or
> without using a system's EFI support.  I added a patch that adds
> runtime checks in the kexec_load syscall path to print a message
> and return failure for situations where KVM or EFI won't work.
> 
> > > +/**
> > > + * machine_kexec_prepare - Prepare for a kexec reboot.
> > > + *
> > > + * Called from the core kexec code when a kernel image is loaded.
> > > + */
> > > +
> > > +int machine_kexec_prepare(struct kimage *image)
> > > +{
> > > +       const struct kexec_segment *dtb_seg = kexec_find_dtb_seg(image);
> > > +
> > > +       if (!dtb_seg)
> > > +               pr_warn("%s: No device tree segment found.\n", __func__);
> > > +
> > > +       arm64_kexec_dtb_addr = dtb_seg ? dtb_seg->mem : 0;
> > > +       arm64_kexec_kimage_start = image->start;
> > > +
> > > +       return 0;
> > > +}
> > 
> > I thought all of the DTB handling was moving to purgatory?
> 
> Non-purgatory booting is needed for kexec-lite.  We can do
> this simple check here which optionally sets x0 to the dtb
> address to support that.  The other solution is to have a
> trampoline in kexec-lite that sets x0 (basically an absolute
> minimal purgatory), but I think to do it here is nicer, and
> is also the same way that the arm arch code does it.
> 
> Maybe removing this pr_warn message and just relying on the
> kexec_image_info() output would be better.

I mentioned previously that I don't think the "kexec-lite" approach is a
good one, especially if we're going to have userspace purgatory code
anyway. It embeds a policy w.r.t. the segment handling within the
kernel, on the assumption of a specific use-case for what is a more
general mechanism.

Unfortunately secureboot with kexec_file_load will require a kernelspace
purgatory and likely special DT handling, but it's already a far more
limited interface.

> > > +/**
> > > + * kexec_list_flush - Helper to flush the kimage list to PoC.
> > > + */
> > > +
> > > +static void kexec_list_flush(unsigned long kimage_head)
> > > +{
> > > +       void *dest;
> > > +       unsigned long *entry;
> > > +
> > > +       for (entry = &kimage_head, dest = NULL; ; entry++) {
> > > +               unsigned int flag = *entry &
> > > +                       (IND_DESTINATION | IND_INDIRECTION | IND_DONE |
> > > +                       IND_SOURCE);
> > > +               void *addr = phys_to_virt(*entry & PAGE_MASK);
> > > +
> > > +               switch (flag) {
> > > +               case IND_INDIRECTION:
> > > +                       entry = (unsigned long *)addr - 1;
> > > +                       __flush_dcache_area(addr, PAGE_SIZE);
> > > +                       break;
> > > +               case IND_DESTINATION:
> > > +                       dest = addr;
> > > +                       break;
> > > +               case IND_SOURCE:
> > > +                       __flush_dcache_area(addr, PAGE_SIZE);
> > > +                       dest += PAGE_SIZE;
> > > +                       break;
> > > +               case IND_DONE:
> > > +                       return;
> > > +               default:
> > > +                       break;
> > 
> > Can an image ever have no flags? Given the presence of IND_NONE I'd
> > assume not, so this looks like a candidate for a BUG().
> 
> Sure, I guess things will blow up before it ever gets here though.

I would hope so. If we trigger the BUG() we know otherwise.

> 
> > 
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +/**
> > > + * machine_kexec - Do the kexec reboot.
> > > + *
> > > + * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
> > > + */
> > > +
> > > +void machine_kexec(struct kimage *image)
> > > +{
> > > +       phys_addr_t reboot_code_buffer_phys;
> > > +       void *reboot_code_buffer;
> > > +
> > > +       BUG_ON(num_online_cpus() > 1);
> > > +
> > > +       arm64_kexec_kimage_head = image->head;
> > > +
> > > +       reboot_code_buffer_phys = page_to_phys(image->control_code_page);
> > > +       reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> > > +
> > > +       /*
> > > +        * Copy relocate_new_kernel to the reboot_code_buffer for use
> > > +        * after the kernel is shut down.
> > > +        */
> > > +
> > > +       memcpy(reboot_code_buffer, relocate_new_kernel,
> > > +               relocate_new_kernel_size);
> > 
> > Can we get rid of the line gaps between comments and the single function
> > calls they apply to, please? I realise it's a minor thing, but this
> > looks rather inconsistent with the rest of arch/arm64/.
> 
> checkpatch doesn't seem to mind, but sure, I can do that.

Cheers.

> > > +
> > > +       /* Flush the reboot_code_buffer in preparation for its execution. */
> > > +
> > > +       __flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
> > 
> > That code should already be at the PoC per the boot protocol (the entire
> > kernel image should have been clean to the PoC at boot, so the
> > instructions forming relocate_new_kernel are globally visible).
> > 
> > From the looks of it you only need to flush the variables at the very
> > end.
> 
> We copy the relocate_new_kernel routine to reboot_code_buffer, which is
> a buffer allocated by the kexec core with alloc_pages().  That copy of
> relocate_new_kernel is what we are flushing here.
> 
> I believe we need to flush that buffer out to PoC so we can execute
> the code it contains after cpu_soft_restart().

Apologies. I'd evidently confused myself here regarding what was being
flushed.

> 
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/relocate_kernel.S
> > > @@ -0,0 +1,184 @@
> > > +/*
> > > + * kexec for arm64
> > > + *
> > > + * Copyright (C) Linaro.
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#include <asm/assembler.h>
> > > +#include <asm/kexec.h>
> > > +#include <asm/memory.h>
> > > +#include <asm/page.h>
> > > +#include <asm/proc-macros.S>
> > > +
> > > +/* The list entry flags. */
> > > +
> > > +#define IND_DESTINATION_BIT 0
> > > +#define IND_INDIRECTION_BIT 1
> > > +#define IND_DONE_BIT        2
> > > +#define IND_SOURCE_BIT      3
> > 
> > As previously, I think these need to be moved into a common header, and
> > defined in terms of the existing IND_* macros (or vice-versa). I believe
> > you had a patch doing so; what's the status of that?
> 
> Still working to get it merged:
> 
>   https://lkml.org/lkml/2014/11/12/675

Ok. Let's hope that goes through soon.

> 
> > > +/*
> > > + * relocate_new_kernel - Put a 2nd stage kernel image in place and boot it.
> > > + *
> > > + * The memory that the old kernel occupies may be overwritten when coping the
> > > + * new image to its final location.  To assure that the relocate_new_kernel
> > > + * routine which does that copy is not overwritten all code and data needed
> > > + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> > > + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> > > + * relocate_new_kernel to the kexec control_code_page, a special page which
> > > + * has been set up to be preserved during the copy operation.
> > > + */
> > > +
> > > +.globl relocate_new_kernel
> > > +relocate_new_kernel:
> 
> ...
> 
> > > +
> > > +       /* start_new_image */
> > > +
> > > +       ldr     x4, arm64_kexec_kimage_start
> > > +       ldr     x0, arm64_kexec_dtb_addr
> > > +       mov     x1, xzr
> > > +       mov     x2, xzr
> > > +       mov     x3, xzr
> > > +       br      x4
> > 
> > This last part should be in userspace-provided purgatory. If you have
> > purgatory code which does this then we should be able to rely on that,
> > and we don't have to try to maintain this DTB handling in kernelspace
> > (which I suspect may become painful as the boot protocol evolves).
> 
> I think the putting the dtb address in x0 is already fixed.  There are
> users with firmware that does this and any change to the boot protocol
> will have to work with it.

Sure, but that is the _Linux_ boot protocol, and the Kconfig description
of kexec stats "you can start any kernel with it, not just Linux". Why
should we embed Linux-specific details into a supposedly generic
mechanism?

We may also extend the boot protocol, and I would rather not have to
manage the complexity of each possible extension within the kernel,
especially given that the only context we can pass in kexec is segments.

> As I mentioned above, we need a solution for non-purgatory re-boot and I
> think this is the best way.

Why do we need a solution for "non-purgatory re-boot"? As far as I can
see this is a non-problem.

Thanks,
Mark.
