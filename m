From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 15:57:15 +0100
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110622145715.GS23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 05:46:42PM +0900, Kukjin Kim wrote:
> diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
> index 6b62425..d55d38c 100644
> --- a/arch/arm/mach-exynos4/sleep.S
> +++ b/arch/arm/mach-exynos4/sleep.S
> @@ -45,11 +45,20 @@ ENTRY(s3c_cpu_save)
>  	ldr	r3, =resume_with_mmu
>  	bl	cpu_suspend
>  
> -	ldr	r0, =pm_cpu_sleep
> -	ldr	r0, [ r0 ]
> -	mov	pc, r0
> +	bl	exynos4_cpu_suspend
> +
> +	/* Restore original sp */
> +	mov	r0, sp
> +	add	r0, r0, #4
> +	ldr	sp, [r0]
> +
> +	mov	r0, #0
> +	b	early_wakeup
>  
>  resume_with_mmu:
> +	mov	r0, #1
> +
> +early_wakeup:
>  	ldmfd	sp!, { r3 - r12, pc }

NAK.

If we want to return from cpu_suspend() stuff then we need to solve this
properly, as per my patch sent around 13th June to the hibernate thread.

Stop bodging stuff (like you have for the SCU stuff.) and start _talking_
to people if the code doesn't do what you need it to do.
