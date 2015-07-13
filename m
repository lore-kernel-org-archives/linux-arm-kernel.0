From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 12:22:27 +0100
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <20150713102848.GX19282@twins.programming.kicks-ass.net>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-14-git-send-email-will.deacon@arm.com>
 <20150713102848.GX19282@twins.programming.kicks-ass.net>
Message-ID: <20150713112226.GC2632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 11:28:48AM +0100, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 10:25:14AM +0100, Will Deacon wrote:
> > cmpxchg doesn't require memory barrier semantics when the value
> > comparison fails, so make the barrier conditional on success.
> 
> So this isn't actually a documented condition.

There's *something* in Documentation/atomic_ops.txt (literally, the last
sentence in the file) but it's terrible at best:

"Note that this also means that for the case where the counter
 is not dropping to zero, there are no memory ordering
 requirements."

[you probably want to see the example for some context]

> I would very much like a fwe extra words on this, that you've indeed
> audited cmpxchg() users and preferably even a Documentation/ update to
> match.

Happy to update the docs. In terms of code audit, I couldn't find any
cmpxchg users that do something along the lines of "if the comparison
fails, don't loop, and instead do something to an independent address,
without barrier semantics that must be observed after the failed CAS":

  - Most (as in, it's hard to find other cases) users just loop until
    success, so there's no issue there.

  - One use-case with work on the failure path is stats update (e.g.
    drivers/net/ethernet/intel/ixgbe/ixgbe.h), but barrier semantics
    aren't required here anyway.

  - Another use-case is where you optimistically try a cmpxchg, then
    fall back on a lock if you fail (e.g. slub and cmpxchg_double).

  - Some other archs appear to do the same trick (alpha and powerpc).

So I'm confident with this change, but agree that a Docs update would
be beneficial. Something like below, or do you want some additional text,
too?

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 13feb697271f..18fc860df1be 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2383,9 +2383,7 @@ about the state (old or new) implies an SMP-conditional general memory barrier
 explicit lock operations, described later).  These include:
 
 	xchg();
-	cmpxchg();
 	atomic_xchg();			atomic_long_xchg();
-	atomic_cmpxchg();		atomic_long_cmpxchg();
 	atomic_inc_return();		atomic_long_inc_return();
 	atomic_dec_return();		atomic_long_dec_return();
 	atomic_add_return();		atomic_long_add_return();
@@ -2398,7 +2396,9 @@ explicit lock operations, described later).  These include:
 	test_and_clear_bit();
 	test_and_change_bit();
 
-	/* when succeeds (returns 1) */
+	/* when succeeds */
+	cmpxchg();
+	atomic_cmpxchg();		atomic_long_cmpxchg();
 	atomic_add_unless();		atomic_long_add_unless();
 
 These are used for such things as implementing ACQUIRE-class and RELEASE-class
