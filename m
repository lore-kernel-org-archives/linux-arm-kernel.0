From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 17:24:59 +0000
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211171128.GC6356@twins.programming.kicks-ass.net>
References: <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
 <20151211121319.GK6356@twins.programming.kicks-ass.net>
 <20151211121759.GE18828@arm.com>
 <20151211122647.GM6356@twins.programming.kicks-ass.net>
 <20151211133313.GG18828@arm.com>
 <20151211134803.GP6356@twins.programming.kicks-ass.net>
 <20151211140649.GI18828@arm.com>
 <20151211171128.GC6356@twins.programming.kicks-ass.net>
Message-ID: <20151211172458.GL18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:11:28PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 11, 2015 at 02:06:49PM +0000, Will Deacon wrote:
> > On Fri, Dec 11, 2015 at 02:48:03PM +0100, Peter Zijlstra wrote:
> > > On Fri, Dec 11, 2015 at 01:33:14PM +0000, Will Deacon wrote:
> > > > On Fri, Dec 11, 2015 at 01:26:47PM +0100, Peter Zijlstra wrote:
> > > 
> > > > > While we're there, the acquire in osq_wait_next() seems somewhat ill
> > > > > documented too.
> > > > > 
> > > > > I _think_ we need ACQUIRE semantics there because we want to strictly
> > > > > order the lock-unqueue A,B,C steps and we get that with:
> > > > > 
> > > > >  A: SC
> > > > >  B: ACQ
> > > > >  C: Relaxed
> > > > > 
> > > > > Similarly for unlock we want the WRITE_ONCE to happen after
> > > > > osq_wait_next, but in that case we can even rely on the control
> > > > > dependency there.
> > > > 
> > > > Even for the lock-unqueue case, isn't B->C ordered by a control dependency
> > > > because C consists only of stores?
> > > 
> > > Hmm, indeed. So we could go fully relaxed on it I suppose, since the
> > > same is true for the unlock site.
> > 
> > In which case, we should be able to relax the xchg in there (osq_wait_next)
> > too, right?
> 
> Can I have second thoughts an confuse matters again? ;-)
> 
> A RmW-acq is a load-acquire+store. That means the store is _after_ the
> load and thus not required for the completion of the control dependency.
> 
> Therefore the store in question can reorder inside the conditional
> control block's stores.
> 
> Hmm?

Ah yeah, it's the same thing we were discussing the other day! Whilst
there is a form of control dependency from the SC part of the LL/SC
sequence, it doesn't guarantee ordering in the same way that a
load->store control dependency does. That is, it orders subsequent
writes to be afterwards in the coherence order but it doesn't ensure
multi-copy atomicity for readers.

Now, in this case, &lock->tail is only ever accessed by other cmpxchg
operations, so I think it does actually work using just the control
dependency. Worst case, a concurrent osq_wait_next gets a stale value
in the atomic_read, but that's not a correctness problem.

Will
