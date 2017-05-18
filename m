From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 May 2017 11:39:01 +0100
Subject: [PATCH] arm64: cpufeature: check translation granule size based
 on kernel config
In-Reply-To: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
References: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
Message-ID: <c0c8bd7b-647d-092d-65ac-08a90000e30c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/17 11:21, Leo Yan wrote:
> In the big.LITTLE system with two clusters, one is CA53 cluster and
> another is CA73 cluster. CA53 doesn't support 16KB memory translation
> granule size (4.3.21 AArch64 Memory Model Feature Register 0, EL1; ARM
> DDI 0500F), but CA73 supports this feature (4.3.27 AArch64 Memory Model
> Feature Register 0, EL1; ARM 100048_0002_04_en). As result, the kernel
> reports log for "Unexpected variation" as below.
>
> [    0.182113] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122

>
> This patch is to change the checking CPU feature for memory translation
> granule size based on kernel configuration. If kernel configuration has
> selected to use one specific memory translation granule size, then we
> will do strict sanity checking cross all CPUs. Otherwise we can skip to
> check unused features for memory translation granule size if kernel
> doesn't use it.
>

If we were to suppress the warning (more on that below), we could simply
make this feature a NON_STRICT, since the unsupported CPUs won't boot
with 16K to hit this sanity check.

However, there is a problem with disabling this warning. If a VM starts
using 16KB page size on a 4K/64K host, the VM could end up in unknown
failures when it switches to an unsupported CPU (after it has booted).
Of course the real fix lies in making the KVM exposing the safe value
for granule support to the VCPUs (which is currently being worked on by
Douglas in Cc). So, when we have that ready, we could make it NON_STRICT
instead of this approach.

Suzuki


> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 94b8f7f..938ddac 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -117,9 +117,21 @@
>  };
>
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
> +#ifdef CONFIG_ARM64_4K_PAGES
>  	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
> +#else
> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
> +#endif
> +#ifdef CONFIG_AARM64_64K_PAGES
>  	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
> +#else
> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
> +#endif
> +#ifdef CONFIG_AARM64_16K_PAGES
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
> +#else
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
> +#endif
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
>  	/* Linux shouldn't care about secure memory */
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
>
