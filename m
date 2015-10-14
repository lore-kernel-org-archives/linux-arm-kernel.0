From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 14 Oct 2015 15:47:21 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014123624.GV14956@sirena.org.uk>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014102706.GR14956@sirena.org.uk>
 <20151014110717.GT17308@twins.programming.kicks-ass.net>
 <20151014123624.GV14956@sirena.org.uk>
Message-ID: <20151014134721.GD3816@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 01:36:24PM +0100, Mark Brown wrote:

> Sure, but I don't really expect to have to trawl the implementation of
> an API to find out about this sort of thing (I hadn't even been aware

I more like view header files as 'documentation' and c files as
implementation :-)

> that the subclasses were required to be small positive integers, never
> mind needing to check what the limit was).  I think the main place I'd
> have expected to see it was in lockdep-design.txt or somewhere near
> that.

Oh, you're one of them people that actually looks in Documentation/.

> The other big one that came up recently was that lockdep apparently
> works out what a class is by looking at the point of allocation which
> causes a lot of problems for regmap since it makes all regmap locks look
> like a single class.  That's fixed now by explicitly allocating a class
> per regmap with some macro magic but it was a bit of a surprise.  The
> documentation doesn't make this obvious.

Yes, Documentation/locking/lockdep-design.txt needs help -- I'd even
forgotten we had it.

Does the below work for you?

---
 Documentation/locking/lockdep-design.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 5001280e9d82..e8e9ad4e6f5e 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -24,6 +24,10 @@ a lock-class is used for the first time after bootup it gets registered,
 and all subsequent uses of that lock-class will be attached to this
 lock-class.
 
+A class is typically associated with a lock's initialisation site; although
+its possible to explicitly initialize a lock with a different class key --
+such class keys much come from static storage.
+
 State
 -----
 
@@ -165,6 +169,10 @@ partition.
 The validator treats a lock that is taken in such a nested fashion as a
 separate (sub)class for the purposes of validation.
 
+Since lock classes are associated with static addresses, the size of struct
+lock_class_key determines the amount of sub classes that are possible --
+currently set to 8.
+
 Note: When changing code to use the _nested() primitives, be careful and
 check really thoroughly that the hierarchy is correctly mapped; otherwise
 you can get false positives or false negatives.
