From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 8 Sep 2017 18:22:14 +0200
Subject: [PATCH] arm64: spinlocks: Fix write starvation with rwlock
In-Reply-To: <20170908155959.6940-1-jeremy.linton@arm.com>
References: <20170908155959.6940-1-jeremy.linton@arm.com>
Message-ID: <20170908162214.63cf3wp27rhcrw6h@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 10:59:59AM -0500, Jeremy Linton wrote:
> 
> This patch changes the rwlock behavior so that the writer
> unconditionally flags the lock structure (given that its
> not already flagged by another writer). This blocks further
> readers from acquiring the lock. Once all the readers have
> drained, the writer that successfully flagged the lock can
> progress.

Recursive readers from IRQ context _should_ be allowed through,
otherwise you'll have deadlocks on tasklist_lock.
