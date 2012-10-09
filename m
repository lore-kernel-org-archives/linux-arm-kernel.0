From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 9 Oct 2012 15:05:54 +0100
Subject: Problem with 64-bit registers on i.MX53
In-Reply-To: <20121009090237.GI18531@pengutronix.de>
References: <20121008160841.GM19651@pengutronix.de>
 <20121008170124.GZ4625@n2100.arm.linux.org.uk>
 <20121008171011.GA4625@n2100.arm.linux.org.uk>
 <20121009090237.GI18531@pengutronix.de>
Message-ID: <20121009140554.GA2122@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 11:02:37AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Oct 08, 2012 at 06:10:11PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 08, 2012 at 06:01:24PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Oct 08, 2012 at 06:08:41PM +0200, Michael Olbrich wrote:
> > You may also like to try the patch below... it will probably fix your
> > problem.
> > 
> > diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
> > index a7aadbd..6a6f1e4 100644
> > --- a/arch/arm/include/asm/vfpmacros.h
> > +++ b/arch/arm/include/asm/vfpmacros.h
> > @@ -28,7 +28,7 @@
> >  	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
> >  	ldr	\tmp, [\tmp, #0]
> >  	tst	\tmp, #HWCAP_VFPv3D16
> > -	ldceq	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
> > +	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
> >  	addne	\base, \base, #32*4		    @ step over unused register space
> >  #else
> >  	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
> > @@ -52,7 +52,7 @@
> >  	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
> >  	ldr	\tmp, [\tmp, #0]
> >  	tst	\tmp, #HWCAP_VFPv3D16
> > -	stceq	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
> > +	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
> According to the ARMARM for v7-A and v7-R (ARM DDI 0406B errata 2010 Q2)
> the syntax is "STC{L}<c> ...", with a note "The pre-UAL syntax STC<c>L
> is equivalent to STCL<c>.". Maybe the UAL-syntax should better be used?

The older stc<c>l type of syntax is used all over the place.  Code which
might need to be built by tools which pre-date unified syntax needs to
use the old syntax, so it is in common usage in the kernel in general.

This code presumably only gets built by new-enough tools for the unified
syntax to be usable, but support for the old syntax isn't going to
disappear from the tools any time soon, AFAIK.


The bug here was that the presence or absence of the "L" suffix is used
to encode bit 4 of the starting d-register number for these instructions.
The comment says d16-d31, but the instructions as written are actually
saving and restoring d0-d15...which is not so helpful since we already
handled those registers in the neighbouring code.

We could avoid this kind of bug by writing those VFP instructions
using the unified syntax native mnemonics (vstmia, vldmia -- since d16-
d31 never existed while the old fldmiad/fstmiad mnemonics were in use,
and the assembler doesn't accept them), but it is tricky to change the
assembler's notion of target CPU and FPU on-the-fly inside a header or
macro without messing things up.

Cheers
---Dave



> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
