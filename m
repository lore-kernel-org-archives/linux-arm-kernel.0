From: julien.grall@arm.com (Julien Grall)
Date: Wed, 21 Nov 2018 12:23:31 +0000
Subject: [PATCH 4/4] arm64: KVM: Implement workaround for Cortex-A76
 erratum 1165522
In-Reply-To: <20181105143617.120602-5-marc.zyngier@arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
 <20181105143617.120602-5-marc.zyngier@arm.com>
Message-ID: <06743f45-fd39-787d-0c59-12d28d8245bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 05/11/2018 14:36, Marc Zyngier wrote:
> Early versions of Cortex-A76 can end-up with corrupt TLBs if they
> speculate an AT instruction in during a guest switch while the
> S1/S2 system registers are in an inconsistent state.
> 
> Work around it by:
> - Mandating VHE
> - Make sure that S1 and S2 system registers are consistent before
>    clearing HCR_EL2.TGE, which allows AT to target the EL1 translation
>    regime
> 
> These two things together ensure that we cannot hit this erratum.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   Documentation/arm64/silicon-errata.txt |  1 +
>   arch/arm64/Kconfig                     | 12 ++++++++++++
>   arch/arm64/include/asm/cpucaps.h       |  3 ++-
>   arch/arm64/include/asm/kvm_host.h      |  3 +++
>   arch/arm64/include/asm/kvm_hyp.h       |  6 ++++++
>   arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
>   arch/arm64/kvm/hyp/switch.c            | 14 ++++++++++++++
>   7 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 76ccded8b74c..04f0bc4690c6 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -57,6 +57,7 @@ stable kernels.
>   | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
>   | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
>   | ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
> +| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
>   | ARM            | MMU-500         | #841119,#826419 | N/A                         |
>   |                |                 |                 |                             |
>   | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d7850e064..a68bc6cc2167 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -497,6 +497,18 @@ config ARM64_ERRATUM_1188873
>   
>   	  If unsure, say Y.
>   
> +config ARM64_ERRATUM_1165522
> +	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
> +	default y
> +	help
> +	  This option adds work arounds for ARM Cortex-A76 erratum 1165522
> +
> +	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could end-up with
> +	  corrupted TLBs by speculating an AT instruction during a guest
> +	  context switch.
> +
> +	  If unsure, say Y.

Most of the code in the patch is not guarded by #ifdef ARM64_*. So is there any 
benefits to add a Kconfig for this option?

Cheers,

-- 
Julien Grall
