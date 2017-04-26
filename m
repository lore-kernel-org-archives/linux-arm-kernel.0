From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Apr 2017 10:48:46 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
In-Reply-To: <CA+sq2CfNYKs8Ub4bWTM1GRGO=06N-Tn7BkehwJE6LpZvC0=R=Q@mail.gmail.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
 <20170424160841.GS12323@arm.com>
 <CA+sq2CeyVm4pcAVME7OAFVxpOcSJc5CsP0vz3ypDkSxdx0SKnQ@mail.gmail.com>
 <20170424170518.GU12323@arm.com>
 <CA+sq2CfNYKs8Ub4bWTM1GRGO=06N-Tn7BkehwJE6LpZvC0=R=Q@mail.gmail.com>
Message-ID: <20170426094846.GD21744@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 02:50:04PM +0530, Sunil Kovvuri wrote:
> On Mon, Apr 24, 2017 at 10:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Apr 24, 2017 at 10:26:53PM +0530, Sunil Kovvuri wrote:
> >> On Mon, Apr 24, 2017 at 9:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
> >> >> From: Geetha <gakula@cavium.com>
> >> >>
> >> >> When large memory is being unmapped, huge no of tlb invalidation cmds are
> >> >> submitted followed by a SYNC command. This sometimes hits CMD queue full and
> >> >> poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.
> >> >>
> >> >> Although there is no functional issue, error message confuses user. Hence increased
> >> >> poll timeout to 500us
> >> >
> >> > Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
> >> > have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
> >> > entries") applied?
> >>
> >> Yes it's VFIO teardown and again yes the above fix is applied.
> >> But i didn't get how above fix is related.
> >> TLB invalidation commands are submitted at 'arm_smmu_tlb_inv_range_nosync()'
> >> and it's a loop over granule size.
> >>
> >> 1357         do {
> >> 1358                 arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> >> 1359                 cmd.tlbi.addr += granule;
> >> 1360         } while (size -= granule);
> >>
> >> So if invalidation size is big then huge no of invalidation commands
> >> will be submitted
> >> irrespective of fix that you pointed above, right ?
> >
> > VFIO has some logic to batch up invalidations, but this didn't work properly
> > for us without the fix above. However, I guess you have a huge memory range
> > that's mapped with 2M sections or something, so there are still loads of
> > entries to invalidate.
> >
> > I would much prefer it if VFIO could just teardown the whole address space
> > so that we could do an invalidate all, but there's a chicken-and-egg problem
> > with page accounting iirc.
> >
> 
> We can definitely look into this from VFIO perspective but for now I am guessing
> this patch is fine, as no functionality is being changed.
> What do you say ?

Thinking about it some more, I'd rather we rework the polling loop so that:

1. It's structured more like the arm-smmu.c TLB loop queued for 4.11
   (so we don't udelay(1) if the thing doesn't sync immediately)

2. Have a larger timeout for the drain case, which I think is what you're
   running into. This could even be 1s, like arm-smmu.c.

Will
