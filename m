From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 8 Jul 2015 11:59:44 +0200
Subject: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
In-Reply-To: <559C284D.4090907@hp.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-3-git-send-email-will.deacon@arm.com>
 <559C11BA.1070309@hp.com> <20150707181941.GL23879@arm.com>
 <559C284D.4090907@hp.com>
Message-ID: <20150708095944.GA3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 03:28:13PM -0400, Waiman Long wrote:
> #ifndef queued_inc_reader_return
> static inline u32 queued_inc_reader_return(struct qrwlock *lock)

That's actually a misleading name, we don't do an inc_return, we do a
fetch_inc.

> {
>     return atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
> }
> #endif

With that you (Will) could even reuse the ll/sc load and avoid issuing a
second load. You basically need atomic_fetch_add_relaxed().
