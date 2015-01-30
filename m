From: geoff@infradead.org (Geoff Levand)
Date: Fri, 30 Jan 2015 15:31:21 -0800
Subject: [PATCH 2/8] arm64: Convert hcalls to use ISS field
In-Reply-To: <20150126182621.GH14048@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <20150126182621.GH14048@e104818-lin.cambridge.arm.com>
Message-ID: <1422660681.21823.38.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-26 at 18:26 +0000, Catalin Marinas wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > To allow for additional hcalls to be defined and to make the arm64 hcall API
> > more consistent across exception vector routines, change the hcall implementations
> > to use the ISS field of the ESR_EL2 register to specify the hcall type.
> > 
> > The existing arm64 hcall implementations are limited in that they only allow
> > for two distinct hcalls; with the x0 register either zero, or not zero.  Also,
> > the API of the hyp-stub exception vector routines and the KVM exception vector
> > routines differ; hyp-stub uses a non-zero value in x0 to implement
> > __hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.
> > 
> > Define three new preprocessor macros HVC_GET_VECTORS, HVC_SET_VECTORS and
> > HVC_CALL_HYP and to be used as hcall type specifiers and convert the
> > existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
> > to use these new macros when executing an HVC call.  Also change the
> > corresponding hyp-stub and KVM el1_sync exception vector routines to use these
> > new macros.
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> 
> Using the #imm value for HVC to separate what gets called looks fine to
> me. However, I'd like to see a review from Marc/Christoffer on this
> patch.

Marc, Christopher, comments please?

> Some comments below:
> 
> > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > index 7a5df52..99c319c 100644
> > --- a/arch/arm64/include/asm/virt.h
> > +++ b/arch/arm64/include/asm/virt.h
> > @@ -21,6 +21,26 @@
> >  #define BOOT_CPU_MODE_EL1	(0xe11)
> >  #define BOOT_CPU_MODE_EL2	(0xe12)
> >  
> > +/*
> > + * HVC_GET_VECTORS - Return the value of the vbar_el2 register.
> > + */
> > +
> > +#define HVC_GET_VECTORS 1
> > +
> > +/*
> > + * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
> > + *
> > + * @x0: Physical address of the new vector table.
> > + */
> > +
> > +#define HVC_SET_VECTORS 2
> > +
> > +/*
> > + * HVC_CALL_HYP - Execute a hyp routine.
> > + */
> > +
> > +#define HVC_CALL_HYP 3
> 
> I think you can ignore this case (make it the default), just define it
> as 0 as that's the normal use-case after initialisation and avoid
> checking it explicitly.

OK, I changed this so that HVC_CALL_HYP is the default at 0.

> >  /*
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index a272f33..e3db3fd 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -22,6 +22,7 @@
> >  #include <linux/irqchip/arm-gic-v3.h>
> >  
> >  #include <asm/assembler.h>
> > +#include <asm/kvm_arm.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/virt.h>
> >  
> > @@ -53,14 +54,22 @@ ENDPROC(__hyp_stub_vectors)
> >  	.align 11
> >  
> >  el1_sync:
> > -	mrs	x1, esr_el2
> > -	lsr	x1, x1, #26
> > -	cmp	x1, #0x16
> > -	b.ne	2f				// Not an HVC trap
> > -	cbz	x0, 1f
> > -	msr	vbar_el2, x0			// Set vbar_el2
> > +	mrs	x18, esr_el2
> > +	lsr	x17, x18, #ESR_ELx_EC_SHIFT
> > +	and	x18, x18, #ESR_ELx_ISS_MASK
> > +
> > +	cmp     x17, #ESR_ELx_EC_HVC64
> > +	b.ne    2f				// Not an HVC trap
> > +
> > +	cmp	x18, #HVC_GET_VECTORS
> > +	b.ne	1f
> > +	mrs	x0, vbar_el2
> >  	b	2f
> > -1:	mrs	x0, vbar_el2			// Return vbar_el2
> > +
> > +1:	cmp	x18, #HVC_SET_VECTORS
> > +	b.ne	2f
> > +	msr	vbar_el2, x0
> > +
> >  2:	eret
> >  ENDPROC(el1_sync)
> 
> You seem to be using x17 and x18 here freely. Do you have any guarantees
> that the caller saved/restored those registers? I guess you assume they
> are temporary registers and the caller first branches to a function
> (like __kvm_hyp_call) and expects them to be corrupted. But I'm not sure
> that's always the case. Take for example the __invoke_psci_fn_hvc where
> the function is in C (we should change this for other reasons).

Yes, I assume the compiler will not expect them to be preserved.  I
missed __invoke_psci_fn_hvc.  Can we just add x17 and x18 to the
clobbered list?

        asm volatile(
                        __asmeq("%0", "x0")
                        __asmeq("%1", "x1")
                        __asmeq("%2", "x2")
                        __asmeq("%3", "x3")
                        "hvc    #0\n"
                : "+r" (function_id)
-               : "r" (arg0), "r" (arg1), "r" (arg2));
+               : "r" (arg0), "r" (arg1), "r" (arg2)
+               : "x17", "x18");


> > diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> > index c0d8202..1916c89 100644
> > --- a/arch/arm64/kvm/hyp.S
> > +++ b/arch/arm64/kvm/hyp.S
> > @@ -27,6 +27,7 @@
> >  #include <asm/kvm_asm.h>
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/memory.h>
> > +#include <asm/virt.h>
> >  
> >  #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
> >  #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
> > @@ -1106,12 +1107,9 @@ __hyp_panic_str:
> >   * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
> >   * passed in r0 and r1.
> >   *
> > - * A function pointer with a value of 0 has a special meaning, and is
> > - * used to implement __hyp_get_vectors in the same way as in
> > - * arch/arm64/kernel/hyp_stub.S.
> >   */
> >  ENTRY(kvm_call_hyp)
> > -	hvc	#0
> > +	hvc	#HVC_CALL_HYP
> >  	ret
> >  ENDPROC(kvm_call_hyp)
> >  
> > @@ -1142,6 +1140,7 @@ el1_sync:					// Guest trapped into EL2
> >  
> >  	mrs	x1, esr_el2
> >  	lsr	x2, x1, #ESR_ELx_EC_SHIFT
> > +	and	x0, x1, #ESR_ELx_ISS_MASK
> >  
> >  	cmp	x2, #ESR_ELx_EC_HVC64
> >  	b.ne	el1_trap
> > @@ -1150,15 +1149,19 @@ el1_sync:					// Guest trapped into EL2
> >  	cbnz	x3, el1_trap			// called HVC
> >  
> >  	/* Here, we're pretty sure the host called HVC. */
> > +	mov	x18, x0
> 
> Same comment here about corrupting x18. If it is safe, maybe add some
> comments in the calling place.

I added a comment regarding this to virt.h where the HVC_XXX macros
are defined.  I'll post that fixed up patch for review.

> 
> >  	pop	x2, x3
> >  	pop	x0, x1
> >  
> > -	/* Check for __hyp_get_vectors */
> > -	cbnz	x0, 1f
> > +	cmp	x18, #HVC_GET_VECTORS
> > +	b.ne	1f
> >  	mrs	x0, vbar_el2
> >  	b	2f
> >  
> > -1:	push	lr, xzr
> > +1:	cmp	x18, #HVC_CALL_HYP
> > +	b.ne	2f
> > +
> > +	push	lr, xzr
> 
> At this point, we expect either HVC_GET_VECTORS or HVC_CALL_HYP. I think
> you can simply assume HVC_CALL_HYP as default and ignore the additional
> cmp.

OK, did that.

-Geoff
