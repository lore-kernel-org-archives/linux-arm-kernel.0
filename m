From: geoff@infradead.org (Geoff Levand)
Date: Tue, 30 Sep 2014 12:54:37 -0700
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20140930181840.GA24153@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
Message-ID: <1412106877.6630.45.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, 2014-09-30 at 14:18 -0400, Vivek Goyal wrote:
> On Thu, Sep 25, 2014 at 12:23:27AM +0000, Geoff Levand wrote:
> 
> [..]
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > new file mode 100644
> > index 0000000..22d185c
> > --- /dev/null
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -0,0 +1,183 @@
> > +/*
> > + * kexec for arm64
> > + *
> > + * Copyright (C) Linaro.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kexec.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/system_misc.h>
> > +
> > +/* Global variables for the relocate_kernel routine. */
> > +
> > +extern const unsigned char relocate_new_kernel[];
> > +extern const unsigned long relocate_new_kernel_size;
> > +extern unsigned long kexec_dtb_addr;
> > +extern unsigned long kexec_kimage_head;
> > +extern unsigned long kexec_kimage_start;
> > +
> > +/**
> > + * kexec_list_walk - Helper to walk the kimage page list.
> > + */
> > +
> > +static void kexec_list_walk(void *ctx, unsigned long kimage_head,
> > +	void (*cb)(void *ctx, unsigned int flag, void *addr, void *dest))
> > +{
> > +	void *dest;
> > +	unsigned long *entry;
> 
> Hi Geoff,
> 
> I see only one user of this function, kexec_list_flush_cb(). So why
> not directly embed needed logic in kexec_list_flush_cb() instead of
> implementing a generic function. It would be simpler as you seem to
> be flushing dcache only for SOURCE and IND pages and rest you 
> can simply ignore.

I have an additional debugging patch that uses this to dump the list.
I can move this routine into that patch and put in a simpler version
here.

> > +
> > +	for (entry = &kimage_head, dest = NULL; ; entry++) {
> > +		unsigned int flag = *entry & 
> > +			(IND_DESTINATION | IND_INDIRECTION | IND_DONE |
> > +			IND_SOURCE);
> > +		void *addr = phys_to_virt(*entry & PAGE_MASK);
> > +
> > +		switch (flag) {
> > +		case IND_INDIRECTION:
> > +			entry = (unsigned long *)addr - 1;
> > +			cb(ctx, flag, addr, NULL);
> > +			break;
> > +		case IND_DESTINATION:
> > +			dest = addr;
> > +			cb(ctx, flag, addr, NULL);
> > +			break;
> > +		case IND_SOURCE:
> > +			cb(ctx, flag, addr, dest);
> > +			dest += PAGE_SIZE;
> > +			break;
> > +		case IND_DONE:
> > +			cb(ctx, flag , NULL, NULL);
> > +			return;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +/**
> > + * kexec_is_dtb - Helper routine to check the device tree header signature.
> > + */
> > +
> > +static bool kexec_is_dtb(const void *dtb)
> > +{
> > +	__be32 magic;
> > +
> > +	return get_user(magic, (__be32 *)dtb) ? false :
> > +		(be32_to_cpu(magic) == OF_DT_HEADER);
> > +}
> > +
> > +/**
> > + * kexec_find_dtb_seg - Helper routine to find the dtb segment.
> > + */
> > +
> > +static const struct kexec_segment *kexec_find_dtb_seg(
> > +	const struct kimage *image)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < image->nr_segments; i++) {
> > +		if (kexec_is_dtb(image->segment[i].buf))
> > +			return &image->segment[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> So this implementation makes passing dtb mandatory. So it will not work
> with ACPI?

I have not yet considered ACPI.  It will most likely need to have
something done differently.  Secure boot will also need something
different, and I expect it will use your new kexec_file_load().

> Where is dtb present? How is it passed to first kernel? Can it still
> be around in memory and second kernel can access it?

The user space program (kexec-tools, etc.) passes a dtb.  That dtb
could be a copy of the currently one, or a new one specified by
the user.

> I mean in ACPI world on x86, all the ACPI info is still present and second
> kernel can access it without it being explicitly to second kernel in
> memory. Can something similar happen for dtb?

This implementation leaves the preparation of the 2nd stage dtb to
the user space program, as it can prepare that dtb with the proper
kernel command line property, initrd properties etc.

> [..]
> > +/**
> > + * kexec_list_flush_cb - Callback to flush the kimage list to PoC.
> > + */
> > +
> > +static void kexec_list_flush_cb(void *ctx , unsigned int flag,
> > +	void *addr, void *dest)
> 			  ^^^
> 
> Nobody seems to be making use of dest. So why introduce it?

As mentioned, I used this for dumping the list, and that callback
used dest.

> > +{
> > +	switch (flag) {
> > +	case IND_INDIRECTION:
> > +	case IND_SOURCE:
> > +		__flush_dcache_area(addr, PAGE_SIZE);
> > +		break;
> 
> So what does __flush_dcache_area() do? Flush data caches. IIUC, addr
> is virtual address at this point of time. While copying pages and
> walking through the list, I am assuming you have switched off page
> tables and you are in some kind of 1:1 physical mode. So how did
> flushing data caches related to a virtual address help. I guess we
> are not even accessing that virtual address now.

__flush_dcache_area(), and the underling aarch64 civac instruction
operate on virtual addresses.  Here we are still running with the
MMU on and the identity mapping has not yet been enabled.  This is
the sequence:

  flush dcache -> turn off MMU, dcache -> access memory (PoC) directly 

> [..]
> > --- /dev/null
> > +++ b/arch/arm64/kernel/relocate_kernel.S
> > @@ -0,0 +1,183 @@
> > +/*
> > + * kexec for arm64
> > + *
> > + * Copyright (C) Linaro.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <asm/assembler.h>
> > +#include <asm/kexec.h>
> > +#include <asm/memory.h>
> > +#include <asm/page.h>
> > +#include <asm/proc-macros.S>
> > +
> > +/* The list entry flags. */
> > +
> > +#define IND_DESTINATION_BIT 0
> > +#define IND_INDIRECTION_BIT 1
> > +#define IND_DONE_BIT        2
> > +#define IND_SOURCE_BIT      3
> 
> I thought you had some patches to move these into generic header file. You
> got rid of those patches?

I will have another patch to remove these when the kexec patches get
merged, or will just remove these if my kexec patches show up in
Catalin's arm64 tree.

> > +
> > +/*
> > + * relocate_new_kernel - Put the 2nd stage kernel image in place and boot it.
> > + *
> > + * The memory that the old kernel occupies may be overwritten when coping the
> > + * new kernel to its final location.  To assure that the relocate_new_kernel
> > + * routine which does that copy is not overwritten all code and data needed
> > + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> > + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> > + * relocate_new_kernel to the kexec control_code_page, a special page which
> > + * has been set up to be preserved during the kernel copy operation.
> > + */
> > +
> > +.globl relocate_new_kernel
> > +relocate_new_kernel:
> > +
> > +	/* Setup the list loop variables. */
> > +
> > +	ldr	x18, kexec_kimage_head		/* x18 = list entry */
> > +	dcache_line_size x17, x0		/* x17 = dcache line size */
> > +	mov	x16, xzr			/* x16 = segment start */
> > +	mov	x15, xzr			/* x15 = entry ptr */
> > +	mov	x14, xzr			/* x14 = copy dest */
> > +
> > +	/* Check if the new kernel needs relocation. */
> 
> What's "relocation" in this  context. I guess you are checking if new
> kernel needs to be moved to destination location or not.

Yes, relocate means scatter-gather 'copy' here.

> [..]
> > +/*
> > + * kexec_dtb_addr - Physical address of the new kernel's device tree.
> > + */
> > +
> > +.globl kexec_dtb_addr
> > +kexec_dtb_addr:
> > +	.quad	0x0
> 
> As these gloabls are very arm64 specific, will it make sense to prefix
> arm64_ before these. arm64_kexec_dtb_addr. Or arch_kexec_dtb_addr.

I could put an arm64_ prefix on, but this file and these variables are
arm64 specific so I thought it unnecessary.

I don't think arch_ would be right, as I don't expect any other arch to
have these variables.

I'll post a new patch version soon.

-Geoff
