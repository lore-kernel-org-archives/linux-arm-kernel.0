From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Oct 2015 19:22:14 +0200
Subject: [PATCH 11/15] arm64: Cleanup VTCR_EL2 computation
In-Reply-To: <1442331684-28818-12-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-12-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151010172214.GJ29128@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 04:41:20PM +0100, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> No functional changes. Group the common bits for VCTR_EL2
> initialisation for better readability. The granule size
> and the entry level are controlled by the page size.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index bdf139e..699554d 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -138,6 +138,9 @@
>   * The magic numbers used for VTTBR_X in this patch can be found in Tables
>   * D4-23 and D4-25 in ARM DDI 0487A.b.
>   */
> +#define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
> +				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_T0SZ_40B)
> +
>  #ifdef CONFIG_ARM64_64K_PAGES
>  /*
>   * Stage2 translation configuration:
> @@ -145,9 +148,8 @@
>   * 64kB pages (TG0 = 1)
>   * 2 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> +#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1 | \
> +				 VTCR_EL2_COMMON_BITS)
>  #define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
>  #else
>  /*
> @@ -156,9 +158,8 @@
>   * 4kB pages (TG0 = 0)
>   * 3 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
> +#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1 | \
> +				 VTCR_EL2_COMMON_BITS)
>  #define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
>  #endif
>  
> -- 
> 1.7.9.5
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
