From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 30 Sep 2016 20:52:31 +0200
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
Message-ID: <20160930185231.GA3142@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 01:40:57PM -0400, Brent DeGraaf wrote:
> Prior spinlock code solely used load-acquire and store-release
> semantics to ensure ordering of the spinlock lock and the area it
> protects. However, store-release semantics and ordinary stores do
> not protect against accesses to the protected area being observed
> prior to the access that locks the lock itself.
> 
> While the load-acquire and store-release ordering is sufficient
> when the spinlock routines themselves are strictly used, other
> kernel code that references the lock values directly (e.g. lockrefs)
> could observe changes to the area protected by the spinlock prior
> to observance of the lock itself being in a locked state, despite
> the fact that the spinlock logic itself is correct.
> 
> Barriers were added to all the locking routines wherever necessary
> to ensure that outside observers which read the lock values directly
> will not observe changes to the protected data before the lock itself
> is observed.

I cannot see this going in. You're making spinlocks far more expensive
in the common case that doesn't need this.

Please enumerate the special cases (there's more than just lockref?) and
fix those.
