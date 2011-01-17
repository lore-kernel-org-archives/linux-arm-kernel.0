From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 08:52:31 +0000
Subject: [PATCH 1/3] Support BE8 mode kernel modules relocation
In-Reply-To: <1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
	<1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
Message-ID: <20110117085231.GB17036@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 04:42:07PM +0800, Stanley.Miao wrote:
> The code section in BE8 kernel modules is in little-endian while data
> section is in big-endian. When reading code from memory in the relocation
> procedure, these instructions are read according to big-endian, so they
> need to be inverted before writing to memory and after reading from memory.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/Makefile         |    1 +
>  arch/arm/include/asm/io.h |   12 ++++++++++
>  arch/arm/kernel/module.c  |   51 ++++++++++++++++++++++++--------------------
>  3 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 3eec793..03e7761 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -13,6 +13,7 @@
>  LDFLAGS_vmlinux	:=-p --no-undefined -X
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux	+= --be8
> +LDFLAGS_MODULE	+= --be8
>  endif
>  
>  OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 815efa2..2f088c5 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -233,6 +233,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  
>  #endif	/* __mem_pci */
>  
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define read_instr32(c)			__swab32(*(u32 *)c)
> +#define read_instr16(c)			__swab16(*(u16 *)c)
> +#define write_instr32(v,a)		(*(u32 *)(a) = __swab32((__force __u32)(v)))
> +#define write_instr16(v,a)		(*(u16 *)(a) = __swab16((__force __u16)(v)))
> +#else
> +#define read_instr32(c)			(*(u32 *)c)
> +#define read_instr16(c)			(*(u16 *)c)
> +#define write_instr32(v,a)		(*(u32 *)(a) = (v))
> +#define write_instr16(v,a)		(*(u16 *)(a) = (v))
> +#endif
> +

It makes no sense to put these in asm/io.h
