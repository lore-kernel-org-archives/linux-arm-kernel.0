From: geoff@infradead.org (Geoff Levand)
Date: Tue, 15 Dec 2015 16:14:30 -0800
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151215182932.GF353@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151215182932.GF353@arm.com>
Message-ID: <1450224870.24127.130.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I'll post a v12.4 of this patch that addresses your comments.

On Tue, 2015-12-15 at 18:29 +0000, Will Deacon wrote:
> +#if !defined(_ARM64_KEXEC_H)
> > +#define _ARM64_KEXEC_H
> 
> Please keep to the style used elsewhere in the arch headers.

OK.

> > +
> > +#define KEXEC_CONTROL_PAGE_SIZE> > 	> > 4096
> 
> Does this work on kernels configured with 64k pages? It looks like the
> kexec core code will end up using order-0 pages, so I worry that we'll
> actually put down 64k and potentially confuse a 4k crash kernel, for
> example.

KEXEC_CONTROL_PAGE_SIZE just tells the core kexec code how big
we need control_code_buffer to be.  That buffer is only used by
the arch code of the first stage kernel.  With 64k pages the buffer
will be a full page, but we'll only use the first 4k of it. 

> > +#define KEXEC_ARCH KEXEC_ARCH_ARM64
> > +
> > +#if !defined(__ASSEMBLY__)
> 
> #ifndef

OK.

> > + * machine_kexec - Do the kexec reboot.
> > + *
> > + * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
> > + */
> > +void machine_kexec(struct kimage *kimage)
> > +{
> > +> > 	> > phys_addr_t reboot_code_buffer_phys;
> > +> > 	> > void *reboot_code_buffer;
> > +
> > +> > 	> > BUG_ON(num_online_cpus() > 1);
> > +
> > +> > 	> > reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
> > +> > 	> > reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> > +
> > +> > 	> > /*
> > +> > 	> >  * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> > +> > 	> >  * after the kernel is shut down.
> > +> > 	> >  */
> > +> > 	> > memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> > +> > 	> > 	> > arm64_relocate_new_kernel_size);
> 
> At which point does the I-cache get invalidated for this?

I'll add a call to flush_icache_range() for reboot_code_buffer.  I
think that should do it.

> > +
> > +> > 	> > /* Flush the reboot_code_buffer in preparation for its execution. */
> > +> > 	> > __flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> > +
> > +> > 	> > /* Flush the new image. */
> > +> > 	> > kexec_segment_flush(kimage);
> > +
> > +> > 	> > /* Flush the kimage list. */
> > +> > 	> > kexec_list_flush(kimage->head);
> > +
> > +> > 	> > pr_info("Bye!\n");
> > +
> > +> > 	> > /* Disable all DAIF exceptions. */
> > +> > 	> > asm volatile ("msr > > daifset> > , #0xf" : : :
> > "memory");
> 
> Can we not use our helpers for this?

Mark Rutland had commented that calling daifset four times
through the different macros took considerable time, and
recommended a single call here.

Would you prefer a new macro for irqflags.h, maybe

  #define local_daif_disable() asm("msr daifset, #0xf" : : : "memory")?

> > +/*
> > + * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
> > + *
> > + * The memory that the old kernel occupies may be overwritten when coping the
> > + * new image to its final location.  To assure that the
> > + * arm64_relocate_new_kernel routine which does that copy is not overwritten,
> > + * all code and data needed by arm64_relocate_new_kernel must be between the
> > + * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
> > + * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
> > + * control_code_page, a special page which has been set up to be preserved
> > + * during the copy operation.
> > + */
> > +.globl arm64_relocate_new_kernel
> > +arm64_relocate_new_kernel:
> > +
> > +> > 	> > /* Setup the list loop variables. */
> > +> > 	> > mov> > 	> > x18, x0> > 	> > 	> > 	> > 	> > /* x18 = kimage_head */
> > +> > 	> > mov> > 	> > x17, x1> > 	> > 	> > 	> > 	> > /* x17 = kimage_start */
> > +> > 	> > dcache_line_size x16, x0> > 	> > 	> > /* x16 = dcache line size */
> 
> Why is this needed?

This was left over from the previous version where we
invalidated pages while copying them.  I've since added
that invalidate back, so this is again needed.

> 
> > +> > 	> > mov> > 	> > x15, xzr> > 	> > 	> > 	> > /* x15 = segment start */
> > +> > 	> > mov> > 	> > x14, xzr> > 	> > 	> > 	> > /* x14 = entry ptr */
> > +> > 	> > mov> > 	> > x13, xzr> > 	> > 	> > 	> > /* x13 = copy dest */
> > +
> > +> > 	> > /* Clear the sctlr_el2 flags. */
> > +> > 	> > mrs> > 	> > x0, CurrentEL
> > +> > 	> > cmp> > 	> > x0, #CurrentEL_EL2
> > +> > 	> > b.ne> > 	> > 1f
> > +> > 	> > mrs> > 	> > x0, sctlr_el2
> > +> > 	> > ldr> > 	> > x1, =SCTLR_EL2_FLAGS
> 
> If we're using literal pools, we probably want a .ltorg directive somewhere.

I've added one in at the end of the arm64_relocate_new_kernel
code.

> > +> > 	> > bic> > 	> > x0, x0, x1
> > +> > 	> > msr> > 	> > sctlr_el2, x0
> > +> > 	> > isb
> > +1:
> > +
> > +> > 	> > /* Check if the new image needs relocation. */
> > +> > 	> > cbz> > 	> > x18, .Ldone
> > +> > 	> > tbnz> > 	> > x18, IND_DONE_BIT, .Ldone
> > +
> > +.Lloop:
> > +> > 	> > and> > 	> > x12, x18, PAGE_MASK> > 	> > 	> > /* x12 = addr */
> > +
> > +> > 	> > /* Test the entry flags. */
> > +.Ltest_source:
> > +> > 	> > tbz> > 	> > x18, IND_SOURCE_BIT, .Ltest_indirection
> > +
> > +> > 	> > mov x20, x13> > 	> > 	> > 	> > 	> > /*  x20 = copy dest */
> > +> > 	> > mov x21, x12> > 	> > 	> > 	> > 	> > /*  x21 = copy src */
> 
> Weird indentation.

Fixed.

> > +> > 	> > /* Copy page. */
> > +1:> > 	> > ldp> > 	> > x22, x23, [x21]
> > +> > 	> > ldp> > 	> > x24, x25, [x21, #16]
> > +> > 	> > ldp> > 	> > x26, x27, [x21, #32]
> > +> > 	> > ldp> > 	> > x28, x29, [x21, #48]
> > +> > 	> > add> > 	> > x21, x21, #64
> > +> > 	> > stnp> > 	> > x22, x23, [x20]
> > +> > 	> > stnp> > 	> > x24, x25, [x20, #16]
> > +> > 	> > stnp> > 	> > x26, x27, [x20, #32]
> > +> > 	> > stnp> > 	> > x28, x29, [x20, #48]
> > +> > 	> > add> > 	> > x20, x20, #64
> > +> > 	> > tst> > 	> > x21, #(PAGE_SIZE - 1)
> > +> > 	> > b.ne> > 	> > 1b
> 
> We should macroise this, to save on duplication of a common routine.

So something like this in assembler.h?

+/*
+ * copy_page - copy src to dest using temp registers t1-t8
+ */
+	.macro copy_page dest:req src:req t1:req t2:req t3:req t4:req t5:req t6:req t7:req t8:req
+1:	ldp	/t1, /t2, [/src]
+	ldp	/t3, /t4, [/src, #16]
+	ldp	/t5, /t6, [/src, #32]
+	ldp	/t7, /t8, [/src, #48]
+	add	/src, /src, #64
+	stnp	/t1, /t2, [/dest]
+	stnp	/t3, /t4, [/dest, #16]
+	stnp	/t5, /t6, [/dest, #32]
+	stnp	/t7, /t8, [/dest, #48]
+	add	/dest, /dest, #64
+	tst	/src, #(PAGE_SIZE - 1)
+	b.ne	1b
+	.endm

> You also need to address the caching issues that Mark raised separately.

Cache maintenance has been fixed (reintroduced) in the current code.

> 
> > +> > 	> > /* dest += PAGE_SIZE */
> > +> > 	> > add> > 	> > x13, x13, PAGE_SIZE
> > +> > 	> > b> > 	> > .Lnext
> > +
> > +.Ltest_indirection:
> > +> > 	> > tbz> > 	> > x18, IND_INDIRECTION_BIT, .Ltest_destination
> > +
> > +> > 	> > /* ptr = addr */
> > +> > 	> > mov> > 	> > x14, x12
> > +> > 	> > b> > 	> > .Lnext
> > +
> > +.Ltest_destination:
> > +> > 	> > tbz> > 	> > x18, IND_DESTINATION_BIT, .Lnext
> > +
> > +> > 	> > mov> > 	> > x15, x12
> > +
> > +> > 	> > /* dest = addr */
> > +> > 	> > mov> > 	> > x13, x12
> > +
> > +.Lnext:
> > +> > 	> > /* entry = *ptr++ */
> > +> > 	> > ldr> > 	> > x18, [x14], #8
> > +
> > +> > 	> > /* while (!(entry & DONE)) */
> > +> > 	> > tbz> > 	> > x18, IND_DONE_BIT, .Lloop
> > +
> > +.Ldone:
> > +> > 	> > dsb> > 	> > sy
> > +> > 	> > ic> > 	> > ialluis
> 
> I don't think this needs to be inner-shareable, and these dsbs can probably
> be non-shareable too.

OK.

> > +> > 	> > dsb> > 	> > sy
> > +> > 	> > isb
> > +
> > +> > 	> > /* Start new image. */
> > +> > 	> > mov> > 	> > x0, xzr
> > +> > 	> > mov> > 	> > x1, xzr
> > +> > 	> > mov> > 	> > x2, xzr
> > +> > 	> > mov> > 	> > x3, xzr
> > +> > 	> > br> > 	> > x17
> > +
> > +.align 3> > 	> > /* To keep the 64-bit values below naturally aligned. */
> > +
> > +.Lcopy_end:
> > +.org> > 	> > KEXEC_CONTROL_PAGE_SIZE
> > +
> > +/*
> > + * arm64_relocate_new_kernel_size - Number of bytes to copy to the
> > + * control_code_page.
> > + */
> > +.globl arm64_relocate_new_kernel_size
> > +arm64_relocate_new_kernel_size:
> > +> > 	> > .quad> > 	> > .Lcopy_end - arm64_relocate_new_kernel
> > diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> > index 99048e5..ccec467 100644
> > --- a/include/uapi/linux/kexec.h
> > +++ b/include/uapi/linux/kexec.h
> > @@ -39,6 +39,7 @@
> >  #define KEXEC_ARCH_SH      (42 << 16)
> >  #define KEXEC_ARCH_MIPS_LE (10 << 16)
> >  #define KEXEC_ARCH_MIPS    ( 8 << 16)
> > +#define KEXEC_ARCH_ARM64   (183 << 16)
> 
> This should probably be called KEXEC_ARCH_AARCH64 for consistency with
> the ELF machine name.

OK.

-Geoff
