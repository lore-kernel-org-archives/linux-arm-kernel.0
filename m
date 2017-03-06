From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 6 Mar 2017 12:34:36 +0000
Subject: IOMMU in bypass mode by default on ARM64, instead of command line
 option
In-Reply-To: <CA+sq2CdawVNqEjpuzkdmEDbvW69aXufHJAEoH_g55=sr2d1rOw@mail.gmail.com>
References: <CA+sq2CdawVNqEjpuzkdmEDbvW69aXufHJAEoH_g55=sr2d1rOw@mail.gmail.com>
Message-ID: <07f4a3d7-f41b-2459-65c6-729f3a692e7d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/17 16:59, Sunil Kovvuri wrote:
> Hi,
> 
> I did see some patches submitted earlier to enable user to boot kernel
> with SMMU in bypass mode using a command line parameter.
> 
> Idea sounds good, but just wondering if it would be better if things are done in
> reverse i.e put SMMU in bypass mode by default on host and provide
> option to user to enable SMMU via bootargs. Reason i am saying this is
> with SMMU
> enabled on host, performance of devices drops down to pathetic levels, not
> because of HW but mostly because of ARM IOMMU implementation in kernel.
> 
> On a Cavium's ARM64 platform below are some performance numbers
> with and without SMMU enabled on host.
> =======================================================
> Iperf numbers with Intel 40G NIC: Without SMMU: 31.5Gbps, with SMMU: 820Mbps
> FIO perf with Intel NVMe disk:
> 
> With SMMU on
> =============
> 
> Random read:
> --------------------
> 
> TEST:Rand MIX:0 BLOCK_SIZE:4096 THREADS:32 IODEPTH:32 IOPS:69579
> MBPS:284 TOTALCPU
> TEST:Rand MIX:0 BLOCK_SIZE:16384 THREADS:32 IODEPTH:32 IOPS:25299
> MBPS:414 TOTALCPU:
> TEST:Rand MIX:0 BLOCK_SIZE:65536 THREADS:32 IODEPTH:32 IOPS:6264
> MBPS:410 TOTALCPU:
> TEST:Rand MIX:0 BLOCK_SIZE:1048576 THREADS:32 IODEPTH:32 IOPS:381
> MBPS:399 TOTALCPU:
> 
> Random write
> -------------------
> 
> TEST:Rand MIX:100 BLOCK_SIZE:4096 THREADS:32 IODEPTH:32 IOPS:77159
> MBPS:316 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:16384 THREADS:32 IODEPTH:32 IOPS:27283
> MBPS:447 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:65536 THREADS:32 IODEPTH:32 IOPS:6634
> MBPS:434 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:1048576 THREADS:32 IODEPTH:32 IOPS:385
> MBPS:403 TOTALCPU:
> 
> 
> With SMMU off
> ==============
> 
> Random read
> ----------------------
> 
> TEST:Rand MIX:0 BLOCK_SIZE:4096 THREADS:32 IODEPTH:32
> IOPS:410392MBPS:1680 TOTALCPU:
> TEST:Rand MIX:0 BLOCK_SIZE:16384 THREADS:32 IODEPTH:32 IOPS:152583
> MBPS:2499 TOTALCPU:
> TEST:Rand MIX:0 BLOCK_SIZE:65536 THREADS:32 IODEPTH:32
> IOPS:37144MBPS:2434 TOTALCPU:
> TEST:Rand MIX:0 BLOCK_SIZE:1048576 THREADS:32 IODEPTH:32 IOPS:2386
> MBPS:2501 TOTALCPU:
> 
> Random write
> ----------------------
> 
> TEST:Rand MIX:100 BLOCK_SIZE:4096 THREADS:32 IODEPTH:32 IOPS:99678
> MBPS:408 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:16384 THREADS:32 IODEPTH:32 IOPS:113912
> MBPS:1866 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:65536 THREADS:32 IODEPTH:32 IOPS:28871
> MBPS:1892 TOTALCPU:
> TEST:Rand MIX:100 BLOCK_SIZE:1048576 THREADS:32 IODEPTH:32 IOPS:1828
> MBPS:1916 TOTALCPU:
> =====================================================
> 
> Performance with SMMU enabled drops to <1/5th on NVMe disk and on NIC
> it's down to nothing. Problem seems to be with high contention for
> locks which are
> being used for IOVA maintenance and while updating translation tables inside
> ARM SMMUv2/v3 drivers.

Yes, we're well aware that there's a whole load of potential lock
contention where there doesn't really need to be. The performance
optimisation effort has mostly been waiting for sufficiently big
systems/workloads to start appearing in order to measure and justify it.
Consider yourself the winner :)

> Intel and AMD IOMMU drivers does make use of per-cpu IOVA caches to
> reduce the impact of 'iova_rbtree_lock' but ARM is yet to catchup.
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/iommu/iova.c?id=9257b4a206fc0229dd5f84b78e4d1ebf3f91d270
> 
> And the other lock is 'pgtbl_lock' used in ARM SMMUv2/V3 drivers.

Do you have any measurements to show how the contention on those two
locks compares? That would be useful to start with.

> Appreciate any feedback on the following
> # Has anyone done any sort performance benchmarking before and saw
>    similar results ?
> # Is there a possibility of improvement here, has anyone already started
>    working on these ?

Very much so. I've got a patch to convert iommu-dma over to
alloc_iova_fast() which I need to rebase and finish debugging, but hope
to send out in the next couple of weeks. Will has some ideas for
io-pgtable scalability that we've not yet found the time to look into
properly (I still have an old experiment up at [1], but I think we
identified some case in which it's broken).

> # Would it be a good idea to use ARM IOMMU only with VFIO/Virtualization
>    till things improve in this area, simply because kernel command
> line parameter
>    might be good from developer's perspective but in a deployment environment
>    with a standard distro, don't think it's a feasible option.

If you want to disable IOMMU DMA ops by default, you'll first have to
resolve things with the video/display/etc. folks who needed the IOMMU
DMA ops for their stuff to work properly at all ;)

Robin.

[1]:http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/pgtable

> 
> Thanks,
> Sunil.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
