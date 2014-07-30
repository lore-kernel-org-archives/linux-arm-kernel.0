From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Jul 2014 12:00:49 +0100
Subject: [PATCH] ARM64: KVM: Nuke EL2 mode tlbs before enabling MMU for EL2
In-Reply-To: <1406713607-27150-1-git-send-email-pranavkumar@linaro.org>
 (Pranavkumar Sawargaonkar's message of "Wed, 30 Jul 2014 10:46:47
 +0100")
References: <1406713607-27150-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <87k36vjela.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranav,

On Wed, Jul 30 2014 at 10:46:47 am BST, Pranavkumar Sawargaonkar <pranavkumar@linaro.org> wrote:
> X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
> have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.
>
> This can happen on any ARM64 board running bootloader in EL2
> with MMU enabled.
>
> This patch ensures that we flush all EL2 TLBs on each host CPU
> before enabling EL2 MMU. This is very similar to what we do
> for EL1 TLBs before enabling EL1 MMU.
> (Refer __cpu_setup() of arch/arm64/mm/proc.S)
>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> ---
>  arch/arm64/kvm/hyp-init.S |    4 ++++
>  1 file changed, 4 insertions(+)
>
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

This looks like a valid fix. But I wonder if it wouldn't be better
located in kernel/head.S::el2_setup?

Also, the 32bit code seems to suffer from the same issue. Care to fix it
as well?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
