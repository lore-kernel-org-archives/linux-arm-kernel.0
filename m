From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Mar 2016 13:52:16 +0000
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <20160302135216.GB11670@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:34:55AM +0100, Andreas F?rber wrote:
> Hello,
> 
> This series adds initial support for the Amlogic S905 based
> Tronsmart Vega S95 Pro, Meta and Telos TV boxes.
> 
> v2:
> * Pick up previously acked "tronsmart" patch instead (Matthias)
> * Drop ARM_GIC selection (Sudeep)
> * Change some compatible strings (Sudeep, Andr?)
> * Squash some node changes/additions
> 
> Note: On the Vega S95 I need to change TEXT_OFFSET as follows,
> in order to avoid the vendor U-Boot overwriting itself (fwiu);
> for the Mini Mx that's reportedly not necessary.
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 354d75402ace..b7cebdb8b1ce 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -62,7 +62,7 @@ head-y                := arch/arm64/kernel/head.o
>  ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
>  TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%03x000\n", int(512 * rand())}')
>  else
> -TEXT_OFFSET := 0x00080000
> +TEXT_OFFSET := 0x01080000
>  endif
>  
>  # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)

Absolute NAK to this. TEXT_OFFSET is not open for platform-specific
modification.

Why can you not just load the Image 2MB higher regardless? Does the
U-Boot on this platform actually read TEXT_OFFSET and take it into
account?

> This in turn runs into an apparent regression introduced with the
> text offset randomization:
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6ebd204da16a..afdec27c8871 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -48,7 +48,7 @@
>  #elif (PAGE_OFFSET & 0x1fffff) != 0
>  #error PAGE_OFFSET must be at least 2MB aligned
>  #elif TEXT_OFFSET > 0x1fffff
> -#error TEXT_OFFSET must be less than 2MB
> +//#error TEXT_OFFSET must be less than 2MB
>  #endif
>  
>  #define KERNEL_START   _text

This is not a regression. As above, TEXT_OFFSET is not supposed to be
modified in a platform-specific manner.

Mark.
