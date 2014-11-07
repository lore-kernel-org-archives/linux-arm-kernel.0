From: achandran@mvista.com (Arun Chandran)
Date: Fri, 7 Nov 2014 16:31:51 +0530
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
Message-ID: <CAFdej022x_XxqR3NJJkXD60wQHt8Yvs3vZ7nbMQczHP+hWXfCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> new file mode 100644
> index 0000000..49cf9a0
> --- /dev/null
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -0,0 +1,184 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/assembler.h>
> +#include <asm/kexec.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +#include <asm/proc-macros.S>
> +
> +/* The list entry flags. */
> +
> +#define IND_DESTINATION_BIT 0
> +#define IND_INDIRECTION_BIT 1
> +#define IND_DONE_BIT        2
> +#define IND_SOURCE_BIT      3
> +
> +/*
> + * relocate_new_kernel - Put a 2nd stage kernel image in place and boot it.
> + *
> + * The memory that the old kernel occupies may be overwritten when coping the
> + * new image to its final location.  To assure that the relocate_new_kernel
> + * routine which does that copy is not overwritten all code and data needed
> + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> + * relocate_new_kernel to the kexec control_code_page, a special page which
> + * has been set up to be preserved during the copy operation.
> + */
> +
> +.globl relocate_new_kernel
> +relocate_new_kernel:
> +
> +       /* Setup the list loop variables. */
> +
> +       ldr     x18, arm64_kexec_kimage_head    /* x18 = list entry */
> +       dcache_line_size x17, x0                /* x17 = dcache line size */
> +       mov     x16, xzr                        /* x16 = segment start */
> +       mov     x15, xzr                        /* x15 = entry ptr */
> +       mov     x14, xzr                        /* x14 = copy dest */
> +
> +       /* Check if the new image needs relocation. */
> +
> +       cbz     x18, .Ldone
> +       tbnz    x18, IND_DONE_BIT, .Ldone
> +
> +.Lloop:
> +       and     x13, x18, PAGE_MASK             /* x13 = addr */
> +
> +       /* Test the entry flags. */
> +
> +.Ltest_source:
> +       tbz     x18, IND_SOURCE_BIT, .Ltest_indirection
> +
> +       /* copy_page(x20 = dest, x21 = src) */
> +
> +       mov x20, x14
> +       mov x21, x13
> +
> +1:     ldp     x22, x23, [x21]
> +       ldp     x24, x25, [x21, #16]
> +       ldp     x26, x27, [x21, #32]
> +       ldp     x28, x29, [x21, #48]
> +       add     x21, x21, #64
> +       stnp    x22, x23, [x20]
> +       stnp    x24, x25, [x20, #16]
> +       stnp    x26, x27, [x20, #32]
> +       stnp    x28, x29, [x20, #48]
> +       add     x20, x20, #64
> +       tst     x21, #(PAGE_SIZE - 1)
> +       b.ne    1b
> +
> +       /* dest += PAGE_SIZE */
> +
> +       add     x14, x14, PAGE_SIZE
> +       b       .Lnext
> +
> +.Ltest_indirection:
> +       tbz     x18, IND_INDIRECTION_BIT, .Ltest_destination
> +
> +       /* ptr = addr */
> +
> +       mov     x15, x13
> +       b       .Lnext
> +
> +.Ltest_destination:
> +       tbz     x18, IND_DESTINATION_BIT, .Lnext
> +
> +       /* flush segment */
> +
> +       bl      .Lflush
> +       mov     x16, x13
> +
> +       /* dest = addr */
> +
> +       mov     x14, x13
> +
> +.Lnext:
> +       /* entry = *ptr++ */
> +
> +       ldr     x18, [x15], #8
> +
> +       /* while (!(entry & DONE)) */
> +
> +       tbz     x18, IND_DONE_BIT, .Lloop
> +
> +.Ldone:
> +       /* flush last segment */
> +
> +       bl      .Lflush
> +
> +       dsb     sy
> +       isb
> +       ic      ialluis
> +       dsb     sy
> +       isb
> +
> +       /* start_new_image */
> +
> +       ldr     x4, arm64_kexec_kimage_start
> +       ldr     x0, arm64_kexec_dtb_addr
> +       mov     x1, xzr
> +       mov     x2, xzr
> +       mov     x3, xzr
> +       br      x4
> +
> +/* flush - x17 = line size, x16 = start addr, x14 = end addr. */
> +
> +.Lflush:
> +       cbz     x16, 2f
> +       mov     x0, x16
> +       sub     x1, x17, #1
> +       bic     x0, x0, x1
> +1:     dc      civac, x0
> +       add     x0, x0, x17
> +       cmp     x0, x14
> +       b.lo    1b
> +2:     ret
> +

I have issue in flushing with L3 cache on . kexec does not reboot with L3.
Is the above logic of flushing (clean + invalidate) after copying the
image data is correct? Is there exist the danger of image data being
overwritten by invalid cache lines?

I tried with only invalidate(dc ivac); but that also not seems to be
working.

Finally I moved the entire flushing logic before copying then
things started working. Please see the code change below.

############
diff --git a/arch/arm64/kernel/relocate_kernel.S
b/arch/arm64/kernel/relocate_kernel.S
index 49cf9a0..f06c082 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -62,6 +62,17 @@ relocate_new_kernel:
        mov x20, x14
        mov x21, x13

+.Lflush:
+       mov     x0, x14
+       add     x19, x0, #PAGE_SIZE
+       sub     x1, x17, #1
+       bic     x0, x0, x1
+1:     dc      ivac, x0
+       add     x0, x0, x17
+       cmp     x0, x19
+       b.lo    1b
+       dsb     sy
+
 1:     ldp     x22, x23, [x21]
        ldp     x24, x25, [x21, #16]
        ldp     x26, x27, [x21, #32]
@@ -91,11 +102,6 @@ relocate_new_kernel:
 .Ltest_destination:
        tbz     x18, IND_DESTINATION_BIT, .Lnext

-       /* flush segment */
-
-       bl      .Lflush
-       mov     x16, x13
-
        /* dest = addr */

        mov     x14, x13
@@ -110,12 +116,7 @@ relocate_new_kernel:
        tbz     x18, IND_DONE_BIT, .Lloop

 .Ldone:
-       /* flush last segment */
-
-       bl      .Lflush

-       dsb     sy
-       isb
        ic      ialluis
        dsb     sy
        isb
@@ -129,19 +130,6 @@ relocate_new_kernel:
        mov     x3, xzr
        br      x4

-/* flush - x17 = line size, x16 = start addr, x14 = end addr. */
-
-.Lflush:
-       cbz     x16, 2f
-       mov     x0, x16
-       sub     x1, x17, #1
-       bic     x0, x0, x1
-1:     dc      civac, x0
-       add     x0, x0, x17
-       cmp     x0, x14
-       b.lo    1b
-2:     ret
-
 .align 3       /* To keep the 64-bit values below naturally aligned. */

 /* The machine_kexec routines set these variables. */
################

--Arun




> +.align 3       /* To keep the 64-bit values below naturally aligned. */
> +
> +/* The machine_kexec routines set these variables. */
> +
> +/*
> + * arm64_kexec_kimage_start - Copy of image->start, the entry point of the new
> + * image.
> + */
> +
> +.globl arm64_kexec_kimage_start
> +arm64_kexec_kimage_start:
> +       .quad   0x0
> +
> +/*
> + * arm64_kexec_dtb_addr - Physical address of a device tree.
> + */
> +
> +.globl arm64_kexec_dtb_addr
> +arm64_kexec_dtb_addr:
> +       .quad   0x0
> +
> +/*
> + * arm64_kexec_kimage_head - Copy of image->head, the list of kimage entries.
> + */
> +
> +.globl arm64_kexec_kimage_head
> +arm64_kexec_kimage_head:
> +       .quad   0x0
> +
> +.Lrelocate_new_kernel_end:
> +
> +/*
> + * relocate_new_kernel_size - Number of bytes to copy to the control_code_page.
> + */
> +
> +.globl relocate_new_kernel_size
> +relocate_new_kernel_size:
> +       .quad .Lrelocate_new_kernel_end - relocate_new_kernel
> +
> +.org   KEXEC_CONTROL_PAGE_SIZE
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 6925f5b..04626b9 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -39,6 +39,7 @@
>  #define KEXEC_ARCH_SH      (42 << 16)
>  #define KEXEC_ARCH_MIPS_LE (10 << 16)
>  #define KEXEC_ARCH_MIPS    ( 8 << 16)
> +#define KEXEC_ARCH_ARM64   (183 << 16)
>
>  /* The artificial cap on the number of segments passed to kexec_load. */
>  #define KEXEC_SEGMENT_MAX 16
> --
> 1.9.1
>
