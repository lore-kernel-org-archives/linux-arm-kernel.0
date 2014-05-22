From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 May 2014 11:35:51 +0100
Subject: [PATCH 1/2] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <alpine.LFD.2.11.1405201716460.17310@knanqh.ubzr>
References: <1400545421-28067-1-git-send-email-broonie@kernel.org>
 <20140520173727.GD28293@arm.com>
 <alpine.LFD.2.11.1405201716460.17310@knanqh.ubzr>
Message-ID: <20140522103550.GA24636@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:31:39PM +0100, Nicolas Pitre wrote:
> On Tue, 20 May 2014, Catalin Marinas wrote:
> 
> > On Tue, May 20, 2014 at 01:23:40AM +0100, Mark Brown wrote:
> > > In heterogeneous systems like big.LITTLE systems the scheduler will be
> > > able to make better use of the available cores if we provide power numbers
> > > to it indicating their relative performance. Do this by parsing the CPU
> > > nodes in the DT.
> > 
> > Last time we discussed these two patches, my understanding was that the
> > mainline scheduler doesn't behave any better on big.LITTLE with this
> > additional information, unless you also have additional out of tree b.L
> > MP patches. Vincent is also cleaning up some of the cpu_power usage in
> > the scheduler.
> > 
> > So unless there are clear benefits in providing such information to the
> > mainline scheduler, I don't plan to merge them for the time being (I'm
> > also not convinced of the numbers in the second patch, they need some
> > benchmarking on real hardware).
> 
> We are indeed in the process of working out how to use this information 
> in the scheduler, submitting patches, etc.  Thing is, we risk seeing the 
> scheduler maintainers saying: "unless there are clear users of those 
> enhancements to the mainline scheduler, we don't plan to merge them for 
> the time being."

I'm pretty sure they know the big.LITTLE story and we can reiterate it's
required for arm64 as well (though not sure they see it as different
from arm in this context).

I really appreciate the work you and Vincent are doing to clarify the
cpu_power usage in the scheduler. But for the time being, its only use
seems to be for SMT and rather problematic for big.LITTLE
(https://lkml.org/lkml/2014/3/28/197).

I also think the arch_scale_freq_power() name is wrong in the maximum
capacity context. What if we decide that we need frequency invariant
task load you realise that you actually need arch_scale_freq_power() to
vary with the CPU frequency for normalisation rather than the big.LITTLE
performance differences? But I see you are already trying to clean this
up as well (https://lkml.org/lkml/2014/5/14/625), which is good, but
let's wait until these patches go in (and there is already an user,
though the behaviour isn't correct until we get Vincent's patches in).

> It might be more productive to merge _something_ first, and doing so on 
> the architecture side is certainly the least intrusive initial move.

You are already renaming the arm arch_scale_freq_power(), why would you
want to create more work for you by having to re-write parts of arm64 as
well once you get to a consensus on scheduler changes?

Just to be clear, I'm not against Mark's patch but I don't see any value
in pushing it into mainline now, given that it is likely to be changed
in the future following the work you and Vincent are doing.

-- 
Catalin
