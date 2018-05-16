From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 16 May 2018 10:01:32 +0100
Subject: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
In-Reply-To: <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
 <20180515121921.GN7753@e103592.cambridge.arm.com>
 <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
Message-ID: <20180516090121.GQ7753@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 05:33:52PM +0100, Mark Rutland wrote:
> On Tue, May 15, 2018 at 01:19:26PM +0100, Dave Martin wrote:
> > On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> > > On Mon, May 14, 2018 at 12:06:50PM +0100, Dave Martin wrote:
> > > > On Mon, May 14, 2018 at 10:46:28AM +0100, Mark Rutland wrote:

[...]

> > > > > @@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
> > > > >  	return -EINVAL;
> > > > >  }
> > > > >  
> > > > > +static inline void sve_user_disable(void) { }
> > > > > +static inline void sve_user_enable(void) { }
> > > > > +
> > > > 
> > > > Alternatively, just move the full definitions outside the #ifdef
> > > > CONFIG_ARM64_SVE.
> > > 
> > > Can do, though I was trying to keep the exsting pattern with empty
> > > inlines for the !CONFIG_ARM64_SVE case.
> > 
> > There isn't really a pattern.  I tried to avoid dummy versions where
> > there's no real reason to have them.  I don't _think_ they're really
> > needed here, unless I missed something.  Did you get build failures
> > without them?
> 
> I need *some* definition so that sve_user_reset() in the syscall path
> can compile without ifdeferry. 
> 
> In sve_user_reset() I first check system_supports_sve(), which checks
> IS_ENABLED(CONFIG_ARM64_SVE), so the call should be optimised away when
> !CONFIG_ARM64_SVE, but I need a prototype regardless.

What I envisaged is that you move the real definitions outside the
#ifdef so that they're defined unconditionally, and get rid of the
dummies.

Having a dummy definition of sve_user_enable() really feels like it's
papering over something.  How could it be appropriate to call this in a
non-SVE enabled system?  You _do_ guard the call to this already, so
hiding the real function body for CONFIG_ARM64_SVE=n doesn't appear to
achieve anything.  Maybe I missed something somewhere.

A dummy sve_user_disable() is a bit more reasonable though, but we want
this to be a nop on non-SVE hardware even if CONFIG_ARM64_SVE=y.

What about moving the system_supports_sve() check inside
sve_user_disable()?

[...]

> > > Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> > > to catch that kind of thing -- I could restore that.
> > 
> > IIUC:
> > 
> > 	if (0) {
> > 		BUILD_BUG_ON(1);
> > 	}
> > 
> > can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
> > in most of the SVE support code.
> 
> We already rely on BUILD_BUG() not firing in paths that can be trivially
> optimized away. e.g. in the cmpxchg code.

Fair enough.  I had been unsure on this point.

If you want to put a BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM64_SVE)) in
sve_user_enable() and build with CONFIG_ARM64_SVE=n to check it works,
then I'd be fine with that.

This doesn't capture the runtime part of the condition, but it's better
than nothing.

[...]

> > > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > > index 088940387a4d..79a81c7d85c6 100644
> > > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > > > >  	__sve_free(task);
> > > > >  }
> > > > >  
> > > > > -
> > > > 
> > > > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > > > trivial).
> > > 
> > > I'll assume that Ack stands regardless. :)
> > 
> > Actually, I was just commenting on the deleted blank line... 
> 
> Ah. I've restored that now.

I meant Ack to the deletion.  It looks like the blank line was
spuriously introduced in the first place.  But it doesn't hugely matter
either way.

Cheers
---Dave
