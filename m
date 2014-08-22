From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Aug 2014 11:23:15 +0100
Subject: [PATCH V2] ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU
In-Reply-To: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
References: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <20140822102315.GQ21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranav,

On Thu, Jul 31, 2014 at 07:53:23AM +0100, Pranavkumar Sawargaonkar wrote:
> X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
> have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.

Nit: entries

> This can happen on any ARM/ARM64 board running bootloader in
> Hyp-mode (or EL2-mode) with MMU enabled.
> 
> This patch ensures that we flush all Hyp-mode (or EL2-mode) TLBs
> on each host CPU before enabling Hyp-mode (or EL2-mode) MMU.

I hit a similar issue intermittently on a Juno board when I boot Linux
as an EFI application, where CPU0 would get stuck in a recursive
exception at EL2 while initialising hyp. We don't nuke the TLBs in
efi_stub_entry nor do we do so in el2_setup, so there's the possibility
of stale EL2 TLB entries lying around from UEFI.

With this patch applied I'm unable to reproduce the issue (with ~30
boots so far). So:

Tested-by: Mark Rutland <mark.rutland@arm.com>

It would be nice to see this hit mainline soon.

Thanks,
Mark.

> 
> Changelog:
> 
> V2:
>  - Flush Hyp-mode TLBs for both KVM ARM32 and KVM ARM64 at boot time
> 
> V1:
>  - Initial patch with only arm64 change
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> ---
>  arch/arm/kvm/init.S       |    4 ++++
>  arch/arm64/kvm/hyp-init.S |    4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 1b9844d..ee4f744 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -98,6 +98,10 @@ __do_hyp_init:
>  	mrc	p15, 0, r0, c10, c2, 1
>  	mcr	p15, 4, r0, c10, c2, 1
>  
> +	@ Invalidate the stale TLBs from Bootloader
> +	mcr	p15, 4, r0, c8, c7, 0	@ TLBIALLH
> +	dsb	ish
> +
>  	@ Set the HSCTLR to:
>  	@  - ARM/THUMB exceptions: Kernel config (Thumb-2 kernel)
>  	@  - Endianness: Kernel config
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index d968796..c319116 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -80,6 +80,10 @@ __do_hyp_init:
>  	msr	mair_el2, x4
>  	isb
>  
> +	/* Invalidate the stale TLBs from Bootloader */
> +	tlbi	alle2
> +	dsb	sy
> +
>  	mrs	x4, sctlr_el2
>  	and	x4, x4, #SCTLR_EL2_EE	// preserve endianness of EL2
>  	ldr	x5, =SCTLR_EL2_FLAGS
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
