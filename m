From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Mar 2018 13:42:08 +0100
Subject: [PATCH resend 2/2] arm64: assembler: add macros to conditionally
 yield the NEON under PREEMPT
In-Reply-To: <978F38B1-BCAA-4E57-BFD4-3BB5D8AC0F19@linaro.org>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
 <20180328124129.6459-3-ard.biesheuvel@linaro.org>
 <20180328171812.GN16308@e103592.cambridge.arm.com>
 <CAKv+Gu-FdndoFON3tJi0WP=+HsBtaoLY-uf6=0bd3e6jr1h-DQ@mail.gmail.com>
 <20180329093605.GP16308@e103592.cambridge.arm.com>
 <CAKv+Gu8o4R5JBseRt345OV5UVShFmGYiF4Wpxsnw_ZiRuch2AQ@mail.gmail.com>
 <20180329111227.GQ16308@e103592.cambridge.arm.com>
 <978F38B1-BCAA-4E57-BFD4-3BB5D8AC0F19@linaro.org>
Message-ID: <20180329124207.GR16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 01:36:44PM +0200, Ard Biesheuvel wrote:
> 
> > On 29 Mar 2018, at 13:12, Dave Martin <Dave.Martin@arm.com> wrote:
> > 
> >> On Thu, Mar 29, 2018 at 10:59:28AM +0100, Ard Biesheuvel wrote:
> >>> On 29 March 2018 at 10:36, Dave Martin <Dave.Martin@arm.com> wrote:
> >>>> On Thu, Mar 29, 2018 at 10:02:18AM +0100, Ard Biesheuvel wrote:
> >>>> On 28 March 2018 at 18:18, Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> >>>>> Since the patchup sequences aren't likely to be many or large, it's
> >>>>> not the end of the world if we don't do this discarding though.
> >>>>> 
> >>>> 
> >>>> I chose not to bother. These are handcrafted assembly files that are
> >>>> usually kept in modules, which means the .text footprint is a 4k
> >>>> multiple anyway, and the code is complex enough as it is, so
> >>>> discarding ~10 instructions that have been moved out of the hot path
> >>>> already doesn't seem that useful to me.
> >>> 
> >>> Agreed.  Do you know who is building CONFIG_PREEMPT=n kernels these
> >>> days?
> >>> 
> >> 
> >> AFAIK most distro kernels use voluntary preemption, so they'd still
> >> benefit from this.
> > 
> > OK, and given the size of the typical distro kernel, I doubt anyone will
> > lose sleep over a couple of hundred extra bytes.
> > 
> 
> My point was that this is /not/ dead code on typical distro kernels
> given that this approach should work equally under voluntary preemption.

I think CONFIG_PREEMPT and CONFIG_PREEMPT_VOLUNTARY are mutually
exclusive, so in the PREEMPT_VOLUNTARY case the yield path code will
get compiled out here.

But that's probably the right thing to do IIUC: unless we introduce an
explicit preemption point into do_cond_yield_neon, voluntary preemption
won't occur anyway.  And the crypto API probably doesn't expect us to
do that... especially if we're in a softirq.

[...]

Cheers
---Dave
