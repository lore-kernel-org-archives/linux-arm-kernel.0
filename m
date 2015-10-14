From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Oct 2015 11:27:06 +0100
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014082050.GQ17308@twins.programming.kicks-ass.net>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
Message-ID: <20151014102706.GR14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 10:20:50AM +0200, Peter Zijlstra wrote:

> Uuh, I just looked at next and saw this regulator_lock_supply()
> function. How is that limited? subclass must be <8 otherwise bad things
> happen.

Can we please get some more discoverable documentation of the arbitrary
limits in the lockdep code?  I seem to keep seeing code that bumps into
surprising limits like this and I'm not sure how I'm supposed to know
about them except through finding out after the fact or trawling the
code every time someone touches locking.

I would be very surprised to see a system that pushes over 8 locks,
while there's nothing actually preventing it system design
considerations mean that even four cascaded supplies are pretty
unlikely so we should be fine.  Every time you add a new level of
regulation you're both increasing the load on regulators up the chain
(which means they need to be bigger and more expensive) and except in
the case of a DCDC supplying an LDO (which only works to one level)
you're going to be decreasing the efficiency of the system.  If we get
to that point we can worry about what to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/2eaedd02/attachment.sig>
