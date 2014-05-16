From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 May 2014 17:48:51 +0100
Subject: [PATCH 1/2] ARM: kexec: Make .text R/W in machine_kexec
In-Reply-To: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140516164851.GD1694@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 10:31:56AM +0100, Nikolay Borisov wrote:
> With the introduction of Kees Cook's patch to make the kernel .text read-only the
> existing method by which kexec works got broken since it directly pokes some
> values in the template code, which resides in the .text section.
> 
> The current patch changes the way those values are inserted so that poking .text
> section occurs only in machine_kexec (e.g when we are about to nuke the old
> kernel and are beyond the point of return). This allows to use
> set_kernel_text_rw() to directly patch the values in the .text section.
> 
> I had already sent a patch which achieved this but it was significantly more
> complicated, so this is a cleaner/straight-forward approach.
> 
> Tested on 3.15-rc4
> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 8cf0996..cee44db 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -29,6 +29,7 @@ extern unsigned long kexec_boot_atags;
>  
>  static atomic_t waiting_for_crash_ipi;
>  
> +static unsigned long dt_mem;
>  /*
>   * Provide a dummy crash_notes definition while crash dump arrives to arm.
>   * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
> @@ -64,7 +65,7 @@ int machine_kexec_prepare(struct kimage *image)
>  			return err;
>  
>  		if (be32_to_cpu(header) == OF_DT_HEADER)
> -			kexec_boot_atags = current_segment->mem;
> +			dt_mem = current_segment->mem;
>  	}
>  	return 0;
>  }
> @@ -163,9 +164,11 @@ void machine_kexec(struct kimage *image)
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
>  	/* Prepare parameters for reboot_code_buffer*/
> +	set_kernel_text_rw();
>  	kexec_start_address = image->start;
>  	kexec_indirection_page = page_list;
>  	kexec_mach_type = machine_arch_type;
> +	kexec_boot_atags = dt_mem;
>  	if (!kexec_boot_atags)
>  		kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;

You could collapse this to:

	kexec_boot_atags = dt_mem ?: image->start - KEXEC_ARM_ZIMAGE_OFFSET
				     + KEXEC_ARM_ATAGS_OFFSET;

Other than that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
