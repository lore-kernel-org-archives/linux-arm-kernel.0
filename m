From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 13 Jun 2018 01:05:27 +0200
Subject: [PATCH 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <20180612202411.29798-3-nm@ti.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-3-nm@ti.com>
Message-ID: <8fac2f1c-ecc4-1aa1-0620-8ac6e2efdbf1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2018 10:24 PM, Nishanth Menon wrote:
> As recommended by Arm in [1], ACTLR[0] (Enable invalidates of BTB)
> needs to be set[2] for BTB to be invalidated on ICIALLU. This needs to
> be done unconditionally for Cortex-A15 processors. Provide a config
> option for platforms to enable this option based on impact analysis
> for products.
> 
> NOTE: This patch in itself is NOT the final solution, this requires:
> a) Implementation of v7_arch_cp15_set_acr on SoCs which may not
>    provide direct access to ACR register.
> b) Operating Systems such as Linux to provide adequate workaround in the
>    right locations.
> c) This workaround applies to only the boot processor. It is important
>    to apply workaround as necessary (context-save-restore) around low
>    power context loss OR additional processors as necessary in either
>    firmware support OR elsewhere in OS.
> 
> [1] https://developer.arm.com/support/security-update
> [2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438c/BABGHIBG.html
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Andre Przywara <Andre.Przywara@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/Kconfig           | 4 ++++
>  arch/arm/cpu/armv7/start.S | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9e32d5b43cb0..98f58fd27696 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -109,6 +109,7 @@ config SYS_ARM_MPU
>  # CONFIG_ARM_ERRATA_798870
>  # CONFIG_ARM_ERRATA_801819
>  # CONFIG_ARM_CORTEX_A8_CVE_2017_5715
> +# CONFIG_ARM_CORTEX_A15_CVE_2017_5715
>  
>  config ARM_ERRATA_430973
>  	bool
> @@ -182,6 +183,9 @@ config ARM_ERRATA_855873
>  config ARM_CORTEX_A8_CVE_2017_5715
>  	bool
>  
> +config ARM_CORTEX_A15_CVE_2017_5715
> +	bool
> +
>  config CPU_ARM720T
>  	bool
>  	select SYS_CACHE_SHIFT_5
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 3beaf5a93d81..81edec01bf32 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -241,6 +241,14 @@ skip_errata_798870:
>  skip_errata_801819:
>  #endif
>  
> +#ifdef CONFIG_ARM_CORTEX_A15_CVE_2017_5715
> +	mrc	p15, 0, r0, c1, c0, 1	@ read auxilary control register
> +	orr	r0, r0, #1 << 0		@ Enable invalidates of BTB

Can we use BIT() macro in the assembler code too ?

-- 
Best regards,
Marek Vasut
