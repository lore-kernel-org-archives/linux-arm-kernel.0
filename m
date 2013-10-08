From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 8 Oct 2013 17:20:08 +0200
Subject: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
In-Reply-To: <20131008151007.GD21189@mudshark.cambridge.arm.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
 <1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
 <20131008151007.GD21189@mudshark.cambridge.arm.com>
Message-ID: <20131008152008.GE2935@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:10:07AM -0400, Will Deacon wrote:
> On Tue, Oct 08, 2013 at 10:27:22AM +0100, Andreas Herrmann wrote:
> > Ie. use a mask based on smr_mask_bits to map all stream IDs of an SMMU
> > to one context.
> > 
> > This behaviour is controlled per SMMU node with DT property
> > "arm,smmu-mask-stream-ids" and is only allowed if just a single master
> > is attached to an SMMU. If the option is specified, all stream-ids
> > that are provided in DT for the single master have no relevance.
> > 
> > This is useful/convenient if a master has more than 8 stream-ids or if
> > not all stream-ids are known for a master device.
> 
> Hmmm, this really scares me. What's the use-case? I worry about people
> inadvertently putting devices into an iommu domain because they happen to be
> included in a mask. Your solution seems to be targetting a single master
> with lots of IDs -- is this a PCI RC?

No, it's the sata device. It has 0xf as smr_mask_bits.

But it's just one device and it (usually) should be mapped to one
context -- no matter how many StreamIDs are really used.

(PCI RC has also 0xf but there it's clear there can be multiple devices
and the masking should not be done.)


Andreas
