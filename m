From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 16 Feb 2011 17:09:23 -0700
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <1297892343-29064-2-git-send-email-nico@fluxnic.net>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110217000923.GF2364@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 04:39:03PM -0500, Nicolas Pitre wrote:
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

Patch looks good to me, but on a related note, I'm looking for a way
to also find the end of .bss.

When John looks at adding support for appending an initrd and/or dtb
to the zimage, it will be important to make sure the start of the
initrd/dtb does not overlap the ram the kernel is expecting to be
empty and available.  I was thinking about simply grepping System.map
for __end and doing some sed magic to extract the offset from the
beginning of the kernel.

Do you think that is sufficient to protect appended data images?
