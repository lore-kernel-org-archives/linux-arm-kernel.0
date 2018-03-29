From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Mar 2018 10:28:15 +0100
Subject: [PATCH resend 1/2] arm64: assembler: add utility macros to
 push/pop stack frames
In-Reply-To: <CAKv+Gu9+c610HwdBOkhV3Z0nBePZZ+jf4_OTukRfEgCm0FNtFQ@mail.gmail.com>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
 <20180328124129.6459-2-ard.biesheuvel@linaro.org>
 <20180328163452.GM16308@e103592.cambridge.arm.com>
 <CAKv+Gu9+c610HwdBOkhV3Z0nBePZZ+jf4_OTukRfEgCm0FNtFQ@mail.gmail.com>
Message-ID: <20180329092813.GO16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 09:54:31AM +0100, Ard Biesheuvel wrote:
> On 28 March 2018 at 17:34, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Wed, Mar 28, 2018 at 02:41:28PM +0200, Ard Biesheuvel wrote:
> >> We are going to add code to all the NEON crypto routines that will
> >> turn them into non-leaf functions, so we need to manage the stack
> >> frames. To make this less tedious and error prone, add some macros
> >> that take the number of callee saved registers to preserve and the
> >
> > Apologies for the delay in looking at these patches...
> >
> > Anyway:
> >
> > Nit: for all instances of "callee saved" in this patch, do you mean             "caller saved"?
> >
> 
> 'Caller saved' means that the caller needs to stack/unstack a register
> itself if it needs its value to be preserved across a function call.
> 'Callee saved' means that the caller can rely on the callee to ensure
> that the register will retain its value.
> 
> So we are dealing with the latter here, afaict. Or am I missing something?

Yes, I confused myself.  In preparation for calling kernel_neon_begin
etc., we would potentially need to save some caller-save registers.  But
that's not what the macros in this patch are about.

> > A few stylistic comments below, but I don't consider them essential to
> > address unless someone feels like it.
> >
> > Otherwise,
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> >
> 
> Thanks.
> 
> >> extra size to allocate in the stack frame (for locals) and emit
> >> the ldp/stp sequences.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/assembler.h | 58 ++++++++++++++++++++
> >>  1 file changed, 58 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h

[...]

> >> +     .macro          __frame, op, regcount, extra=0

[...]

> >> +     .ifc            \op, ld
> >> +     .if             .Lframe_regcount == -1
> >
> > We could also have
> >
> >         .ifc            \op, st
> >         .ifdef          .Lframe_regcount
> >         .if             .Lframe_regcount != -1
> >         .error [...]
> >
> > on the push side, which would trip on the first nested frame_push
> > rather than waiting until a frame_pop appears.
> >
> > Your existing code could be retained to guard against a double pop.
> >
> 
> Nice. I'll try that.

OK, cool

[...]

Cheers
---Dave
