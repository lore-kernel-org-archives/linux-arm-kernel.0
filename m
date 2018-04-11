From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Apr 2018 11:20:04 +0100
Subject: [PATCH 00/10] kernel/locking: qspinlock improvements
In-Reply-To: <20180406132249.GA7071@andrea>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <20180406132249.GA7071@andrea>
Message-ID: <20180411102003.rjfrcmc4fjukehst@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 03:22:49PM +0200, Andrea Parri wrote:
> On Thu, Apr 05, 2018 at 05:58:57PM +0100, Will Deacon wrote:
> > I've been kicking the tyres further on qspinlock and with this set of patches
> > I'm happy with the performance and fairness properties. In particular, the
> > locking algorithm now guarantees forward progress whereas the implementation
> > in mainline can starve threads indefinitely in cmpxchg loops.
> > 
> > Catalin has also implemented a model of this using TLA to prove that the
> > lock is fair, although this doesn't take the memory model into account:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/
> 
> Nice!  I'll dig into this formalization, but my guess is that our model
> (and axiomatic models "a-la-herd", in general) are not well-suited when
> it comes to study properties such as fairness, liveness...

Maybe someone with a background in formal methods could give a better
answer. How TLA+ works is closer to rmem [1] (operational model,
exhaustive memoised state search) than herd. Liveness verification
requires checking that, under certain fairness properties, some state is
eventually reached. IOW, it tries to show that either all state change
graphs lead to (go through) such state or that there are cycles in the
graph and the state is never reached. I don't know whether herd could be
modified to check liveness. I'm not sure it can handle infinite loops
either (the above model checks an infinite lock/unlock loop on each
CPU and that's easier to implement in a tool with memoised states).

The TLA+ model above assumes sequential consistency, so no memory
ordering taken into account. One could build an operational model in
TLA+ that's equivalent to the axiomatic one (e.g. following the Flat
model equivalence as in [2]), however, liveness checking (at least with
TLA+) is orders of magnitude slower than safety. Any small variation has
an exponential impact on the state space, so likely to be impractical.
For specific parts of the algorithm, you may be able to use a poor man's
ordering by e.g. writing two accesses in two different orders so the
model checks both combinations.

There are papers (e.g. [3]) on how to convert liveness checking to
safety checking but I haven't dug further. I think it's easier/faster if
you do liveness checking with a simplified model and separately check
the safety with respect to memory ordering on tools like herd.

[1] http://www.cl.cam.ac.uk/~sf502/regressions/rmem/
[2] http://www.cl.cam.ac.uk/~pes20/armv8-mca/armv8-mca-draft.pdf
[3] https://www.sciencedirect.com/science/article/pii/S1571066104804109

-- 
Catalin
