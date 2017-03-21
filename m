From: james.morse@arm.com (James Morse)
Date: Tue, 21 Mar 2017 18:25:46 +0000
Subject: [PATCH v33 07/14] arm64: hibernate: preserve kdump image around
 hibernation
In-Reply-To: <20170315095941.25119-5-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-5-takahiro.akashi@linaro.org>
Message-ID: <58D1702A.2010702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 15/03/17 09:59, AKASHI Takahiro wrote:
> Since arch_kexec_protect_crashkres() removes a mapping for crash dump
> kernel image, the loaded data won't be preserved around hibernation.
> 
> In this patch, helper functions, kexec_prepare_suspend()/
> kexec_post_resume(), are additionally called before/after hibernation so
> that the relevant memory segments will be mapped again and preserved just
> as the others are.
> 
> In addition, to minimize the size of hibernation image,
> kexec_is_chraskres_nosave() is added to pfn_is_nosave() in order to

(crashkres)

> recoginize only the pages that hold loaded crash dump kernel image as

(recognize)

> saveable. Hibernation excludes any pages that are marked as Reserved and
> yet "nosave."


Neat! I didn't think this would be possible without hacking kernel/power/snapshot.c.

I've given this a spin on Juno and Seattle, I even added debug_pagealloc, but
that doesn't trick it because your kexec_prepare_suspend() puts the mapping back.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


Some nits about comments:

> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 97a7384100f3..1e10fafa59bd 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -286,6 +288,9 @@ int swsusp_arch_suspend(void)
>  	local_dbg_save(flags);
>  
>  	if (__cpu_suspend_enter(&state)) {
> +		/* make the crash dump kernel image visible/saveable */
> +		kexec_prepare_suspend();

Strictly this is kdump not kexec, but the comment makes that clear.

> +
>  		sleep_cpu = smp_processor_id();
>  		ret = swsusp_save();
>  	} else {

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 02e4f929db3b..82f48db589cf 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c

> @@ -220,7 +221,6 @@ void arch_kexec_protect_crashkres(void)
>  			kexec_crash_image->segment[i].memsz,
>  			PAGE_KERNEL_INVALID, true);
>  
> -

Stray whitespace change from a previous patch?

>  	flush_tlb_all();
>  }
>  
> @@ -233,3 +233,74 @@ void arch_kexec_unprotect_crashkres(void)

> +/*
> + * kexec_is_crashres_nosave
> + *
> + * Return true only if a page is part of reserved memory for crash dump kernel,
> + * but does not hold any data of loaded kernel image.
> + *
> + * Note that all the pages in crash dump kernel memory have been initially
> + * marked as Reserved in kexec_reserve_crashkres_pages().
> + *
> + * In hibernation, the pages which are Reserved and yet "nosave"
> + * are excluded from the hibernation iamge. kexec_is_crashkres_nosave()
> + * does this check for crash dump kernel and will reduce the total size
> + * of hibernation image.
> + */
> +
> +bool kexec_is_crashkres_nosave(unsigned long pfn)
> +{
> +	int i;
> +	phys_addr_t addr;
> +
> +	/* in reserved memory? */

Comment in the wrong place?


> +	if (!crashk_res.end)
> +		return false;
> +
> +	addr = __pfn_to_phys(pfn);

(makes more sense here)


> +	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> +		return false;
> +

> +	/* not part of loaded kernel image? */

Comment in the wrong place?


> +	if (!kexec_crash_image)
> +		return true;
> +

(makes more sense here)


> +	for (i = 0; i < kexec_crash_image->nr_segments; i++)
> +		if (addr >= kexec_crash_image->segment[i].mem &&
> +				addr < (kexec_crash_image->segment[i].mem +
> +					kexec_crash_image->segment[i].memsz))
> +			return false;
> +
> +	return true;
> +}
> +


Thanks,

James
