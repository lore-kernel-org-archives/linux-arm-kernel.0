From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 18:05:18 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
In-Reply-To: <CA+sq2CeyVm4pcAVME7OAFVxpOcSJc5CsP0vz3ypDkSxdx0SKnQ@mail.gmail.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
 <20170424160841.GS12323@arm.com>
 <CA+sq2CeyVm4pcAVME7OAFVxpOcSJc5CsP0vz3ypDkSxdx0SKnQ@mail.gmail.com>
Message-ID: <20170424170518.GU12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:26:53PM +0530, Sunil Kovvuri wrote:
> On Mon, Apr 24, 2017 at 9:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
> >> From: Geetha <gakula@cavium.com>
> >>
> >> When large memory is being unmapped, huge no of tlb invalidation cmds are
> >> submitted followed by a SYNC command. This sometimes hits CMD queue full and
> >> poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.
> >>
> >> Although there is no functional issue, error message confuses user. Hence increased
> >> poll timeout to 500us
> >
> > Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
> > have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
> > entries") applied?
> 
> Yes it's VFIO teardown and again yes the above fix is applied.
> But i didn't get how above fix is related.
> TLB invalidation commands are submitted at 'arm_smmu_tlb_inv_range_nosync()'
> and it's a loop over granule size.
> 
> 1357         do {
> 1358                 arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> 1359                 cmd.tlbi.addr += granule;
> 1360         } while (size -= granule);
> 
> So if invalidation size is big then huge no of invalidation commands
> will be submitted
> irrespective of fix that you pointed above, right ?

VFIO has some logic to batch up invalidations, but this didn't work properly
for us without the fix above. However, I guess you have a huge memory range
that's mapped with 2M sections or something, so there are still loads of
entries to invalidate.

I would much prefer it if VFIO could just teardown the whole address space
so that we could do an invalidate all, but there's a chicken-and-egg problem
with page accounting iirc.

Will
