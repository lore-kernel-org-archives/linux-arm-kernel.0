From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 8 Oct 2013 18:40:21 +0200
Subject: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
In-Reply-To: <20131008152008.GE2935@alberich>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
 <1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
 <20131008151007.GD21189@mudshark.cambridge.arm.com>
 <20131008152008.GE2935@alberich>
Message-ID: <20131008164021.GH2935@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 05:20:08PM +0200, Andreas Herrmann wrote:
> On Tue, Oct 08, 2013 at 11:10:07AM -0400, Will Deacon wrote:
> > On Tue, Oct 08, 2013 at 10:27:22AM +0100, Andreas Herrmann wrote:
> > > Ie. use a mask based on smr_mask_bits to map all stream IDs of an SMMU
> > > to one context.
> > > 
> > > This behaviour is controlled per SMMU node with DT property
> > > "arm,smmu-mask-stream-ids" and is only allowed if just a single master
> > > is attached to an SMMU. If the option is specified, all stream-ids
> > > that are provided in DT for the single master have no relevance.
> > > 
> > > This is useful/convenient if a master has more than 8 stream-ids or if
> > > not all stream-ids are known for a master device.
> > 
> > Hmmm, this really scares me. What's the use-case? I worry about people
> > inadvertently putting devices into an iommu domain because they happen to be
> > included in a mask. Your solution seems to be targetting a single master
> > with lots of IDs -- is this a PCI RC?
> 
> No, it's the sata device. It has 0xf as smr_mask_bits.
> 
> But it's just one device and it (usually) should be mapped to one
> context -- no matter how many StreamIDs are really used.

To be more specific: For SATA I'd need to specify 10 StreamIds. This
would

(1) exceed MAX_MASTER_STREAMIDS (currently it's 8)

   (Can easily be fixed by adapting a macro.)

(2) exceed number of available SMR groups to map the IDs to a context.

   This can be solved by caclulating an appropriate mask for the
   mapping (but with a non-power-of-two number of StreamIds that's
   already non-trivial -- for the trivial case I have some code to do
   this).

Both problems are avoided by introducing this patch -- use
smr_mask_bits to map all StreamIDs to the same context and be done
with it. (for the "single-master-SMMU" case)


Andreas

PS: I think (2) needs to be addressed sooner or later. We should use
    only as many SMR groups as really required -- ie. use masking of
    StreamIds if possible. If more than one StreamID is given for a
    master it might be possible to calculate a mask for a
    (power-of-two) number of adjacent StreamIds and then use only one
    SMR group to map these IDs to a context. (But I think that should
    only be done if multiple masters are attached to an SMMU.)
