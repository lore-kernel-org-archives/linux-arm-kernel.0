From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 14:48:03 +0100
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211133313.GG18828@arm.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
 <20151211121319.GK6356@twins.programming.kicks-ass.net>
 <20151211121759.GE18828@arm.com>
 <20151211122647.GM6356@twins.programming.kicks-ass.net>
 <20151211133313.GG18828@arm.com>
Message-ID: <20151211134803.GP6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 01:33:14PM +0000, Will Deacon wrote:
> On Fri, Dec 11, 2015 at 01:26:47PM +0100, Peter Zijlstra wrote:

> > While we're there, the acquire in osq_wait_next() seems somewhat ill
> > documented too.
> > 
> > I _think_ we need ACQUIRE semantics there because we want to strictly
> > order the lock-unqueue A,B,C steps and we get that with:
> > 
> >  A: SC
> >  B: ACQ
> >  C: Relaxed
> > 
> > Similarly for unlock we want the WRITE_ONCE to happen after
> > osq_wait_next, but in that case we can even rely on the control
> > dependency there.
> 
> Even for the lock-unqueue case, isn't B->C ordered by a control dependency
> because C consists only of stores?

Hmm, indeed. So we could go fully relaxed on it I suppose, since the
same is true for the unlock site.
