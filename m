From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Aug 2014 14:30:55 +0100
Subject: [PATCH 8/8] ARM: mm: allow text and rodata sections to be
 read-only
In-Reply-To: <1407423713-4160-9-git-send-email-keescook@chromium.org>
References: <1407423713-4160-1-git-send-email-keescook@chromium.org>
 <1407423713-4160-9-git-send-email-keescook@chromium.org>
Message-ID: <20140811133055.GA15853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 04:01:53PM +0100, Kees Cook wrote:
> This introduces CONFIG_DEBUG_RODATA, making kernel text and rodata
> read-only. Additionally, this splits rodata from text so that rodata can
> also be NX, which may lead to wasted memory when aligning to SECTION_SIZE.
> The read-only areas are made writable during ftrace updates and kexec.

[...]

> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 1ac184f2bdd8..4423a565ef6f 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -164,11 +164,11 @@ void machine_kexec(struct kimage *image)
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
>  	/* Prepare parameters for reboot_code_buffer*/
> +	set_kernel_text_rw();
>  	kexec_start_address = image->start;
>  	kexec_indirection_page = page_list;
>  	kexec_mach_type = machine_arch_type;
> -	kexec_boot_atags = dt_mem ?: image->start
> -				     - KEXEC_ARM_ZIMAGE_OFFSET
> +	kexec_boot_atags = dt_mem ?: image->start - KEXEC_ARM_ZIMAGE_OFFSET
>  				     + KEXEC_ARM_ATAGS_OFFSET;

Minor nit: but this patch and the kexec patch earlier in the series seem to
move this line around in different ways without actually changing the code.
I guess you just got a screwy rebase?

Will
