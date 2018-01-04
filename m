From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Jan 2018 18:31:59 +0000
Subject: [PATCH 01/11] arm64: use RET instruction for exiting the
 trampoline
In-Reply-To: <CAKv+Gu-D763a5OouvmQ_6WfCV-dLgtyHtfT0B1hmrxDX5knD0Q@mail.gmail.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-2-git-send-email-will.deacon@arm.com>
 <CAKv+Gu-D763a5OouvmQ_6WfCV-dLgtyHtfT0B1hmrxDX5knD0Q@mail.gmail.com>
Message-ID: <20180104183158.GM13436@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Jan 04, 2018 at 04:24:22PM +0000, Ard Biesheuvel wrote:
> On 4 January 2018 at 15:08, Will Deacon <will.deacon@arm.com> wrote:
> > Speculation attacks against the entry trampoline can potentially resteer
> > the speculative instruction stream through the indirect branch and into
> > arbitrary gadgets within the kernel.
> >
> > This patch defends against these attacks by forcing a misprediction
> > through the return stack: a dummy BL instruction loads an entry into
> > the stack, so that the predicted program flow of the subsequent RET
> > instruction is to a branch-to-self instruction which is finally resolved
> > as a branch to the kernel vectors with speculation suppressed.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/entry.S | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 031392ee5f47..b9feb587294d 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -1029,6 +1029,9 @@ alternative_else_nop_endif
> >         .if     \regsize == 64
> >         msr     tpidrro_el0, x30        // Restored in kernel_ventry
> >         .endif
> > +       bl      2f
> > +       b       .
> > +2:
> 
> This deserves a comment, I guess?

Yeah, I suppose ;) I'll lift something out of the commit message.

> Also, is deliberately unbalancing the return stack likely to cause
> performance problems, e.g., in libc hot paths?

I don't think so, because it remains balanced after this code. We push an
entry on with the BL and pop it with the RET; the rest of the return stack
remains unchanged. That said, I'm also not sure what we could do differently
here!

Will
