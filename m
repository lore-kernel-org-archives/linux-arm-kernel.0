From: horms@verge.net.au (Simon Horman)
Date: Wed, 11 Dec 2013 09:41:11 +0900
Subject: [PATCH] ARM: rcar-gen2: Do not setup timer in non-secure mode
In-Reply-To: <1386690813-15070-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1386690813-15070-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131211004111.GB19992@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 03:53:33PM +0000, Ben Dooks wrote:
> If the system has been started in non-secure mode, then the ARM generic
> timer is not configurable during the kernel initialisation. Currently
> the only thing we can check for is if the timer has been correctly
> configured during the boot process.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>

Magnus, could you please review this?

> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index 5734c24..6b7b7f1 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -78,12 +78,20 @@ void __init rcar_gen2_timer_init(void)
>  	/* Remap "armgcnt address map" space */
>  	base = ioremap(0xe6080000, PAGE_SIZE);
>  
> -	/* Update registers with correct frequency */
> -	iowrite32(freq, base + CNTFID0);
> -	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
> +	/* Update the timer if it is either not running, or is not at the
> +	 * right frequency. The timer is only configurable in secure mode
> +	 * so this avoids an abort if the loader started the timer and
> +	 * started the kernel in non-secure mode. */
> +	if ((ioread32(base + CNTCR) & 1) == 0 ||
> +	    ioread32(base + CNTFID0) != freq) {
> +		/* Update registers with correct frequency */
> +		iowrite32(freq, base + CNTFID0);
> +		asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
> +
> +		/* make sure arch timer is started by setting bit 0 of CNTCR */
> +		iowrite32(1, base + CNTCR);
> +	}
>  
> -	/* make sure arch timer is started by setting bit 0 of CNTCR */
> -	iowrite32(1, base + CNTCR);
>  	iounmap(base);
>  #endif /* CONFIG_ARM_ARCH_TIMER */
>  
> -- 
> 1.8.5.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
