From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 26 Aug 2017 11:58:08 +0100
Subject: [PATCH 3/3] ARM: XIP kernel: store .data compressed in ROM
In-Reply-To: <20170825162600.15709-4-nicolas.pitre@linaro.org>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <20170825162600.15709-4-nicolas.pitre@linaro.org>
Message-ID: <CAKv+Gu-5W-bDrMKRctV=muZgN3D9YWThCqP7bqY00zo2AnrA1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 August 2017 at 17:26, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The .data segment stored in ROM is only copied to RAM once at boot time
> and never referenced afterwards. This is arguably a suboptimal usage of
> ROM resources.
>
> This patch allows for compressing the .data segment before storing it
> into ROM and decompressing it to RAM rather than simply copying it,
> saving on precious ROM space.
>
> Because global data is not available yet (obviously) we must allocate
> decompressor workspace memory on the stack. The .bss area is used as a
> stack area for that purpose before it is cleared. The required stack
> frame is 9568 bytes for __inflate_kernel_data() alone, so make sure
> the .bss is large enough to cope with that plus extra room for called
> functions or fail the build.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/Kconfig                    | 11 +++++++
>  arch/arm/boot/Makefile              | 13 +++++++-
>  arch/arm/boot/deflate_xip_data.sh   | 62 ++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/Makefile            |  5 +++
>  arch/arm/kernel/head-common.S       | 11 ++++++-
>  arch/arm/kernel/head-inflate-data.c | 63 +++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/vmlinux-xip.lds.S   |  8 +++++
>  7 files changed, 171 insertions(+), 2 deletions(-)
>  create mode 100755 arch/arm/boot/deflate_xip_data.sh
>  create mode 100644 arch/arm/kernel/head-inflate-data.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 61a0cb1506..bf79c461bd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2005,6 +2005,17 @@ config XIP_PHYS_ADDR
>           be linked for and stored to.  This address is dependent on your
>           own flash usage.
>
> +config XIP_DEFLATED_DATA
> +       bool "Store kernel .data section compressed in ROM"
> +       depends on XIP_KERNEL
> +       select ZLIB_INFLATE
> +       help
> +         Before the kernel is actually executed, its .data section has to be
> +         copied to RAM from ROM. This option allows for storing that data
> +         in compressed form and decompressed to RAM rather than merely being
> +         copied, saving some precious ROM space. A possible drawback is a
> +         slightly longer boot delay.
> +
>  config KEXEC
>         bool "Kexec system call (EXPERIMENTAL)"
>         depends on (!SMP || PM_SLEEP_SMP)
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 50f8d1be7f..8b5d33a524 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -31,8 +31,19 @@ targets := Image zImage xipImage bootpImage uImage
>
>  ifeq ($(CONFIG_XIP_KERNEL),y)
>
> +cmd_deflate_xip_data = \
> +       $(CONFIG_SHELL) $(srctree)/$(src)/deflate_xip_data.sh $< $@
> +
> +ifeq ($(CONFIG_XIP_DEFLATED_DATA),y)
> +quiet_cmd_mkxip = XIPZ    $@
> +cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)
> +else
> +quiet_cmd_mkxip = $(quiet_cmd_objcopy)
> +cmd_mkxip = $(cmd_objcopy)
> +endif
> +
>  $(obj)/xipImage: vmlinux FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,mkxip)
>         @$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR)'
>
>  $(obj)/Image $(obj)/zImage: FORCE
> diff --git a/arch/arm/boot/deflate_xip_data.sh b/arch/arm/boot/deflate_xip_data.sh
> new file mode 100755
> index 0000000000..18c9bc398a
> --- /dev/null
> +++ b/arch/arm/boot/deflate_xip_data.sh
> @@ -0,0 +1,62 @@
> +#!/bin/sh
> +
> +# XIP kernel .data segment compressor
> +#
> +# Created by:  Nicolas Pitre, August 2017
> +# Copyright:   (C) 2017  Linaro Limited
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +
> +# This script locates the start of the .data section in xipImage and
> +# substitutes it with a compressed version. The needed offsets are obtained
> +# from symbol addresses in vmlinux. It is expected that .data extends to
> +# the end of xipImage.
> +
> +set -e
> +
> +VMLINUX="$1"
> +XIPIMAGE="$2"
> +
> +DD="dd status=none"
> +
> +# Use "make V=1" to debug this script.
> +case "$KBUILD_VERBOSE" in
> +*1*)
> +       set -x
> +       ;;
> +esac
> +
> +sym_val() {
> +       # extract hex value for symbol in $1
> +       local val=$($NM "$VMLINUX" | sed -n "/ $1$/{s/ .*$//p;q}")
> +       [ "$val" ] || { echo "can't find $1 in $VMLINUX" 1>&2; exit 1; }
> +       # convert from hex to decimal
> +       echo $((0x$val))
> +}
> +
> +base_offset=$(sym_val _xiprom)
> +data_start=$(sym_val __data_loc)
> +data_end=$(sym_val _edata_loc)
> +
> +# convert to file based offsets
> +data_start=$(($data_start - $base_offset))
> +data_end=$(($data_end - $base_offset))
> +
> +# make sure data occupies the last part of the file
> +file_end=$(stat -c "%s" "$XIPIMAGE")
> +if [ "$file_end" != "$data_end" ]
> +then echo "data segment doesn't match end of xipImage" 2>&1; exit 1;
> +fi
> +
> +# be ready to clean up
> +trap 'rm -f "$XIPIMAGE.tmp"' 0 1 2 3
> +
> +# substitute the data section by a compressed version
> +$DD if="$XIPIMAGE" count=$data_start iflag=count_bytes of="$XIPIMAGE.tmp"
> +$DD if="$XIPIMAGE"  skip=$data_start iflag=skip_bytes |
> +gzip -9 >> "$XIPIMAGE.tmp"
> +
> +# replace kernel binary
> +mv -f "$XIPIMAGE.tmp" "$XIPIMAGE"
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index ad325a8c7e..52f437997c 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -87,6 +87,11 @@ head-y                       := head$(MMUEXT).o
>  obj-$(CONFIG_DEBUG_LL) += debug.o
>  obj-$(CONFIG_EARLY_PRINTK)     += early_printk.o
>
> +# This is executed very early using a temporary stack when no memory allocator
> +# nor global data is available. Everything has to be allocated on the stack.
> +CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
> +obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
> +
>  obj-$(CONFIG_ARM_VIRT_EXT)     += hyp-stub.o
>  AFLAGS_hyp-stub.o              :=-Wa,-march=armv7-a
>  ifeq ($(CONFIG_ARM_PSCI),y)
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 63a21fe03f..d57628f545 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -87,7 +87,14 @@ __mmap_switched:
>         adr     r4, __mmap_switched_data
>         mov     fp, #0
>
> -#ifdef CONFIG_XIP_KERNEL
> +#if defined(CONFIG_XIP_DEFLATED_DATA)
> +   ARM(        ldr     sp, [r4], #4 )
> + THUMB(        ldr     sp, [r4] )
> + THUMB(        add     r4, #4 )
> +       bl      __inflate_kernel_data           @ decompress .data to RAM
> +       teq     r0, #0
> +       bne     __error
> +#elif defined(CONFIG_XIP_KERNEL)
>     ARM(        ldmia   r4!, {r0, r1, r2, sp} )
>   THUMB(        ldmia   r4!, {r0, r1, r2, r3} )
>   THUMB(        mov     sp, r3 )
> @@ -114,9 +121,11 @@ ENDPROC(__mmap_switched)
>         .type   __mmap_switched_data, %object
>  __mmap_switched_data:
>  #ifdef CONFIG_XIP_KERNEL
> +#ifndef CONFIG_XIP_DEFLATED_DATA
>         .long   _sdata                          @ r0
>         .long   __data_loc                      @ r1
>         .long   _edata_loc                      @ r2
> +#endif
>         .long   _end                            @ sp (temporary stack in .bss)
>  #endif
>
> diff --git a/arch/arm/kernel/head-inflate-data.c b/arch/arm/kernel/head-inflate-data.c
> new file mode 100644
> index 0000000000..a12d241f0a
> --- /dev/null
> +++ b/arch/arm/kernel/head-inflate-data.c
> @@ -0,0 +1,63 @@
> +/*
> + * XIP kernel .data segment decompressor
> + *
> + * Created by: Nicolas Pitre, August 2017
> + * Copyright:  (C) 2017  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/zutil.h>
> +
> +/* for struct inflate_state */
> +#include "../../../lib/zlib_inflate/inftrees.h"
> +#include "../../../lib/zlib_inflate/inflate.h"
> +#include "../../../lib/zlib_inflate/infutil.h"
> +
> +extern char __data_loc[];
> +extern char _edata_loc[];
> +extern char _sdata[];
> +extern char _edata[];
> +
> +/*
> + * This code is called very early during the boot process to decompress
> + * the .data segment stored compressed in ROM. Therefore none of the global
> + * variables are valid yet, hence no kernel services such as memory
> + * allocation is available. Everything must be allocated on the stack and
> + * we must avoid any global data access. We use a temporary stack located
> + * in the .bss area. The linker script makes sure the .bss is big enough
> + * to hold our stack frame plus some room for called functions.
> + *
> + * We mimic the code in lib/decompress_inflate.c to use the smallest work
> + * area possible. And because everything is statically allocated on the
> + * stack then there is no need to clean up before returning.
> + */
> +
> +int __init __inflate_kernel_data(void)
> +{
> +       struct z_stream_s stream, *strm = &stream;
> +       struct inflate_state state;
> +       char *in = __data_loc;
> +       int rc;
> +
> +       /* Check and skip gzip header (assume no filename) */
> +       if (in[0] != 0x1f || in[1] != 0x8b || in[2] != 0x08 || in[3] & ~3)
> +               return -1;
> +       in += 10;
> +
> +       strm->workspace = &state;
> +       strm->next_in = in;
> +       strm->avail_in = _edata_loc - __data_loc;  /* upper bound */
> +       strm->next_out = _sdata;
> +       strm->avail_out = _edata - _sdata;
> +       zlib_inflateInit2(strm, -MAX_WBITS);
> +       WS(strm)->inflate_state.wsize = 0;
> +       WS(strm)->inflate_state.window = NULL;
> +       rc = zlib_inflate(strm, Z_FINISH);
> +       if (rc != Z_STREAM_END)
> +               return -1;
> +       return strm->avail_out;  /* should be 0 */
> +}
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index d6c08a4c30..3489d54da4 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -308,3 +308,11 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
>   */
>  ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & PAGE_MASK) <= PAGE_SIZE,
>         "HYP init code too big or misaligned")
> +
> +#ifdef CONFIG_XIP_DEFLATED_DATA
> +/*
> + * The .bss is used as a stack area for __inflate_kernel_data() whose stack
> + * frame is 9568 bytes. Make sure it has extra room left.
> + */
> +ASSERT((_end - __bss_start) >= 12288, ".bss too small for CONFIG_XIP_DEFLATED_DATA")

The open coded numbers are a bit confusing here: the stack check uses
10240, the code actually needs >9568 bytes and here, you assert that
there is at least 12288 space between _end and __bss_start.

Other than that, this patch looks correct to me.
