From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:52:35 +0100
Subject: [PATCH v7 12/16] KVM: arm64: Save host SVE context as appropriate
In-Reply-To: <1525882385-29181-13-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-13-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510165235.ctqttfheu7nfcrlf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:13:01PM +0100, Dave P Martin wrote:
> This patch adds SVE context saving to the hyp FPSIMD context switch
> path.  This means that it is no longer necessary to save the host
> SVE state in advance of entering the guest, when in use.
> 
> In order to avoid adding pointless complexity to the code, VHE is
> assumed if SVE is in use.  VHE is an architectural prerequisite for
> SVE, so there is no good reason to turn CONFIG_ARM64_VHE off in
> kernels that support both SVE and KVM.
> 
> Historically, software models exist that can expose the
> architecturally invalid configuration of SVE without VHE, so if
> this situation is detected at kvm_init() time then KVM will be
> disabled.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/Kconfig          |  7 +++++++
>  arch/arm64/kvm/fpsimd.c     |  1 -
>  arch/arm64/kvm/hyp/switch.c | 20 +++++++++++++++++++-
>  virt/kvm/arm/arm.c          | 18 ++++++++++++++++++
>  4 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf49..b0d3820 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1130,6 +1130,7 @@ endmenu
>  config ARM64_SVE
>  	bool "ARM Scalable Vector Extension support"
>  	default y
> +	depends on !KVM || ARM64_VHE
>  	help
>  	  The Scalable Vector Extension (SVE) is an extension to the AArch64
>  	  execution state which complements and extends the SIMD functionality
> @@ -1155,6 +1156,12 @@ config ARM64_SVE
>  	  booting the kernel.  If unsure and you are not observing these
>  	  symptoms, you should assume that it is safe to say Y.
>  
> +	  CPUs that support SVE are architecturally required to support the
> +	  Virtualization Host Extensions (VHE), so the kernel makes no
> +	  provision for supporting SVE alongside KVM without VHE enabled.
> +	  Thus, you will need to enable CONFIG_ARM64_VHE if you want to support
> +	  KVM in the same kernel image.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
