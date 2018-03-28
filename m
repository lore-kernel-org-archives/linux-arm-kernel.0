From: jhogan@kernel.org (James Hogan)
Date: Wed, 28 Mar 2018 16:21:15 +0100
Subject: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot
 phase
In-Reply-To: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
Message-ID: <20180328152115.GB1991@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..81df904 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -76,12 +76,7 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>  	unsigned long zimage_start, zimage_size;
>  
> -	__stack_chk_guard_setup();
> -
>  	zimage_start = (unsigned long)(&__image_begin);
>  	zimage_size = (unsigned long)(&__image_end) -
>  	    (unsigned long)(&__image_begin);

This looks good to me, though I've Cc'd Kees as apparently the original
author from commit 8779657d29c0 ("stackprotector: Introduce
CONFIG_CC_STACKPROTECTOR_STRONG") in case there was a particular reason
this wasn't done in the first place.

Acked-by: James Hogan <jhogan@kernel.org>

(Happy to apply with acks from Kees and ARM, SH maintainers if nobody
else does).

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/f3633257/attachment.sig>
