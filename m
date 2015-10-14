From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Oct 2015 13:36:24 +0100
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014110717.GT17308@twins.programming.kicks-ass.net>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014102706.GR14956@sirena.org.uk>
 <20151014110717.GT17308@twins.programming.kicks-ass.net>
Message-ID: <20151014123624.GV14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 01:07:17PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2015 at 11:27:06AM +0100, Mark Brown wrote:
> > On Wed, Oct 14, 2015 at 10:20:50AM +0200, Peter Zijlstra wrote:

> > > Uuh, I just looked at next and saw this regulator_lock_supply()
> > > function. How is that limited? subclass must be <8 otherwise bad things
> > > happen.

> > Can we please get some more discoverable documentation of the arbitrary
> > limits in the lockdep code? 

> include/linux/lockdep.h:#define MAX_LOCKDEP_SUBCLASSES          8UL

Sure, but I don't really expect to have to trawl the implementation of
an API to find out about this sort of thing (I hadn't even been aware
that the subclasses were required to be small positive integers, never
mind needing to check what the limit was).  I think the main place I'd
have expected to see it was in lockdep-design.txt or somewhere near
that.

> > I seem to keep seeing code that bumps into
> > surprising limits like this and I'm not sure how I'm supposed to know
> > about them except through finding out after the fact or trawling the
> > code every time someone touches locking.

> Not knowing what other limits you've hit, I'm not entirely sure how to
> help out there.

The other big one that came up recently was that lockdep apparently
works out what a class is by looking at the point of allocation which
causes a lot of problems for regmap since it makes all regmap locks look
like a single class.  That's fixed now by explicitly allocating a class
per regmap with some macro magic but it was a bit of a surprise.  The
documentation doesn't make this obvious.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/74474f5e/attachment.sig>
