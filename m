From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Jun 2015 11:07:04 +0100
Subject: [RFC PATCH] arm64: Image: Allow the appending of a device tree
 binary
In-Reply-To: <1433410504-11628-1-git-send-email-yangyingliang@huawei.com>
References: <1433410504-11628-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150604100659.GA10388@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 04, 2015 at 05:35:04PM +0800, Yang Yingliang wrote:
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary Image (e.g. cat Image <filename>.dtb > Image_w_dtb).
> 
> Both BE and LE conditions are tested.
> 
> Got references from e2a6a3aa ("ARM: zImage: Allow the appending of a device tree binary").

Passing the DTB is really the responsibility of the bootloader.
ARM_APPENDED_DTB was a transitional hack to allow non-DT-aware
bootloaders to boot new kernels that require a DT for arch/arm.

For arm64 DT has been required from the start, as mandated in
Documentation/arm64/booting.txt -- there are no "legacy" bootloaders to
support.

Can you explain your rationale for this change?

Cheers
---Dave

> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/arm64/Kconfig              | 11 +++++++++++
>  arch/arm64/kernel/head.S        | 12 ++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S | 17 +++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7796af4..d402448 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -660,6 +660,17 @@ endmenu
>  
>  menu "Boot options"
>  
> +config ARM64_APPENDED_DTB
> +	bool "Use appended device tree blob to Image"
> +	depends on OF
> +	help
> +	  With this option, the boot code will look for a device tree binary
> +	  (DTB) appended to Image
> +	  (e.g. cat Image <filename>.dtb > Image_w_dtb).
> +
> +	  With this option, the size of Image will be extended to be 2MB aligned.
> +	  The 2MB memory followed by Image is used for FDT blob.
> +
>  config CMDLINE
>  	string "Default kernel command string"
>  	default ""
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 19f915e..ac00c8a 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -274,6 +274,18 @@ ENDPROC(preserve_boot_args)
>   * The dtb must be 8-byte aligned and live in the first 512M of memory.
>   */
>  __vet_fdt:
> +#ifdef CONFIG_ARM64_APPENDED_DTB
> +	ldr	x21, =_edata
> +	add	x21, x21, x28
> +	ldr	w0, [x21]
> +#ifndef __AARCH64EB__
> +	ldr	w1, =0xedfe0dd0		// FDT magic word
> +#else
> +	ldr	w1, =0xd00dfeed
> +#endif
> +	cmp	w0, w1
> +	b.ne	1f			// no FDT found
> +#endif
>  	tst	x21, #0x7
>  	b.ne	1f
>  	cmp	x21, x24
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index a2c2986..c71bac3 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -54,6 +54,18 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>  #define PECOFF_EDATA_PADDING
>  #endif
>  
> +/*
> + * Set FDT pointer 2MB aligned to ensure
> + * it don't cross a 2-megabyte boundary.
> + */
> +FDT_FILE_ALIGNMENT = (1 << 21);
> +#ifdef CONFIG_ARM64_APPENDED_DTB
> +#define FDT_EDATA_PADDING	\
> +	.fdt_edata_padding : { BYTE(0); . = ALIGN(FDT_FILE_ALIGNMENT); }
> +#else
> +#define FDT_EDATA_PADDING
> +#endif
> +
>  #ifdef CONFIG_DEBUG_ALIGN_RODATA
>  #define ALIGN_DEBUG_RO			. = ALIGN(1<<SECTION_SHIFT);
>  #define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
> @@ -149,8 +161,13 @@ SECTIONS
>  	_sdata = .;
>  	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
>  	PECOFF_EDATA_PADDING
> +	FDT_EDATA_PADDING	/* 2MB aligned */
>  	_edata = .;
>  
> +#ifdef CONFIG_ARM64_APPENDED_DTB
> +	. += (1 << 21);		/* maximum 2MB for FDT blob */
> +#endif
> +
>  	BSS_SECTION(0, 0, 0)
>  
>  	. = ALIGN(PAGE_SIZE);
> -- 
> 1.8.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
