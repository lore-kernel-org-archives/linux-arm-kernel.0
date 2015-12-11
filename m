From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 12:04:19 +0000
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211084133.GE6356@twins.programming.kicks-ass.net>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
Message-ID: <20151211120419.GD18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, Dec 11, 2015 at 09:41:33AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 10, 2015 at 08:51:34PM -0800, Andrew Pinski wrote:
> 
> > So looking further I think I understand what is going wrong and why
> > c55a6ffa6285e29f874ed403979472631ec70bff is incorrect.
> 
> The osq_wait_next() call in osq_lock() is when we fail the lock. This is
> effectively trylock() semantics and like for cmpxchg a failed trylock
> has no implied barrier semantics.  So from that POV osq_wait_next() does
> not need to provide ACQUIRE semantics.
> 
> In osq_unlock() there's an xchg() in front, which implies full barriers
> and thereby provides RELEASE semantics for that part of osq_unlock(), so
> again, from this POV osq_wait_next() does not need to provide RELEASE
> semantics.
> 
> > The compare and swap inside osq_lock needs to be both release and
> > acquire semantics memory barriers because the stores (to node) need to
> > be visible to the other cores before the setting of lock->tail
> > happens.
> 
> I'm a wee bit confused on what exactly you mean. Both stores to @node:
> 
>  1) osq_wait_next(): next = xchg(&node->next, NULL)
>  2) osq_unlock():    next = xchg(&node->next, NULL)
> 
> are xchg() calls which imply full ordering (sequential consistency).

I think Andrew meant the atomic_xchg_acquire at the start of osq_lock,
as opposed to "compare and swap". In which case, it does look like
there's a bug here because there is nothing to order the initialisation
of the node fields with publishing of the node, whether that's
indirectly as a result of setting the tail to the current CPU or
directly as a result of the WRITE_ONCE.

Andrew, David: does making that atomic_xchg_acquire and atomic_xchg
fix things for you?

I don't fully grok what 81a43adae3b9 has to do with any of this, so
maybe there's another bug too.

Will

--->8

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d092a0c9c2d4..05a37857ab55 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -93,10 +93,12 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	node->cpu = curr;
 
 	/*
-	 * ACQUIRE semantics, pairs with corresponding RELEASE
-	 * in unlock() uncontended, or fastpath.
+	 * We need both ACQUIRE (pairs with corresponding RELEASE in
+	 * unlock() uncontended, or fastpath) and RELEASE (to publish
+	 * the node fields we just initialised) semantics when updating
+	 * the lock tail.
 	 */
-	old = atomic_xchg_acquire(&lock->tail, curr);
+	old = atomic_xchg(&lock->tail, curr);
 	if (old == OSQ_UNLOCKED_VAL)
 		return true;
 
