From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 12 Dec 2013 13:36:43 +0000
Subject: [PATCH 2/3] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20131212120649.GB5367@sirena.org.uk>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
 <1386792029-23148-2-git-send-email-broonie@kernel.org>
 <20131212113512.GC28621@e103034-lin>
 <20131212120649.GB5367@sirena.org.uk>
Message-ID: <20131212133643.GE28621@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 12:06:49PM +0000, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 11:35:12AM +0000, Morten Rasmussen wrote:
> 
> > I know that this is how it is currently done for ARMv7 and one could
> > argue that we should do the same for ARMv8 until we have a better
> > solution. I just want to highlight that setting cpu_power this way is
> > not generally the right thing to do for big.LITTLE. It will have to be
> > fixed eventually.
> 
> Right, there's a good solid reason for all the work on the scheduler.  I
> definitely think we ought to be following the same approach on both
> ARMv7 and ARMv8 to avoid confusion between people based on the platform
> they're working on.

That is fair enough.

> 
> If you're saying that the current ARMv7 code is always worse than doing
> nothing then clearly we ought to be removing that code from ARMv7 rather
> than hurting performance.  I'd been under the impression that what we
> had there was not ideal but better than nothing in mainline rather than
> actively harmful.

For some scenarios it might be better to set cpu_power to reflect the
relative performance, for others it is worse due to the way cpu_power
is currently used in the scheduler.

Setting cpu_power as it is done for v7 may bias the scheduler to put
heavier tasks on big cpus and will generally put more task on big cpus,
which is a good thing for some scenarios. However, if you have parallel
workloads that spawn a worker thread for each cpu and does dynamic work
distribution in user-space (OpenMP applications for example), then
setting cpu_power will put two worker threads on some big cpus and leave
some little cpus idle resulting in slower completion time. It happens on
TC2.

We need the code (or something very similar) later when the scheduler
has been fixed. For v7 it has been left in waiting for that fix, it
doesn't harm when using the reference big.LITTLE patches. We can do the
same for v8 to avoid confusion.

Morten
