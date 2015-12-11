From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 09:41:33 +0100
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
Message-ID: <20151211084133.GE6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 08:51:34PM -0800, Andrew Pinski wrote:

> So looking further I think I understand what is going wrong and why
> c55a6ffa6285e29f874ed403979472631ec70bff is incorrect.

The osq_wait_next() call in osq_lock() is when we fail the lock. This is
effectively trylock() semantics and like for cmpxchg a failed trylock
has no implied barrier semantics.  So from that POV osq_wait_next() does
not need to provide ACQUIRE semantics.

In osq_unlock() there's an xchg() in front, which implies full barriers
and thereby provides RELEASE semantics for that part of osq_unlock(), so
again, from this POV osq_wait_next() does not need to provide RELEASE
semantics.

> The compare and swap inside osq_lock needs to be both release and
> acquire semantics memory barriers because the stores (to node) need to
> be visible to the other cores before the setting of lock->tail
> happens.

I'm a wee bit confused on what exactly you mean. Both stores to @node:

 1) osq_wait_next(): next = xchg(&node->next, NULL)
 2) osq_unlock():    next = xchg(&node->next, NULL)

are xchg() calls which imply full ordering (sequential consistency).

Similarly the store before osq_wait_next() in osq_lock(), namely:

  cmpxchg(&prev->node, node, NULL)

is fully ordered.

So I cannot see any store being delayed past the
atomic_cmpxchg_acquire().

Now you mention 'compare and swap inside osq_lock' which I take to be
the latter; and it _is_ fully ordered.
