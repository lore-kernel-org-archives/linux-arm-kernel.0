From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 13:20:59 +0100
Subject: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
In-Reply-To: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
Message-ID: <20110919122059.GQ16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index e59bbd4..f60fc90 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -32,6 +32,21 @@ static atomic_t waiting_for_crash_ipi;
>  
>  int machine_kexec_prepare(struct kimage *image)
>  {
> +	unsigned long page_list;
> +	void *reboot_code_buffer;
> +	page_list = image->head & PAGE_MASK;
> +
> +	reboot_code_buffer = page_address(image->control_code_page);
> +
> +	/* Prepare parameters for reboot_code_buffer*/
> +	kexec_start_address = image->start;
> +	kexec_indirection_page = page_list;
> +	kexec_mach_type = machine_arch_type;
> +	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
> +
> +	/* copy our kernel relocation code to the control code page */
> +	memcpy(reboot_code_buffer,
> +	       relocate_new_kernel, relocate_new_kernel_size);
>  	return 0;
>  }
>  
> @@ -82,29 +97,14 @@ void (*kexec_reinit)(void);
>  
>  void machine_kexec(struct kimage *image)
>  {
> -	unsigned long page_list;
>  	unsigned long reboot_code_buffer_phys;
>  	void *reboot_code_buffer;
>  
> -
> -	page_list = image->head & PAGE_MASK;
> -
>  	/* we need both effective and real address here */
>  	reboot_code_buffer_phys =
>  	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
> -	/* Prepare parameters for reboot_code_buffer*/
> -	kexec_start_address = image->start;
> -	kexec_indirection_page = page_list;
> -	kexec_mach_type = machine_arch_type;
> -	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
> -
> -	/* copy our kernel relocation code to the control code page */
> -	memcpy(reboot_code_buffer,
> -	       relocate_new_kernel, relocate_new_kernel_size);
> -
> -
>  	flush_icache_range((unsigned long) reboot_code_buffer,
>  			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);

You should keep this flush with the memcpy - the two are intimately
related - the flush is to ensure I/D cache coherency for the code
which was copied into the page.  Splitting them into two different
functions is asking for future bugs.
