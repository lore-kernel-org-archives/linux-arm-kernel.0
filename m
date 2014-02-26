From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Feb 2014 12:32:08 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226005052.GA31120@sirena.org.uk>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
Message-ID: <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 12:50:52AM +0000, Mark Brown wrote:
> On Tue, Feb 25, 2014 at 04:54:11PM +0000, Lorenzo Pieralisi wrote:
> Can I suggest that given the sort of thing we're looking at here it
> might be easier to apply the code as-is and then do any further work
> incrementally?

I think we have enough information to make code complete now, at least
for the topology code, I prefer to merge what's considered to be final.

> > If the device tree does not contain topology information for a CPU,
> > kernel code should set-up topology information for the CPU according
> > to the default values defined in Documentation/cputopology.txt.
> 
> > +		pr_warn("CPU%u: No topology information configured\n", cpuid);
> > +		cpuid_topo->core_id = 0;
> 
> I know this is what the document says and the scheduler copes but it
> does make me a bit nervous if we end up with only some CPUs in this
> undefined state.  I can't point to any practical problems and it's
> going to be the scheduler's fault if it does but I wouldn't be surprised
> if there were issues in cases where there is partial topology
> information (as opposed to either full topology information or none).
> 
> Having said that like I keep saying it seems most sensible to fall back
> to MPIDR if we don't have any better idea; it's guaranteed to be
> available, may well be correct and helps systems that did a good job
> with their hardware.

You have a point. Unless someone feels strongly against this, I would
suggest falling back to MPIDR_EL1 if there is missing or wrong information in
DT.

To do that, you need to scrap the structures initialized from DT
altogether if there is missing or wrong DT information, it is either DT for
all CPUs or MPIDR_EL1 for all CPUs, we can't mix the approaches (and while
at it I'd rather parse the HW MPIDR_EL1 so that you get get the MT bit
from it, which is not present in cpu_logical_map).

Let's sum it up:

- if there is a cpu-map, it takes precedence. If there are missing bits
  of info in the cpu-map we WARN_ON (since this is a firmware bug,
  cpu-map overrides MPIDR_EL1 registers info, if the information in cpu-map
  is wrong or missing we should flag it up and that deserves a WARN_ON)
- if cpu-map is missing, we fall back to MPIDR_EL1 and print a message
  just describing that.

I noticed you will have to add some macros to read MPIDR_EL1 bits in the
process.

Thanks,
Lorenzo
