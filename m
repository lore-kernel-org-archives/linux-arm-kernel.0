From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 16:00:06 +0100
Subject: [PATCH 8/9] iommu: add support for ARM Ltd. System MMU
 architecture
In-Reply-To: <20130621141306.GJ11309@8bytes.org>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-9-git-send-email-will.deacon@arm.com>
 <20130620212646.GG11309@8bytes.org>
 <20130621102318.GB7766@mudshark.cambridge.arm.com>
 <20130621141306.GJ11309@8bytes.org>
Message-ID: <20130621150006.GG7766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 03:13:07PM +0100, Joerg Roedel wrote:
> On Fri, Jun 21, 2013 at 11:23:18AM +0100, Will Deacon wrote:
> > The results were that the memory-to-memory DMA didn't show any corruption. I
> > also managed to tickle access faults by messing around with the permissions,
> > then remap the buffers and resume the transfers.
> 
> That sounds pretty conclusive. So when real hardware shows up it should
> work reasonably well.

Fingers crossed. Of course, as I get to run on real RTL I'll address any
issues that might crop up.

> > > > +static struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
> > > > +{
> > > > +	struct arm_smmu_device *parent, *tmp;
> > > > +
> > > > +	if (!smmu->parent_of_node)
> > > > +		return NULL;
> > > > +
> > > > +	list_for_each_entry_safe(parent, tmp, &arm_smmu_devices, list)
> > > > +		if (parent->dev->of_node == smmu->parent_of_node)
> > > > +			return parent;
> > > 
> > > Why do you need the _safe variant here? You are not changing the list in
> > > this loop so you should be fine with list_for_each_entry().
> > 
> > For a system with multiple SMMUs (regardless of chaining), couldn't this
> > code run in parallel with probing of another SMMU (which has to add to the
> > arm_smmu_devices list)? The same applies for device removal, which could
> > perhaps be driven from some power-managment code.
> 
> Well, the '_safe' does not mean it is safe from concurrent list
> manipulations. If you want to protect from that you still need a lock.
> The '_safe' variant only allows to remove the current element from the
> list while traversing it.

Damn, I was hoping to avoid locking on the map path. In fact, this is a good
argument to go with your suggestion below (otherwise I'd need to use
reader/writer locks which seem to be frowned on).

> > > > +	do {
> > > > +		phys_addr_t output_mask = (1ULL << smmu->s2_output_size) - 1;
> > > > +		if ((phys_addr_t)iova & ~output_mask)
> > > > +			return -ERANGE;
> > > > +	} while ((smmu = find_parent_smmu(smmu)));
> > > 
> > > This looks a bit too expensive to have in the map path. How about saving
> > > something like an effective_output_mask (or output_size) which contains
> > > the logical OR of every mask up the path? This would make this check a
> > > lot cheaper.
> > 
> > As mentioned in the DT binding thread, it's rare that this loop would
> > execute more than once, and largely inconceivable that it would execute more
> > than twice, so I don't know how much we need to worry about the cost.
> 
> But still, this code is a challenge for the branch-predictor, plus
> the additional function calls to find_parent_smmu(). I still think it is
> worth to optimize this away. The map function is supposed to be a
> fast-path function.

Yes, the locking I'd need to introduce in find_parent_smmu seals the deal.
I'll have a go at constructing the mask statically for each SMMU (although I
think I want to use logical AND rather than OR).

Cheers,

Will
