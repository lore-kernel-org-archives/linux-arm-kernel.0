From: steve.capper@arm.com (Steve Capper)
Date: Tue, 12 Dec 2017 11:53:04 +0000
Subject: [PATCH 01/12] KVM: arm/arm64: vgic: Remove spurious call to
 kern_hyp_va
In-Reply-To: <d8a26134-52e2-0800-542f-603c6e8347c7@arm.com>
References: <20171204141313.31604-1-steve.capper@arm.com>
 <20171204141313.31604-2-steve.capper@arm.com>
 <d8a26134-52e2-0800-542f-603c6e8347c7@arm.com>
Message-ID: <20171212115304.abzvemzihyeasasz@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 02:30:28PM +0000, Suzuki K Poulose wrote:
> On 04/12/17 14:13, Steve Capper wrote:
> > In save_elrsr(.), we use the following technique to ascertain the
> > address of the vgic global state:
> > 	(kern_hyp_va(&kvm_vgic_global_state))->nr_lr
> > 
> > For arm, kern_hyp_va(va) == va, and this call effectively compiles out.
> > 
> > For arm64, this call can be spurious as the address of kvm_vgic_global_state
> > will usually be determined by relative page/absolute page offset relocation
> > at link time. As the function is idempotent, having the call for arm64 does
> > not cause any problems.
> > 
> > Unfortunately, this is about to change for arm64 as we need to change
> > the logic of kern_hyp_va to allow for kernel addresses that are outside
> > the direct linear map.
> > 
> > This patch removes the call to kern_hyp_va, and ensures that correct
> > HYP addresses are computed via relative page offset addressing on arm64.
> > This is achieved by a custom accessor, hyp_address(.), which on arm is a
> > simple reference operator.
> 
> minor nit: I somehow feel that there word "symbol" should be part of the name of
> the macro, to make it implicit that it can only be used on a symbol and not any
> generic variable.
> 
> > diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> > index 08d3bb66c8b7..34a4ae906a97 100644
> > --- a/arch/arm64/include/asm/kvm_hyp.h
> > +++ b/arch/arm64/include/asm/kvm_hyp.h
> > @@ -25,6 +25,16 @@
> >   #define __hyp_text __section(.hyp.text) notrace
> > +#define hyp_address(symbol)				\
> > +({							\
> > +	typeof(&symbol) __ret;				\
> > +	asm volatile(					\
> > +	"adrp %[ptr], " #symbol	"\n"			\
> > +	"add %[ptr], %[ptr], :lo12:" #symbol "\n"	\
> > +	: [ptr] "=r"(__ret));				\
> > +	__ret;						\
> > +})
> > +
> 
> > -	addr  = kern_hyp_va((kern_hyp_va(&kvm_vgic_global_state))->vcpu_base_va);
> > +	addr  = kern_hyp_va(hyp_address(kvm_vgic_global_state)->vcpu_base_va);
> 
> e.g, Like here, why do we use hyp_address only for the kvm_vgic_global_state and not
> the dereferenced value. Having a name, say, hyp_symbol_address() makes it clear.
> 
> Otherwise, looks good to me.
> 

Thanks Suzuki,
Marc Zyngier has a similar patch in his series:
KVM/arm64: Randomise EL2 mappings

I'll refactor my series to apply on top of Marc's
(and take advantage of the simiplified HYP logic)

Cheers,
-- 
Steve
