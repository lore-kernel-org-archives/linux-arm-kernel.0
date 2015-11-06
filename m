From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 06 Nov 2015 20:39:59 +1100
Subject: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <563C5AFD.9040102@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <20151106025844.GA28859@us.ibm.com> <563C5AFD.9040102@linux.vnet.ibm.com>
Message-ID: <1446802799.21859.1.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-11-06 at 13:17 +0530, Madhavan Srinivasan wrote:
> On Friday 06 November 2015 08:28 AM, Sukadev Bhattiprolu wrote:
> > Peter Zijlstra [peterz at infradead.org] wrote:
> > > On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
> > > > Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> > > > and adds offsetof macro for the same. It extends perf_reg_value()
> > > > to use reg idx to decide on struct to return value from.
> > > 
> > > Why; what's in those regs?
> > 
> > Those are PMU control registers/counters (in Patch 2) that are of
> > interest only in the context of a PMU interrupt and not relevant
> > to ptrace itself.
> 
> Yes. Thats right.

> > Could we add those registers to 'struct pt_regs' anyway?
> 
> I would prefer not to. Since as you mentioned, these are
> not relevant to ptrace. Currently patch 2, adds only few
> pmu registers, but would like to include more.

You can't just add them to pt_regs, it's part of the userspace ABI.

We could define a kernel internal version of pt_regs, but I don't think we want
to for this.

If we did that would bloat pt_regs for all users in the kernel, when we really
only want these regs for perf.

cheers
