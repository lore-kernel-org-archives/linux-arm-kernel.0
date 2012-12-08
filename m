From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Dec 2012 12:14:45 +0000
Subject: [PATCH] ARM: Do not use definition "machine_arch_type" outside
 mach-types.h
In-Reply-To: <1354968125-664-1-git-send-email-shc_work@mail.ru>
References: <20121208112353.GD14363@n2100.arm.linux.org.uk>
 <1354968125-664-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121208121444.GE14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 08, 2012 at 04:02:05PM +0400, Alexander Shiyan wrote:
> This patch removes the use of the definition "machine_arch_type"
> outside mach-types.h file. Using variable "__machine_arch_type"
> that passed from the bootloader.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/kernel/machine_kexec.c |    2 +-
>  arch/arm/kernel/setup.c         |    2 +-
>  arch/arm/mach-pxa/em-x270.c     |    2 +-
>  arch/arm/tools/gen-mach-types   |    3 ---
>  4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 8ef8c93..f154d6b 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -145,7 +145,7 @@ void machine_kexec(struct kimage *image)
>  	/* Prepare parameters for reboot_code_buffer*/
>  	kexec_start_address = image->start;
>  	kexec_indirection_page = page_list;
> -	kexec_mach_type = machine_arch_type;
> +	kexec_mach_type = __machine_arch_type;

Pointless.

>  	if (!kexec_boot_atags)
>  		kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 86d1429..95fcaa0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -744,7 +744,7 @@ void __init setup_arch(char **cmdline_p)
>  	setup_processor();
>  	mdesc = setup_machine_fdt(__atags_pointer);
>  	if (!mdesc)
> -		mdesc = setup_machine_tags(__atags_pointer, machine_arch_type);
> +		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);

This is fine.

>  	machine_desc = mdesc;
>  	machine_name = mdesc->name;
>  
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index 1b64114..601ffc21 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -1273,7 +1273,7 @@ static void __init em_x270_init(void)
>  	else if (machine_is_exeda())
>  		em_x270_exeda_init();
>  	else
> -		panic("Unsupported machine: %d\n", machine_arch_type);
> +		panic("Unsupported machine: %d\n", __machine_arch_type);
>  
>  	em_x270_init_da9030();
>  	em_x270_init_dm9000();

Pointless.

> diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
> index 04fef71..4a85086 100644
> --- a/arch/arm/tools/gen-mach-types
> +++ b/arch/arm/tools/gen-mach-types
> @@ -65,8 +65,5 @@ END	{
>  	      printf("#define %s()\t(0)\n", machine_is[i]);
>  	    }
>  
> -	  printf("\n#ifndef machine_arch_type\n");
> -	  printf("#define machine_arch_type\t__machine_arch_type\n");
> -	  printf("#endif\n\n");

This is still wrong.
