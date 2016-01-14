From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 14 Jan 2016 08:16:04 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114120445.GB15828@arm.com>
References: <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
Message-ID: <20160114161604.GT3818@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 12:04:45PM +0000, Will Deacon wrote:
> On Wed, Jan 13, 2016 at 12:58:22PM -0800, Leonid Yegoshin wrote:
> > On 01/13/2016 12:48 PM, Peter Zijlstra wrote:
> > >On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:
> > >
> > >>I ask HW team about it but I have a question - has it any relationship with
> > >>replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?
> > >Of course. If you cannot explain the semantics of the primitives you
> > >introduce, how can we judge the patch.
> > >
> > >
> > You missed a point - it is a question about replacement of SYNC with
> > lightweight primitives. It is NOT a question about multithread system
> > behavior without any SYNC. The answer on a latest Will's question lies in
> > different area.
> 
> The reason we (Peter and I) care about this isn't because we enjoy being
> obstructive. It's because there is a whole load of core (i.e. portable)
> kernel code that is written to the *kernel* memory model. For example,
> the scheduler, RCU, mutex implementations, perf, drivers, you name it.
> 
> Consequently, it's important that the architecture back-ends implement
> these portable primitives (e.g. smp_mb()) in a way that satisfies the
> kernel memory model so that core code doesn't need to worry about the
> underlying architecture for synchronisation purposes. You could turn
> around and say "but if MIPS gets it wrong, then that's MIPS's problem",
> but actually not having a general understanding of the ordering guarantees
> provided by each architecture makes it very difficult for us to extend
> the kernel memory model in such a way that it can be implemented
> efficiently across the board *and* relied upon by core code.

What Will said!

Yes, you can cut corners within MIPS architecture-specific code,
but primitives that are used in the core kernel really do need to
work as expected.

							Thanx, Paul

> The virtio patch at the start of the thread doesn't particularly concern
> me. It's the other patches you linked to that implement acquire/release
> that have me worried.
> 
> Will
> 
