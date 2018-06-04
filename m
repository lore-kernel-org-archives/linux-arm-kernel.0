From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Mon, 4 Jun 2018 19:34:10 +0000
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <20180604091609.GD9482@arm.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
 <20180530090044.GA2452@arm.com>
 <1527788750049.85185@nvidia.com>,<20180604091609.GD9482@arm.com>
Message-ID: <1528140881044.41145@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__flush_icache_all all cache is slow in large systems. It flushes the instruction caches cache in the inner-shareable domain. That includes other NUMA nodes in multi-socket systems. The CPU issuing the invalidate has to wait for all of the other CPUs to complete the invalidate instruction. The remote CPU's responding to the request all need to slow down.

In contrast, flushes by range can be checked in a snoop filter to see if the addresses are relevant to the CPU. So, it scales to systems with more than two clusters much better.

The flush ignores the VMID. So, one guest OS can slow down others. That creates a big covert channel between guests unless the hypervisor traps and emulates it by invalidating an entire VMID. By flushing by VA range, the hardware only flushes lines associated with the VMID, ASID, and VA associated with the line.

Selfishly, NVIDIA's Denver CPU's are even more sensitive because the optimized code stored in DRAM is effectively a very large (on the order of 64 MB) instruction cache. "ic ialluis" can result in the entire optimization cache for all guests to be invalidated.

I am aware that the arguments I made apply to TLB invalidates and the other places that Linux calls __flush_icache_all. But, that doesn't mean I don't like those either. For now, I just don't want more calls to __flush_icache_all.

Alex VB
________________________________________
From: Will Deacon <will.deacon@arm.com>
Sent: Monday, June 4, 2018 2:16 AM
To: Rohit Khanna
Cc: catalin.marinas at arm.com; robin.murphy at arm.com; mark.rutland at arm.com; Suzuki.Poulose at arm.com; Bo Yan; Alexander Van Brunt; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: alternative:flush cache with unpatched code

On Thu, May 31, 2018 at 05:45:11PM +0000, Rohit Khanna wrote:
> Will, thanks for the comments.
> I will push a new patch set.
> We want to avoid using __flush_icache_all as much as possible and hence
> trying to flush cache by range.

Why? We're going to do it once at boot and once on each module load, so I
can't see it being a performance concern.

Will
