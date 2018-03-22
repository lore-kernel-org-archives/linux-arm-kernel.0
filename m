From: jhogan@kernel.org (James Hogan)
Date: Thu, 22 Mar 2018 22:21:08 +0000
Subject: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
Message-ID: <20180322222107.GJ13126@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 03:55:16PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..5ba431c 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -78,11 +78,6 @@ void error(char *x)
>  
>  unsigned long __stack_chk_guard;

...

> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index 409cb48..00d0ee0 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -32,6 +32,10 @@ start:
>  	bne	a2, a0, 1b
>  	 addiu	a0, a0, 4
>  
> +	PTR_LA	a0, __stack_chk_guard
> +	PTR_LI	a1, 0x000a0dff
> +	sw	a1, 0(a0)

Should that not be LONG_S? Otherwise big endian MIPS64 would get a
word-swapped canary (which is probably mostly harmless, but still).

Also I think it worth mentioning in the commit message the MIPS
configuration you hit this with, presumably a Loongson one? For me
decompress_kernel() gets a stack guard on loongson3_defconfig, but not
malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive to
the compiler inlining stuff into decompress_kernel() or something such
that it suddenly qualifies for a stack guard.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/4b424f75/attachment-0001.sig>
