From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Oct 2012 19:17:42 +0100
Subject: [PATCH] ARM: kexec: fix segment memory addresses check
In-Reply-To: <1350410244-12240-1-git-send-email-aaro.koskinen@iki.fi>
References: <1350410244-12240-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20121016181742.GO23979@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 06:57:24PM +0100, Aaro Koskinen wrote:
> Commit c564df4db85aac8d1d65a56176a0a25f46138064 (ARM: 7540/1: kexec:
> Check segment memory addresses) added a safety check with accidentally
> reversed condition, and broke kexec functionality on ARM. Fix this.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/kernel/machine_kexec.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index e29c333..8ef8c93 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -45,10 +45,9 @@ int machine_kexec_prepare(struct kimage *image)
>  	for (i = 0; i < image->nr_segments; i++) {
>  		current_segment = &image->segment[i];
>  
> -		err = memblock_is_region_memory(current_segment->mem,
> -						current_segment->memsz);
> -		if (err)
> -			return - EINVAL;
> +		if (!memblock_is_region_memory(current_segment->mem,
> +					       current_segment->memsz))
> +			return -EINVAL;
>  
>  		err = get_user(header, (__be32*)current_segment->buf);
>  		if (err)
> -- 
> 1.7.2.5

Thanks for this Aaro:

  Acked-by: Will Deacon <will.deacon@arm.com>

Please stick it in the patch system.

Will
