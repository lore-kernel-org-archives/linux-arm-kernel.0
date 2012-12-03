From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Dec 2012 11:05:37 +0000
Subject: [PATCH v4 09/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <CANM98qKSnt8dmjs9f5ufLPBYAvaSunzKsDTMfi2hm6nLjgjLqg@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154313.2836.2851.stgit@chazy-air>
 <20121119150105.GB3205@mudshark.cambridge.arm.com>
 <CANM98qKSnt8dmjs9f5ufLPBYAvaSunzKsDTMfi2hm6nLjgjLqg@mail.gmail.com>
Message-ID: <20121203110537.GD18579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 08:22:28PM +0000, Christoffer Dall wrote:
> On Mon, Nov 19, 2012 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Nov 10, 2012 at 03:43:13PM +0000, Christoffer Dall wrote:
> > This should probably be 0xff and also use the macros that Lorenzo is
> > introducing:
> >
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132977.html
> >
> 
> in the A15 TRM bits [7:2] are reserved, so we really only do care
> about bits [1:0], and this file is A15 specific, but if you prefer, I
> can merge this:

The upper bits are RAZ, so yes, please do merge something like this.

> diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
> index 55cb4a3..685063a 100644
> --- a/arch/arm/kvm/coproc_a15.c
> +++ b/arch/arm/kvm/coproc_a15.c
> @@ -24,8 +24,6 @@
>  #include <asm/kvm_coproc.h>
>  #include <linux/init.h>
> 
> -#define MPIDR_CPUID    0x3
> -
>  static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
>  {
>  	/*
> @@ -35,8 +33,8 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const
> struct coproc_reg *r)
>  	 * revealing the underlying hardware properties is likely to
>  	 * be the best choice).
>  	 */
> -	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_CPUID)
> -		| (vcpu->vcpu_id & MPIDR_CPUID);
> +	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_LEVEL_MASK)
> +		| (vcpu->vcpu_id & MPIDR_LEVEL_MASK);
>  }
> 
>  #include "coproc.h"

Will
