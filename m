From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Oct 2012 10:45:27 +0800
Subject: [PATCH v2 3/5] ARM: use generic unaligned.h
In-Reply-To: <50738B93.6090704@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
 <1344129840-16447-4-git-send-email-robherring2@gmail.com>
 <20121008164353.GB6140@S2101-09.ap.freescale.net>
 <507338F1.7030604@gmail.com>
 <20121008232853.GA21822@S2101-09.ap.freescale.net>
 <50738B93.6090704@gmail.com>
Message-ID: <20121009024524.GB21822@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 09:27:31PM -0500, Rob Herring wrote:
> I must have had an old config with XZ. LZO fails because of this:
>  
> lib/decompress_unlzo.c: version = get_unaligned_be16(parse);
> lib/decompress_unlzo.c: if (get_unaligned_be32(parse) & HEADER_HAS_FILTER)
> lib/decompress_unlzo.c:         dst_len = get_unaligned_be32(in_buf);
> lib/decompress_unlzo.c:         src_len = get_unaligned_be32(in_buf);
> 
> This was what I was afraid of. The decompressor runs with the sysctrl
> register A bit in whatever state the bootloader left it in. In the case
> of u-boot it is set, and the maintainers are pretty set on not allowing
> unaligned accesses if you've seen the recent discussion.
> 
> This should fix things.
> 
> Rob
> 
> 8<---------------------------------------------------------------------
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index bc67cbf..1f87d22 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -654,6 +654,7 @@ __armv7_mmu_cache_on:
>  #endif
>                 mrc     p15, 0, r0, c1, c0, 0   @ read control reg
>                 bic     r0, r0, #1 << 28        @ clear SCTLR.TRE
> +               bic     r0, r0, #1 << 1         @ clear SCTLR.A
>                 orr     r0, r0, #0x5000         @ I-cache enable, RR cache replacement
>                 orr     r0, r0, #0x003c         @ write buffer
>  #ifdef CONFIG_MMU

Tested-by: Shawn Guo <shawn.guo@linaro.org>
