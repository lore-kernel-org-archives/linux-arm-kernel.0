From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 6 Jun 2017 22:09:12 +0200
Subject: [PATCH 2/3] arm64: KVM: Allow unaligned accesses at EL2
In-Reply-To: <20170606180835.14421-3-marc.zyngier@arm.com>
References: <20170606180835.14421-1-marc.zyngier@arm.com>
 <20170606180835.14421-3-marc.zyngier@arm.com>
Message-ID: <20170606200912.GQ9464@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 07:08:34PM +0100, Marc Zyngier wrote:
> We currently have the SCTLR_EL2.A bit set, trapping unaligned accesses
> at EL2, but we're not really prepared to deal with it. So far, this
> has been unnoticed, until GCC 7 started emitting those (in particular
> 64bit writes on a 32bit boundary).
> 
> Since the rest of the kernel is pretty happy about that, let's follow
> its example and set SCTLR_EL2.A to zero. Modern CPUs don't really
> care.

Why do we set the A flag via SCTLR_ELx_FLAGS in the first place, only to
drop that flag later on for both EL1 and EL2 ?

> 
> Cc: stable at vger.kernel.org
> Reported-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp-init.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 4072d408a4b4..3f9615582377 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -108,9 +108,10 @@ __do_hyp_init:
>  
>  	/*
>  	 * Preserve all the RES1 bits while setting the default flags,
> -	 * as well as the EE bit on BE.
> +	 * as well as the EE bit on BE. Drop the A flag since the compiler
> +	 * is allowed to generate unaligned accesses.
>  	 */
> -	ldr	x4, =(SCTLR_EL2_RES1 | SCTLR_ELx_FLAGS)
> +	ldr	x4, =(SCTLR_EL2_RES1 | (SCTLR_ELx_FLAGS & ~SCTLR_ELx_A))
>  CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
>  	msr	sctlr_el2, x4
>  	isb
> -- 
> 2.11.0
> 

Otherwise this looks fine to me.

Thanks,
-Christoffer
