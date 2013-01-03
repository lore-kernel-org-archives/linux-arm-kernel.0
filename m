From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 14:13:01 +0000
Subject: [PATCH 2/2] arm: make return_address available for ARM_UNWIND
In-Reply-To: <1357220165.10284.30.camel@gandalf.local.home>
References: <1357207949-3349-1-git-send-email-kpark3469@gmail.com>
 <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
 <20130103103815.GL2631@n2100.arm.linux.org.uk>
 <CA+KhAHbmjD7zTw+wcw84Abg3V1dD=0Ea4kUpYdGENQf1UOWphw@mail.gmail.com>
 <1357220165.10284.30.camel@gandalf.local.home>
Message-ID: <20130103141301.GQ2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 08:36:05AM -0500, Steven Rostedt wrote:
> On Thu, 2013-01-03 at 20:36 +0900, Keun-O Park wrote:
> >         So what have you done about the issue referred in this
> >         comment?  Or do you
> >         believe that fixing warnings (even if they are explicit
> >         #warning statements)
> >         is far more important than code being functionally correct?
> > 
> > I admit that I missed to add notrace to unwind.c.
> > Do you think there's more to add?
> 
> I think Russell wants a better change log. What was written sounds like
> the fix was to remove a warning. It wasn't very clear to how the warning
> is no longer relevant because of the new changes.
> 
> The old change log:
> 
> ---
> This fixes a warning saying:
> 
>     warning: #warning "TODO: return_address should use unwind tables"
> 
> And, this enables return_address using unwind information. If ARM_UNWIND is
> selected, unwind_frame in unwind.c will be called in walk_stackframe.
> ---
> 
> 
> Maybe you wanted to say something like:
> 
> ---
> Now that the return_address code can safely use unwind tables, fix up
> the #ifdef statements to reflect this.
> ---
> 
> Or something similar, if that's what was done.

No.  What I want is some evidence that the patch author is not just
removing warnings by patching them away, but has thought about why
the warning is there, and that they've resolved the issues for why
that warning is there - and most importantly why the code is not built
in that configuration.

The unwinder has many functions, none of which is marked in any way.
This is alluded to in this comment:

/*
 * return_address uses walk_stackframe to do it's work.  If both
 * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses unwind
 * information.  For this to work in the function tracer many functions would
 * have to be marked with __notrace.  So for now just depend on
 * !CONFIG_ARM_UNWIND.
 */

So, what this means is that the function tracer can have hooks in the
unwinder code.  If one of those hooks is active, then there's the
possibility for recursion.

I see no evidence in either of these patches that this issue has been
addressed in any way (let alone thought about.)  The approach here seems
to be "lets remove the comment, lets change the ifdefs to make the code
build, and lets remove the warning".

That's not acceptable.  We don't fix warnings to make them go away while
effectively hiding the original problem.

> 
> -- Steve
> 
> 
> > 
> > diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> > index 00df012..52ff2d4 100644
> > --- a/arch/arm/kernel/unwind.c
> > +++ b/arch/arm/kernel/unwind.c
> > @@ -327,7 +327,7 @@ static int unwind_exec_insn(struct
> > unwind_ctrl_block *ctrl)
> >   * Unwind a single frame starting with *sp for the symbol at *pc. It
> >   * updates the *pc and *sp with the new values.
> >   */
> > -int unwind_frame(struct stackframe *frame)
> > +int notrace unwind_frame(struct stackframe *frame)
> >  {
> >         unsigned long high, low;
> >         const struct unwind_idx *idx;
> > 

And what about search_index(), unwind_find_origin(), unwind_find_idx(),
unwind_get_byte(), unwind_exec_insn(), pr_debug(), pr_warning()?  Maybe
the compiler currently inlines all those functions, but todays compiler
behaviour is no guarantee of tomorrow's compiler behaviour.  We'd also
hope that list_move() would always be inlined and never traced.

It is possible that the ftrace code has some re-entrancy protection to
prevent the unwinder recursing back into the ftrace code, but that's not
mentioned in this patch... so it could be that needs to be explained.

In summary, from what I can see in the patch, the reason why the ifdefs
are the way they are, and the reason the warning is there has not been
addressed; these patches just seem to be aimed just at removing a #warning
statement to make the warning go away.
