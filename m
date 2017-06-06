From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 6 Jun 2017 22:09:45 +0200
Subject: [PATCH 3/3] arm: KVM: Allow unaligned accesses at HYP
In-Reply-To: <20170606180835.14421-4-marc.zyngier@arm.com>
References: <20170606180835.14421-1-marc.zyngier@arm.com>
 <20170606180835.14421-4-marc.zyngier@arm.com>
Message-ID: <20170606200945.GR9464@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 07:08:35PM +0100, Marc Zyngier wrote:
> We currently have the HSCTLR.A bit set, trapping unaligned accesses
> at HYP, but we're not really prepared to deal with it.
> 
> Since the rest of the kernel is pretty happy about that, let's follow
> its example and set HSCTLR.A to zero. Modern CPUs don't really care.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm/kvm/init.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 570ed4a9c261..5386528665b5 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -104,7 +104,6 @@ __do_hyp_init:
>  	@  - Write permission implies XN: disabled
>  	@  - Instruction cache: enabled
>  	@  - Data/Unified cache: enabled
> -	@  - Memory alignment checks: enabled
>  	@  - MMU: enabled (this code must be run from an identity mapping)
>  	mrc	p15, 4, r0, c1, c0, 0	@ HSCR
>  	ldr	r2, =HSCTLR_MASK
> @@ -112,8 +111,8 @@ __do_hyp_init:
>  	mrc	p15, 0, r1, c1, c0, 0	@ SCTLR
>  	ldr	r2, =(HSCTLR_EE | HSCTLR_FI | HSCTLR_I | HSCTLR_C)
>  	and	r1, r1, r2
> - ARM(	ldr	r2, =(HSCTLR_M | HSCTLR_A)			)
> - THUMB(	ldr	r2, =(HSCTLR_M | HSCTLR_A | HSCTLR_TE)		)
> + ARM(	ldr	r2, =(HSCTLR_M)					)
> + THUMB(	ldr	r2, =(HSCTLR_M | HSCTLR_TE)			)
>  	orr	r1, r1, r2
>  	orr	r0, r0, r1
>  	mcr	p15, 4, r0, c1, c0, 0	@ HSCR
> -- 
> 2.11.0
> 
