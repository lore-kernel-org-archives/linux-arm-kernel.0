From: james.morse@arm.com (James Morse)
Date: Fri, 30 Oct 2015 16:29:01 +0000
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
Message-ID: <56339ACD.7010506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 20/10/15 00:38, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/Kconfig                  |  10 +++
>  arch/arm64/include/asm/kexec.h      |  48 +++++++++++
>  arch/arm64/kernel/Makefile          |   2 +
>  arch/arm64/kernel/cpu-reset.S       |   2 +-
>  arch/arm64/kernel/machine_kexec.c   | 141 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/relocate_kernel.S | 163 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kexec.h          |   1 +
>  7 files changed, 366 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kexec.h
>  create mode 100644 arch/arm64/kernel/machine_kexec.c
>  create mode 100644 arch/arm64/kernel/relocate_kernel.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 07d1811..73e8e31 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -491,6 +491,16 @@ config SECCOMP
>  	  and the task is only allowed to execute a few safe syscalls
>  	  defined by each seccomp mode.
>  
> +config KEXEC
> +	depends on (!SMP || PM_SLEEP_SMP)

Commit 4b3dc9679cf7 got rid of '!SMP'.


> +	select KEXEC_CORE
> +	bool "kexec system call"
> +	---help---
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel.  It is like a reboot
> +	  but it is independent of the system firmware.   And like a reboot
> +	  you can start any kernel with it, not just Linux.
> +
>  config XEN_DOM0
>  	def_bool y
>  	depends on XEN
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index ffc9e385e..7cc7f56 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2001 Deep Blue Solutions Ltd.
>   * Copyright (C) 2012 ARM Ltd.
> - * Copyright (C) 2015 Huawei Futurewei Technologies.
> + * Copyright (C) Huawei Futurewei Technologies.

Move this hunk into the patch that adds the file?


>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> new file mode 100644
> index 0000000..7b07a16
> --- /dev/null
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -0,0 +1,163 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + * Copyright (C) Huawei Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kexec.h>
> +
> +#include <asm/assembler.h>
> +#include <asm/kexec.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +
> +
> +/*
> + * arm64_relocate_new_kernel - Put a 2nd stage kernel image in place and boot it.
> + *
> + * The memory that the old kernel occupies may be overwritten when coping the
> + * new image to its final location.  To assure that the
> + * arm64_relocate_new_kernel routine which does that copy is not overwritten,
> + * all code and data needed by arm64_relocate_new_kernel must be between the
> + * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
> + * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
> + * control_code_page, a special page which has been set up to be preserved
> + * during the copy operation.
> + */
> +.globl arm64_relocate_new_kernel
> +arm64_relocate_new_kernel:
> +
> +	/* Setup the list loop variables. */
> +	ldr	x18, .Lkimage_head		/* x18 = list entry */
> +	dcache_line_size x17, x0		/* x17 = dcache line size */
> +	mov	x16, xzr			/* x16 = segment start */
> +	mov	x15, xzr			/* x15 = entry ptr */
> +	mov	x14, xzr			/* x14 = copy dest */
> +
> +	/* Check if the new image needs relocation. */
> +	cbz	x18, .Ldone
> +	tbnz	x18, IND_DONE_BIT, .Ldone
> +
> +.Lloop:
> +	and	x13, x18, PAGE_MASK		/* x13 = addr */
> +
> +	/* Test the entry flags. */
> +.Ltest_source:
> +	tbz	x18, IND_SOURCE_BIT, .Ltest_indirection
> +
> +	mov x20, x14				/*  x20 = copy dest */
> +	mov x21, x13				/*  x21 = copy src */
> +
> +	/* Invalidate dest page to PoC. */
> +	mov	x0, x20
> +	add	x19, x0, #PAGE_SIZE
> +	sub	x1, x17, #1
> +	bic	x0, x0, x1
> +1:	dc	ivac, x0
> +	add	x0, x0, x17
> +	cmp	x0, x19
> +	b.lo	1b
> +	dsb	sy

If I've followed all this through properly:

With KVM - mmu+caches are configured, but then disabled by 'kvm: allows kvm
cpu hotplug'. This 'arm64_relocate_new_kernel' function then runs at EL2
with M=0, C=0, I=0.

Without KVM - when there is no user of EL2, the mmu+caches are left in
whatever state the bootloader (or efi stub) left them in. From
Documentation/arm64/booting.txt:
> Instruction cache may be on or off.
and
> System caches which respect the architected cache maintenance by VA
> operations must be configured and may be enabled.

So 'arm64_relocate_new_kernel' function could run at EL2 with M=0, C=?, I=?.

I think this means you can't guarantee anything you are copying below
actually makes it through the caches - booting secondary processors may get
stale values.

The EFI stub disables the M and C bits when booted at EL2 with uefi - but
it leaves the instruction cache enabled. You only clean the
reboot_code_buffer from the data cache, so there may be stale values in the
instruction cache.

I think you need to disable the i-cache at EL1. If you jump to EL2, I think
you need to disable the I/C bits there too - as you can't rely on the code
in 'kvm: allows kvm cpu hotplug' to do this in a non-kvm case.


> +
> +	/* Copy page. */
> +1:	ldp	x22, x23, [x21]
> +	ldp	x24, x25, [x21, #16]
> +	ldp	x26, x27, [x21, #32]
> +	ldp	x28, x29, [x21, #48]
> +	add	x21, x21, #64
> +	stnp	x22, x23, [x20]
> +	stnp	x24, x25, [x20, #16]
> +	stnp	x26, x27, [x20, #32]
> +	stnp	x28, x29, [x20, #48]
> +	add	x20, x20, #64
> +	tst	x21, #(PAGE_SIZE - 1)
> +	b.ne	1b
> +
> +	/* dest += PAGE_SIZE */
> +	add	x14, x14, PAGE_SIZE
> +	b	.Lnext
> +
> +.Ltest_indirection:
> +	tbz	x18, IND_INDIRECTION_BIT, .Ltest_destination
> +
> +	/* ptr = addr */
> +	mov	x15, x13
> +	b	.Lnext
> +
> +.Ltest_destination:
> +	tbz	x18, IND_DESTINATION_BIT, .Lnext
> +
> +	mov	x16, x13
> +
> +	/* dest = addr */
> +	mov	x14, x13
> +
> +.Lnext:
> +	/* entry = *ptr++ */
> +	ldr	x18, [x15], #8
> +
> +	/* while (!(entry & DONE)) */
> +	tbz	x18, IND_DONE_BIT, .Lloop
> +
> +.Ldone:
> +	dsb	sy
> +	isb
> +	ic	ialluis
> +	dsb	sy

Why the second dsb?


> +	isb
> +
> +	/* Start new image. */
> +	ldr	x4, .Lkimage_start
> +	mov	x0, xzr
> +	mov	x1, xzr
> +	mov	x2, xzr
> +	mov	x3, xzr

Once the kexec'd kernel is booting, I get:
> WARNING: x1-x3 nonzero in violation of boot protocol:
>         x1: 0000000080008000
>         x2: 0000000000000020
>         x3: 0000000000000020
> This indicates a broken bootloader or old kernel

Presumably this 'kimage_start' isn't pointing to the new kernel, but the
purgatory code, (which comes from user-space?). (If so what are these xzr-s
for?)


> +	br	x4
> +
> +.align 3	/* To keep the 64-bit values below naturally aligned. */
> +
> +/* The machine_kexec routine sets these variables via offsets from
> + * arm64_relocate_new_kernel.
> + */
> +
> +/*
> + * .Lkimage_start - Copy of image->start, the entry point of the new
> + * image.
> + */
> +.Lkimage_start:
> +	.quad	0x0
> +
> +/*
> + * .Lkimage_head - Copy of image->head, the list of kimage entries.
> + */
> +.Lkimage_head:
> +	.quad	0x0
> +

I assume these .quad-s are used because you can't pass the values in via
registers - due to the complicated soft_restart(). Given you are the only
user, couldn't you simplify it to do all the disabling in
arm64_relocate_new_kernel?


> +.Lcopy_end:
> +.org	KEXEC_CONTROL_PAGE_SIZE
> +
> +/*
> + * arm64_relocate_new_kernel_size - Number of bytes to copy to the control_code_page.
> + */
> +.globl arm64_relocate_new_kernel_size
> +arm64_relocate_new_kernel_size:
> +	.quad	.Lcopy_end - arm64_relocate_new_kernel
> +
> +/*
> + * arm64_kexec_kimage_start_offset - Offset for writing .Lkimage_start.
> + */
> +.globl arm64_kexec_kimage_start_offset
> +arm64_kexec_kimage_start_offset:
> +	.quad	.Lkimage_start - arm64_relocate_new_kernel
> +
> +/*
> + * arm64_kexec_kimage_head_offset - Offset for writing .Lkimage_head.
> + */
> +.globl arm64_kexec_kimage_head_offset
> +arm64_kexec_kimage_head_offset:
> +	.quad	.Lkimage_head - arm64_relocate_new_kernel


>From 'kexec -e' to the first messages from the new kernel takes ~1 minute
on Juno, Did you see a similar delay? Or should I go looking for what I've
configured wrong!?

(Copying code with the mmu+caches on, then cleaning to PoC was noticeably
faster for hibernate)


I've used this series for kexec-ing between 4K and 64K page_size kernels on
Juno.

Tested-By: James Morse <james.morse@arm.com>



Thanks!

James
