From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 13:15:58 +0100
Subject: [RESEND PATCH] ARM: kdump: Add vmcore_elf64_check_arch
In-Reply-To: <1399124686-63299-1-git-send-email-sdu.liu@huawei.com>
References: <1399124686-63299-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <20140506121558.GB30234@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 02:44:46PM +0100, Liu Hua wrote:
> Hi Will or Russell,

Hello,

> With CONFIG_LPAE=y, memory in 32-bit ARM systems can exceed
> 4G. So if we use kdump in such systems. The capture kernel
> should parse 64-bit elf header(parse_crash_elf64_headers).
> 
> And this process can not pass because ARM linux only provides
> zero vmcore_elf64_check_arch function by commit 4b3bf7aef.
> 
> This patch adds check functions related to elf64 header.

[...]

> diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
> index d0d1e83..452086a 100644
> --- a/arch/arm/kernel/elf.c
> +++ b/arch/arm/kernel/elf.c
> @@ -38,6 +38,39 @@ int elf_check_arch(const struct elf32_hdr *x)
>  }
>  EXPORT_SYMBOL(elf_check_arch);
>  
> +int elf_check_arch_64(const struct elf64_hdr *x)
> +{
> +	unsigned int eflags;
> +
> +	/* Make sure it's an ARM executable */
> +	if (x->e_machine != EM_ARM)
> +		return 0;
> +
> +	/* Make sure the entry address is reasonable */
> +	if (x->e_entry & 1) {
> +		if (!(elf_hwcap & HWCAP_THUMB))
> +			return 0;
> +	} else if (x->e_entry & 3)
> +		return 0;
> +
> +	eflags = x->e_flags;
> +	if ((eflags & EF_ARM_EABI_MASK) == EF_ARM_EABI_UNKNOWN) {
> +		unsigned int flt_fmt;
> +
> +		/* APCS26 is only allowed if the CPU supports it */
> +		if ((eflags & EF_ARM_APCS_26) && !(elf_hwcap & HWCAP_26BIT))
> +			return 0;
> +
> +		flt_fmt = eflags & (EF_ARM_VFP_FLOAT | EF_ARM_SOFT_FLOAT);
> +
> +		/* VFP requires the supporting code */
> +		if (flt_fmt == EF_ARM_VFP_FLOAT && !(elf_hwcap & HWCAP_VFP))
> +			return 0;
> +	}
> +	return 1;
> +}
> +EXPORT_SYMBOL(elf_check_arch_64);

This function looks identical to elf_check_arch. Why do we need to duplicate
that code? You could use some pre-processor magic to make the core part of
the functions agnostic to header type.

In fact, if elf_check_arch could handle both header types then the generic
definition of vmcore_elf64_check_arch in include/linux/crash_dump.h would
work out of the box.

Will
