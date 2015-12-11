From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 13:26:47 +0100
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211121759.GE18828@arm.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
 <20151211121319.GK6356@twins.programming.kicks-ass.net>
 <20151211121759.GE18828@arm.com>
Message-ID: <20151211122647.GM6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 12:18:00PM +0000, Will Deacon wrote:
> On Fri, Dec 11, 2015 at 01:13:19PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 11, 2015 at 12:04:19PM +0000, Will Deacon wrote:
> > > I think Andrew meant the atomic_xchg_acquire at the start of osq_lock,
> > > as opposed to "compare and swap". In which case, it does look like
> > > there's a bug here because there is nothing to order the initialisation
> > > of the node fields with publishing of the node, whether that's
> > > indirectly as a result of setting the tail to the current CPU or
> > > directly as a result of the WRITE_ONCE.
> > 
> > Agreed, this does indeed look like a bug. If confirmed please write a
> > shiny changelog and I'll queue asap.
> 
> Yup. I've failed to reproduce the issue locally, so we'll need to wait
> for Andrew and/or David to get back to us first.

While we're there, the acquire in osq_wait_next() seems somewhat ill
documented too.

I _think_ we need ACQUIRE semantics there because we want to strictly
order the lock-unqueue A,B,C steps and we get that with:

 A: SC
 B: ACQ
 C: Relaxed

Similarly for unlock we want the WRITE_ONCE to happen after
osq_wait_next, but in that case we can even rely on the control
dependency there.


As noted in a previous email, the ACQUIRE for osq_wait_next() does not
come from its use in lock since its on the fail path, and trylock
failure doesn't imply any barriers.

Not should it have RELEASE semantics for its use in unlock, since we
already have that covered by the xchg() done prior.
