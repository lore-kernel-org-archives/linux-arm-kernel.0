From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Feb 2015 16:04:52 +0000
Subject: [PATCH 2/8] arm64: Convert hcalls to use ISS field
In-Reply-To: <1422660681.21823.38.camel@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <20150126182621.GH14048@e104818-lin.cambridge.arm.com>
 <1422660681.21823.38.camel@infradead.org>
Message-ID: <20150202160452.GF22661@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 11:31:21PM +0000, Geoff Levand wrote:
> On Mon, 2015-01-26 at 18:26 +0000, Catalin Marinas wrote:
> > On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > >  /*
> > > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > > index a272f33..e3db3fd 100644
> > > --- a/arch/arm64/kernel/hyp-stub.S
> > > +++ b/arch/arm64/kernel/hyp-stub.S
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/irqchip/arm-gic-v3.h>
> > >  
> > >  #include <asm/assembler.h>
> > > +#include <asm/kvm_arm.h>
> > >  #include <asm/ptrace.h>
> > >  #include <asm/virt.h>
> > >  
> > > @@ -53,14 +54,22 @@ ENDPROC(__hyp_stub_vectors)
> > >  	.align 11
> > >  
> > >  el1_sync:
> > > -	mrs	x1, esr_el2
> > > -	lsr	x1, x1, #26
> > > -	cmp	x1, #0x16
> > > -	b.ne	2f				// Not an HVC trap
> > > -	cbz	x0, 1f
> > > -	msr	vbar_el2, x0			// Set vbar_el2
> > > +	mrs	x18, esr_el2
> > > +	lsr	x17, x18, #ESR_ELx_EC_SHIFT
> > > +	and	x18, x18, #ESR_ELx_ISS_MASK
> > > +
> > > +	cmp     x17, #ESR_ELx_EC_HVC64
> > > +	b.ne    2f				// Not an HVC trap
> > > +
> > > +	cmp	x18, #HVC_GET_VECTORS
> > > +	b.ne	1f
> > > +	mrs	x0, vbar_el2
> > >  	b	2f
> > > -1:	mrs	x0, vbar_el2			// Return vbar_el2
> > > +
> > > +1:	cmp	x18, #HVC_SET_VECTORS
> > > +	b.ne	2f
> > > +	msr	vbar_el2, x0
> > > +
> > >  2:	eret
> > >  ENDPROC(el1_sync)
> > 
> > You seem to be using x17 and x18 here freely. Do you have any guarantees
> > that the caller saved/restored those registers? I guess you assume they
> > are temporary registers and the caller first branches to a function
> > (like __kvm_hyp_call) and expects them to be corrupted. But I'm not sure
> > that's always the case. Take for example the __invoke_psci_fn_hvc where
> > the function is in C (we should change this for other reasons).
> 
> Yes, I assume the compiler will not expect them to be preserved.  I
> missed __invoke_psci_fn_hvc.  Can we just add x17 and x18 to the
> clobbered list?
> 
>         asm volatile(
>                         __asmeq("%0", "x0")
>                         __asmeq("%1", "x1")
>                         __asmeq("%2", "x2")
>                         __asmeq("%3", "x3")
>                         "hvc    #0\n"
>                 : "+r" (function_id)
> -               : "r" (arg0), "r" (arg1), "r" (arg2));
> +               : "r" (arg0), "r" (arg1), "r" (arg2)
> +               : "x17", "x18");

I think we can ignore these because they would be called from a guest
context and IIUC we would only clobber x18 on the host HVC side.

-- 
Catalin
