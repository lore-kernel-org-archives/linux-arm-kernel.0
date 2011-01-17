From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Jan 2011 09:56:50 +0000
Subject: [PATCH 1/3] Support BE8 mode kernel modules relocation
In-Reply-To: <1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
	<1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
Message-ID: <AANLkTi=RSpXHRpoZJsGLhVgQ=E=tcNGm8GXYC9UPaDrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2011 08:42, Stanley.Miao <stanley.miao@windriver.com> wrote:
> The code section in BE8 kernel modules is in little-endian while data
> section is in big-endian. When reading code from memory in the relocation
> procedure, these instructions are read according to big-endian, so they
> need to be inverted before writing to memory and after reading from memory.
[...]
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -233,6 +233,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>
> ?#endif /* __mem_pci */
>
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define read_instr32(c) ? ? ? ? ? ? ? ? ? ? ? ?__swab32(*(u32 *)c)
> +#define read_instr16(c) ? ? ? ? ? ? ? ? ? ? ? ?__swab16(*(u16 *)c)
> +#define write_instr32(v,a) ? ? ? ? ? ? (*(u32 *)(a) = __swab32((__force __u32)(v)))
> +#define write_instr16(v,a) ? ? ? ? ? ? (*(u16 *)(a) = __swab16((__force __u16)(v)))
> +#else
> +#define read_instr32(c) ? ? ? ? ? ? ? ? ? ? ? ?(*(u32 *)c)
> +#define read_instr16(c) ? ? ? ? ? ? ? ? ? ? ? ?(*(u16 *)c)
> +#define write_instr32(v,a) ? ? ? ? ? ? (*(u32 *)(a) = (v))
> +#define write_instr16(v,a) ? ? ? ? ? ? (*(u16 *)(a) = (v))
> +#endif

Can we not use cpu_to_le32 etc in here (and as Russell said, they are
not really IO)?

-- 
Catalin
