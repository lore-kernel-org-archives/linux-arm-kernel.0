From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Aug 2017 14:31:54 +0100
Subject: [PATCH 6/6] arm64: Remove the CONFIG_ARM64_HW_AFDBM option
In-Reply-To: <20170725135308.18173-7-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-7-catalin.marinas@arm.com>
Message-ID: <20170817133154.GB29194@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:53:08PM +0100, Catalin Marinas wrote:
> Since the pte handling for hardware AF/DBM works even when the hardware
> feature is not present, make the implementation permanent and remove the
> Kconfig option.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig               | 17 -----------------
>  arch/arm64/include/asm/pgtable.h |  9 +--------
>  arch/arm64/kvm/hyp/s2-setup.c    |  2 +-
>  arch/arm64/mm/fault.c            |  2 --
>  arch/arm64/mm/proc.S             |  3 +--
>  5 files changed, 3 insertions(+), 30 deletions(-)

Largely in favour of this, but I'd prefer to keep the option so that
we can build kernels where the enabling:

> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 877d42fb0df6..ba82f8bf3cf1 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -234,7 +234,7 @@ ENTRY(__cpu_setup)
>  	 */
>  	mrs	x9, ID_AA64MMFR0_EL1
>  	bfi	x10, x9, #32, #3
> -#ifdef CONFIG_ARM64_HW_AFDBM
> +
>  	/*
>  	 * Hardware update of the Access and Dirty bits.
>  	 */
> @@ -246,7 +246,6 @@ ENTRY(__cpu_setup)
>  	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
>  1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
>  2:
> -#endif	/* CONFIG_ARM64_HW_AFDBM */
>  	msr	tcr_el1, x10
>  	ret					// return to head.S
>  ENDPROC(__cpu_setup)

is still configurable. That might help for debugging suspected races in
this area.

Will
