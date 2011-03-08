From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 8 Mar 2011 07:37:59 +0100
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <1297892343-29064-2-git-send-email-nico@fluxnic.net>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110308063759.GB9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:39 Wed 16 Feb     , Nicolas Pitre wrote:
> We currently presume a 4x expansion to guess the decompressed kernel size
> in order to determine if the decompressed kernel is in conflict with
> the location where zImage is loaded.  This guess may cause many issues
> by overestimating the final kernel image size:
> 
> - This may force a needless relocation if the location of zImage was
>   fine, wasting some precious microseconds of boot time.
> 
> - The relocation may be located way too far, possibly overwriting the
>   initrd image in RAM.
> 
> - If the kernel image includes a large already-compressed initramfs image
>   then the problem is even more exacerbated.
> 
> And if by some strange means the 4x guess is too low then we may overwrite
> ourselves with the decompressed image.
> 
> So let's use the exact decompressed kernel image size instead.  For that
> we need to rely on the stat command, but this is hardly a new build
> dependency as the kernel already depends on many commands provided by
> the same coreutils package where stat is found to be built.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/boot/compressed/Makefile       |    4 +++-
>  arch/arm/boot/compressed/vmlinux.lds.in |    3 ---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 0a8f748..9d328be 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -83,9 +83,11 @@ endif
>  EXTRA_CFLAGS  := -fpic -fno-builtin
>  EXTRA_AFLAGS  := -Wa,-march=all
>  
> +# Provide size of uncompressed kernel to the decompressor via a linker symbol.
> +LDFLAGS_vmlinux := --defsym _image_size=$(shell stat -c "%s" $(obj)/../Image)
the build fail when compiling out of tree with -j9

$ make O=sx5 V=1 -j9 

=>

  scripts/mod/modpost   -o /opt/work/linux-2.6/sx5/Module.symvers    -S  -c -s
make -f /opt/work/linux-2.6/scripts/Makefile.fwinst obj=firmware __fw_modbuild
  arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/boot/compressed/.piggy.gzip.o.d  -nostdinc -isystem /opt/arm-2010/bin/../lib/gcc/arm-none-linux-gnueabi/4.5.1/include -I/opt/work/linux-2.6/arch/arm/include -Iinclude  -I/opt/work/linux-2.6/include -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian   -I/opt/work/linux-2.6/arch/arm/mach-at91/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=5 -march=armv5te -mtune=arm9tdmi -include asm/unified.h -msoft-float -Wa,-march=all   -c -o arch/arm/boot/compressed/piggy.gzip.o /opt/work/linux-2.6/arch/arm/boot/compressed/piggy.gzip.S
  arm-none-linux-gnueabi-ld -EL    --defsym _image_size= --defsym zreladdr=0x20008000 -p --no-undefined -X -T arch/arm/boot/compressed/vmlinux.lds arch/arm/boot/compressed/head.o arch/arm/boot/compressed/piggy.gzip.o arch/arm/boot/compressed/misc.o arch/arm/boot/compressed/decompress.o arch/arm/boot/compressed/lib1funcs.o -o arch/arm/boot/compressed/vmlinux 
arm-none-linux-gnueabi-ld:--defsym _image_size=: syntax error
make[3]: *** [arch/arm/boot/compressed/vmlinux] Error 1
make[2]: *** [arch/arm/boot/compressed/vmlinux] Error 2
make[1]: *** [zImage] Error 2
make: *** [sub-make] Error 2

Best Regards,
J.
