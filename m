From: geoff@infradead.org (Geoff Levand)
Date: Mon, 02 Nov 2015 16:30:16 -0800
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <56339ACD.7010506@arm.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <56339ACD.7010506@arm.com>
Message-ID: <1446510616.23374.3.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, 2015-10-30 at 16:29 +0000, James Morse wrote:
> On 20/10/15 00:38, Geoff Levand wrote:
> > +config KEXEC
> > +> > 	> > depends on (!SMP || PM_SLEEP_SMP)
> 
> Commit 4b3dc9679cf7 got rid of '!SMP'.

Fixed for v11.

> > - * Copyright (C) 2015 Huawei Futurewei Technologies.
> > + * Copyright (C) Huawei Futurewei Technologies.
> 
> Move this hunk into the patch that adds the file?

Was fixed in v10.2.
 

> > +++ b/arch/arm64/kernel/relocate_kernel.S

> If I've followed all this through properly:
> 
> With KVM - mmu+caches are configured, but then disabled by 'kvm: allows kvm
> cpu hotplug'. This 'arm64_relocate_new_kernel' function then runs at EL2
> with M=0, C=0, I=0.
> 
> Without KVM - when there is no user of EL2, the mmu+caches are left in
> whatever state the bootloader (or efi stub) left them in. From
> Documentation/arm64/booting.txt:
> > Instruction cache may be on or off.
> and
> > System caches which respect the architected cache maintenance by VA
> > operations must be configured and may be enabled.
> 
> So 'arm64_relocate_new_kernel' function could run at EL2 with M=0, C=?, I=?.
> 
> I think this means you can't guarantee anything you are copying below
> actually makes it through the caches - booting secondary processors may get
> stale values.
> 
> The EFI stub disables the M and C bits when booted at EL2 with uefi - but
> it leaves the instruction cache enabled. You only clean the
> reboot_code_buffer from the data cache, so there may be stale values in the
> instruction cache.
> 
> I think you need to disable the i-cache at EL1. If you jump to EL2, I think
> you need to disable the I/C bits there too - as you can't rely on the code
> in 'kvm: allows kvm cpu hotplug' to do this in a non-kvm case.

For consistency across all code paths, we could put in something like this:

+       /* Clear SCTLR_ELx_FLAGS. */
+       mrs     x0, CurrentEL
+       cmp     x0, #CurrentEL_EL2
+       b.ne    1f
+       mrs     x0, sctlr_el2
+       ldr     x1, =SCTLR_EL2_FLAGS
+       bic     x0, x0, x1
+       msr     sctlr_el2, x0
+       isb
+       b       2f
+1:     mrs     x0, sctlr_el1
+       ldr     x1, =SCTLR_EL2_FLAGS
+       bic     x0, x0, x1
+       msr     sctlr_el1, x0
+       isb



> > +.Ldone:
> > +> > 	> > dsb> > 	> > sy
> > +> > 	> > isb
> > +> > 	> > ic> > 	> > ialluis
> > +> > 	> > dsb> > 	> > sy
> 
> Why the second dsb?

I removed the first isb as Mark suggested.


> 
> > +> > 	> > isb
> > +
> > +> > 	> > /* Start new image. */
> > +> > 	> > ldr> > 	> > x4, .Lkimage_start
> > +> > 	> > mov> > 	> > x0, xzr
> > +> > 	> > mov> > 	> > x1, xzr
> > +> > 	> > mov> > 	> > x2, xzr
> > +> > 	> > mov> > 	> > x3, xzr
> 
> Once the kexec'd kernel is booting, I get:
> > WARNING: x1-x3 nonzero in violation of boot protocol:
> >         x1: 0000000080008000
> >         x2: 0000000000000020
> >         x3: 0000000000000020
> > This indicates a broken bootloader or old kernel
> 
> Presumably this 'kimage_start' isn't pointing to the new kernel, but the
> purgatory code, (which comes from user-space?). (If so what are these xzr-s
> for?)

The warning was from the arm64 purgatory in kexec-tools, now fixed.

We don't need to zero the registers anymore.   At one time I had
an option where the kernel found the dtb section and jumped
directly to the new image as the 32 bit arm kernel does.

> +/* The machine_kexec routine sets these variables via offsets from
> > + * arm64_relocate_new_kernel.
> > + */
> > +
> > +/*
> > + * .Lkimage_start - Copy of image->start, the entry point of the new
> > + * image.
> > + */
> > +.Lkimage_start:
> > +> > 	> > .quad> > 	> > 0x0
> > +
> > +/*
> > + * .Lkimage_head - Copy of image->head, the list of kimage entries.
> > + */
> > +.Lkimage_head:
> > +> > 	> > .quad> > 	> > 0x0
> > +
> 
> I assume these .quad-s are used because you can't pass the values in via
> registers - due to the complicated soft_restart(). Given you are the only
> user, couldn't you simplify it to do all the disabling in
> arm64_relocate_new_kernel?

I moved some things from cpu_reset to arm64_relocate_new_kernel, but
from what Takahiro has said, to support a modular kvm some of the CPU
shutdown code will be shared.  Maybe we can look into simplifying things
once work on modular kvm is started.


> 
> From 'kexec -e' to the first messages from the new kernel takes ~1 minute
> on Juno, Did you see a similar delay? Or should I go looking for what I've
> configured wrong!?

As Pratyush has mentioned this is most likely due to the dcaches
being disabled.

> (Copying code with the mmu+caches on, then cleaning to PoC was noticeably
> faster for hibernate)
> 
> 
> I've used this series for kexec-ing between 4K and 64K page_size kernels on
> Juno.

Thanks for testing.

-Geoff
