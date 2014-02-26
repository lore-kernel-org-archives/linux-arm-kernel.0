From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Feb 2014 15:48:58 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226144610.GA2394@sirena.org.uk>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
 <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
 <20140226144610.GA2394@sirena.org.uk>
Message-ID: <20140226154858.GC10246@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 02:46:10PM +0000, Mark Brown wrote:
> On Wed, Feb 26, 2014 at 12:32:08PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Feb 26, 2014 at 12:50:52AM +0000, Mark Brown wrote:
> > > Having said that like I keep saying it seems most sensible to fall back
> > > to MPIDR if we don't have any better idea; it's guaranteed to be
> > > available, may well be correct and helps systems that did a good job
> > > with their hardware.
> 
> > You have a point. Unless someone feels strongly against this, I would
> > suggest falling back to MPIDR_EL1 if there is missing or wrong information in
> > DT.
> 
> Catalin seemed very concerned about any use at all of MPIDR, that's why
> the code was removed originally.  Catalin?

My concern is that the MPIDR is just considered a unique ID. The ARMv8
relaxes the requirement so that it no longer needs to start at 0 and
increase monotonically. I checked with the architecture guys here and
they still expect the affinity hierarchy to be described by MPIDR but we
can have holes in the range for certain levels (i.e. an affinity level
may not start at 0 and may not even increase monotonically for
subsequent CPUs).

So we can either add a tolerant MPIDR parsing or we simply assume that
the topology is _flat_ when DT doesn't provide the information.

-- 
Catalin
