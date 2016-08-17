From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 17:16:09 +0100
Subject: [PATCH] arm64: kernel: avoid literal load of virtual address
 with MMU off
In-Reply-To: <1471449281-10367-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471449281-10367-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160817161609.GD14898@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 05:54:41PM +0200, Ard Biesheuvel wrote:
> Literal loads of virtual addresses are subject to runtime relocation when
> CONFIG_RELOCATABLE=y, and given that the relocation routines run with the
> MMU and caches enabled, literal loads of relocated values performed with
> the MMU off are not guaranteed to return the latest value unless the
> memory covering the literal is cleaned to the PoC explicitly.
> 
> So defer the literal load until after the MMU has been enabled, just like
> we do for primary_switch() and secondary_switch() in head.S.
> 
> Fixes: 1e48ef7fcc37 ("arm64: add support for building vmlinux as a relocatable PIE binary")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This looks like the simplest way to handle this, and is consistent with
what we do elsewhere, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

>From grepping, this seems to be the only case of a relocated literal
being loaded while the MMU is off under arch/arm64/.

Thanks,
Mark.

> ---
> 
> This conflicts with the x25/x26 patch I sent yesterday, but this should
> probably go into stable, so I based it on v4.8-rc directly.
> 
>  arch/arm64/kernel/sleep.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 9a3aec97ac09..ccf79d849e0a 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -101,12 +101,20 @@ ENTRY(cpu_resume)
>  	bl	el2_setup		// if in EL2 drop to EL1 cleanly
>  	/* enable the MMU early - so we can access sleep_save_stash by va */
>  	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
> -	ldr	x27, =_cpu_resume	/* __enable_mmu will branch here */
> +	adr_l	x27, _resume_switched	/* __enable_mmu will branch here */
>  	adrp	x25, idmap_pg_dir
>  	adrp	x26, swapper_pg_dir
>  	b	__cpu_setup
>  ENDPROC(cpu_resume)
>  
> +	.pushsection	".idmap.text", "ax"
> +_resume_switched:
> +	ldr	x8, =_cpu_resume
> +	br	x8
> +ENDPROC(_resume_switched)
> +	.ltorg
> +	.popsection
> +
>  ENTRY(_cpu_resume)
>  	mrs	x1, mpidr_el1
>  	adrp	x8, mpidr_hash
> -- 
> 2.7.4
> 
