From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2018 18:01:54 +0100
Subject: [PATCH 3/3] arm64: IPI each CPU after invalidating the I-cache
 for kernel mappings
In-Reply-To: <1529510537801.73315@nvidia.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
 <1529412495-17525-4-git-send-email-will.deacon@arm.com>
 <1529510537801.73315@nvidia.com>
Message-ID: <20180620170153.GF27776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wed, Jun 20, 2018 at 04:01:29PM +0000, Alexander Van Brunt wrote:
> > When invalidating the instruction cache for a kernel mapping via
> > flush_icache_range(), it is also necessary to flush the pipeline for
> > other CPUs so that instructions fetched into the pipeline before the
> > I-cache invalidation are discarded. For example, if module 'foo' is
> > unloaded and then module 'bar' is loaded into the same area of memory,
> > a CPU could end up executing instructions from 'foo' when branching into
> > 'bar' if these instructions were fetched into the pipeline before 'foo'
> > was unloaded.
> 
> I don't think this fixes the problem. If a CPU is executing 'foo', takes
> an IPI, and returns to find itself executing in the middle of 'bar' there
> is still a problem because the code changed. All this patch does is
> synchronize when two CPUs see 'foo' change to 'bar'.

Right, but that would indicate a catastophic bug in the module code. There
are two sides to this:

1. Code that manages the lifetime of executable mappings. That should all be
   present in the core code, to make sure that we don't e.g. unmap code that
   is being executed.

2. Ensuring that new instructions in an executable mapping are visible to
   the CPU I-side when that CPU decides to branch into the mapping.

This patch series is all about (2). *If* (1) was implemented exclusively
using RCU, then we could probably avoid the IPI and instead ensure that an
RCU grace period ensured all concurrent executors had gone through a context
synchronization event, but unfortunately we can't rely on that.

Will
