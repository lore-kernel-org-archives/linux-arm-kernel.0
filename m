From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Nov 2017 16:27:14 -0800
Subject: [PATCH 14/18] arm64: erratum: Work around Falkor erratum #E1003
 in trampoline code
In-Reply-To: <1510942921-12564-15-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <1510942921-12564-15-git-send-email-will.deacon@arm.com>
Message-ID: <20171118002714.GC18379@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Will Deacon wrote:
> We rely on an atomic swizzling of TTBR1 when transitioning from the entry
> trampoline to the kernel proper on an exception. We can't rely on this
> atomicity in the face of Falkor erratum #E1003, so on affected cores we
> can issue a TLB invalidation prior to jumping into the kernel. There is
> still the possibility of a TLB conflict here due to conflicting walk
> cache entries, but this doesn't appear to be the case on these CPUs in
> practice.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Kconfig        | 17 +++++------------
>  arch/arm64/kernel/entry.S |  8 ++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..f0fcbfc2262e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -504,20 +504,13 @@ config CAVIUM_ERRATUM_30115
>  config QCOM_FALKOR_ERRATUM_1003
>  	bool "Falkor E1003: Incorrect translation due to ASID change"
>  	default y
> -	select ARM64_PAN if ARM64_SW_TTBR0_PAN

Cool, this sort of complicates the backport of the Kryo MIDR
update of this errata to stable trees though.

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a839b94bba05..a600879939ce 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -941,6 +941,14 @@ __ni_sys_trace:
>  	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
>  	bic	\tmp, \tmp, #USER_ASID_FLAG
>  	msr	ttbr1_el1, \tmp
> +alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003

Shouldn't we put this inside an #ifdef QCOM_FALKOR_ERRATUM_1003
so that we don't even emit nops in case we have the errata
disabled? Or did I miss something in the alternatives assembly
code?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
