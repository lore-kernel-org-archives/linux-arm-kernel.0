From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 3 Feb 2011 09:32:32 +0200
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20110203073232.GA2708@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few questions, see below.

On Wed, Feb 02, 2011 at 03:43:29PM +0100, Per Fransson wrote:
> When restarting using the kernel kexec functionality the MMU
> needs to be turned off. Any code which does this needs to use
> identity mapped addresses to get reliable results. In the ARM
> kexec case this identity mapping is done:

[...]

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..762bb43 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -61,6 +61,10 @@ ENDPROC(cpu_v7_proc_fin)
>   */
>  	.align	5
>  ENTRY(cpu_v7_reset)
> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses

How the above is going to work if PHYS_OFFSET is something else than zero? Also
does this work with Thumb-2 kernels?

> +	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
> +	bic	ip, ip, #0x0001			@ ...............m
> +	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
>  	mov	pc, r0
>  ENDPROC(cpu_v7_reset)
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 03e8e8d..6a1345b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -106,7 +106,11 @@ struct kimage {
>  #endif
>  };
>  
> -
> +struct kexec_mmu_ent {
> +	pgd_t *ptr;
> +	pgd_t store;
> +};
> +extern struct kexec_mmu_ent kexec_mmu_ents[4];
>  
>  /* kexec interface functions */
>  extern void machine_kexec(struct kimage *image);

Is it good idea to place these in a generic header as they are only used in ARM?

Thanks,
MW
