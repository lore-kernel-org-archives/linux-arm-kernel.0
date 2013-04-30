From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 30 Apr 2013 13:56:02 -0700
Subject: [PATCH v3 -next 3/5] arm: Add support for LZ4-compressed kernel
In-Reply-To: <1362484056-9778-4-git-send-email-kyungsik.lee@lge.com>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-4-git-send-email-kyungsik.lee@lge.com>
Message-ID: <20130430135602.2aa0d3b4ec392bf83a9b64d0@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  5 Mar 2013 20:47:34 +0900 Kyungsik Lee <kyungsik.lee@lge.com> wrote:

> This patch integrates the LZ4 decompression code to the arm pre-boot code.
> And it depends on two patchs below
> 
> lib: Add support for LZ4-compressed kernel
> decompressor: Add LZ4 decompressor module
> 
> ...
>
> - Apply CFLAGS, -Os to decompress.o to improve decompress
>   performance during boot-up process
>
> ...
>
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,9 @@ endif
>  AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
>  HEAD	= head.o
>  OBJS	+= misc.o decompress.o
> +ifeq ($(CONFIG_KERNEL_LZ4),y)
> +CFLAGS_decompress.o := -Os
> +endif

Surprised.  You found that -Os produces faster code than -O2?  Details,
please?
