From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Jul 2011 21:28:29 -0700
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <4E13E46D.3050205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2011 07:46 PM, Nicolas Pitre wrote:
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 7b79a00..1bdf6e1 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -18,6 +18,7 @@ struct machine_desc {
>  	unsigned int		nr;		/* architecture number	*/
>  	const char		*name;		/* architecture name	*/
>  	unsigned long		boot_params;	/* tagged list		*/
> +	unsigned long		atag_offset;	/* tagged list (relative) */
>  	const char		**dt_compat;	/* array of device tree
>  						 * 'compatible' strings	*/
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e0db84d..4cc3e2b 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -816,6 +816,8 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
>  
>  	if (__atags_pointer)
>  		tags = phys_to_virt(__atags_pointer);
> +	else if(mdesc->atag_offset)
> +		tags = PAGE_OFFSET + mdesc->atag_offset;
>  	else if (mdesc->boot_params) {
>  #ifdef CONFIG_MMU
>  		/*

Would it make sense to drop the atag_offset in most board files and
default it to 0x100 in the MACHINE_START macro itself? It's almost a
universal value and would cut down on hundreds of lines.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
