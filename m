From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Jan 2015 18:00:51 +0000
Subject: [PATCH 3/8] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <20150127173947.GJ3226@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <3f1795bc1dad1d0510a9d24a168ecd5d83666507.1421449714.git.geoff@infradead.org>
 <20150127173947.GJ3226@e104818-lin.cambridge.arm.com>
Message-ID: <20150127180051.GN17721@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 05:39:47PM +0000, Catalin Marinas wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > index 99c319c..4f23a48 100644
> > --- a/arch/arm64/include/asm/virt.h
> > +++ b/arch/arm64/include/asm/virt.h
> > @@ -41,6 +41,19 @@
> >  
> >  #define HVC_CALL_HYP 3
> >  
> > +/*
> > + * HVC_CALL_FUNC - Execute a function at EL2.
> > + *
> > + * @x0: Physical address of the function to be executed.
> > + * @x1: Passed as the first argument to the function.
> > + * @x2: Passed as the second argument to the function.
> > + * @x3: Passed as the third argument to the function.
> > + *
> > + * The called function must preserve the contents of register x18.
> 
> Can you pick a register that's normally callee saved?

We're in the hyp-stub, so we don't have a stack in EL2. Therefore we
can't stack any of the existing callee-saved register values in order to
be able to use them.

One way to avoid that would be to have asm block which issues the HVC at
EL1 stack/unstack the LR around the HVC. Then we're free to corrupt the
LR at EL2 in order to call the provided function.

[...]

> > +1:	cmp     x18, #HVC_CALL_FUNC
> > +	b.ne    2f
> > +	mov     x18, lr
> > +	mov     lr, x0
> > +	mov     x0, x1
> > +	mov     x1, x2
> > +	mov     x2, x3
> > +	blr     lr
> > +	mov     lr, x18
> >  
> >  2:	eret
> >  ENDPROC(el1_sync)
> 
> What is the calling convention for this HVC? You mentioned x18 above but
> what about other registers that the called function may corrupt (x18 is
> a temporary register, so it's not expected to be callee saved).

Other than x18, the usual PCS rules apply here. We don't have a stack,
so the function we call can't make a nested call to anything else.

Mark.
