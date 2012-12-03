From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Dec 2012 12:55:05 -0600
Subject: [PATCH 2/3] ARM: nommu: prevent generation of kernel unaligned
 memory accesses
In-Reply-To: <1354557403-20386-2-git-send-email-will.deacon@arm.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
 <1354557403-20386-2-git-send-email-will.deacon@arm.com>
Message-ID: <50BCF589.4010509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 11:56 AM, Will Deacon wrote:
> Recent ARMv7 toolchains assume that unaligned memory accesses will not
> fault and will instead be handled by the processor.
> 
> For the nommu case (without an MPU), memory will be treated as
> strongly-ordered and therefore unaligned accesses may fault regardless
> of the SCTLR.A setting.
> 
> This patch passes -mno-unaligned-access to GCC when compiling for nommu
> targets, preventing the generation of unaligned memory access in the
> kernel.

BTW, this option will not fully prevent unaligned accesses. This code
will still generate unaligned accesses:

void func(void)
{
	char array[] = { 1, 2, 3 };
}

u-boot has been fixing these up by making the arrays static.

Rob

> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 5f914fc..03363e2 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -32,6 +32,7 @@ KBUILD_DEFCONFIG := versatile_defconfig
>  # defines filename extension depending memory management type.
>  ifeq ($(CONFIG_MMU),)
>  MMUEXT		:= -nommu
> +KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
>  endif
>  
>  ifeq ($(CONFIG_FRAME_POINTER),y)
> 
