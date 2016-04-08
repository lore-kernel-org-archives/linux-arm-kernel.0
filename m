From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 17:13:22 +0200
Subject: [PATCH 17/17] arm64: kvm: Add support for 16K pages
In-Reply-To: <1459787177-12767-18-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-18-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408151322.GA8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:17PM +0100, Suzuki K Poulose wrote:
> Now that we can handle stage-2 page tables independent
> of the host page table levels, wire up the 16K page
> support.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |   11 ++++++++++-
>  arch/arm64/kvm/Kconfig           |    1 -
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index d5d5fdf..3d830a3 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -114,6 +114,7 @@
>  #define VTCR_EL2_PS_MASK	TCR_EL2_PS_MASK
>  #define VTCR_EL2_TG0_MASK	TCR_TG0_MASK
>  #define VTCR_EL2_TG0_4K		TCR_TG0_4K
> +#define VTCR_EL2_TG0_16K	TCR_TG0_16K
>  #define VTCR_EL2_TG0_64K	TCR_TG0_64K
>  #define VTCR_EL2_SH0_MASK	TCR_SH0_MASK
>  #define VTCR_EL2_SH0_INNER	TCR_SH0_INNER
> @@ -139,7 +140,7 @@
>   * (see hyp-init.S).
>   *
>   * Note that when using 4K pages, we concatenate two first level page tables
> - * together.
> + * together. With 16K pages, we concatenate 16 first level page tables.
>   *
>   * The magic numbers used for VTTBR_X in this patch can be found in Tables
>   * D4-23 and D4-25 in ARM DDI 0487A.b.
> @@ -156,6 +157,14 @@
>   */
>  #define VTCR_EL2_TGRAN_FLAGS	(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
>  #define VTTBR_X_TGRAN_MAGIC		38
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +/*
> + * Stage2 translation configuration:
> + * 16kB pages (TG0 = 2)
> + * 2 level page tables (SL = 1)
> + */
> +#define VTCR_EL2_TGRAN_FLAGS	(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
> +#define VTTBR_X_TGRAN_MAGIC	42
>  #else
>  /*
>   * Stage2 translation configuration:
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index de7450d..aa2e34e 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -22,7 +22,6 @@ config KVM_ARM_VGIC_V3
>  config KVM
>  	bool "Kernel-based Virtual Machine (KVM) support"
>  	depends on OF
> -	depends on !ARM64_16K_PAGES
>  	select MMU_NOTIFIER
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
> -- 
> 1.7.9.5
> 

Looks so easy now :)

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
