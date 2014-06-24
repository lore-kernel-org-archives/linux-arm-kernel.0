From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 20:20:56 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140624181150.GB4067@arm.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <53A9BC18.2090106@codeaurora.org> <20140624181150.GB4067@arm.com>
Message-ID: <4855051.rhxSrNMNLg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 19:11:50 Will Deacon wrote:
> On Tue, Jun 24, 2014 at 06:57:44PM +0100, Olav Haugan wrote:
> > On 6/24/2014 2:18 AM, Will Deacon wrote:
> > > On Sat, Jun 21, 2014 at 12:16:25AM +0100, Olav Haugan wrote:
> > >> We have multiple-master SMMUs and each master emits a variable number of
> > >> StreamIDs. However, we have to apply a mask (the ARM SMMU spec allows
> > >> for this) to the StreamIDs due to limited number of StreamID 2 Context
> > >> Bank entries in the SMMU. If my understanding is correct we would
> > >> represent this in the DT like this:
> > >>
> > >>    iommu {
> > >>            #address-cells = <2>;
> > >>            #size-cells = <0>;
> > >>    };
> > >>
> > >>    master at a {
> > >>            ...
> > >>            iommus = <&iommu StreamID0 MASK0>,
> > >>                     <&iommu StreamID1 MASK1>,
> > >>                     <&iommu StreamID2 MASK2>;
> > >>    };
> > > 
> > > Stupid question, but why not simply describe the masked IDs? What use does
> > > the `raw' ID have to Linux?
> > 
> > We do describe the masked StreamID (SID) but we need to specify the mask
> > that the SMMU should apply to the incoming SIDs, right?
> > 
> > We have a bus master that emits 43 unique SIDs. However, we have only 40
> > SMMU_SMRn registers in the SMMU. So we need to mask out some of the
> > incoming SID bits so that the 43 SIDs can match one of 40 entries in the
> > SMR.
> 
> Hmm, so you're talking about stream matching, right? That doesn't belong in
> the device-tree. I appreciate that the current driver does a terrible job at
> allocating the SMRs (it's bloody difficult!), but we should try to improve
> the dynamic behaviour instead of moving configuration of the SMMU out into
> device-tree, where it's inflexible at best.
> 
> There have been patches previously posted by Andreas Herrmann helping here.
> I'd be glad to see them revived.

Note that there are areas where we have in the past decided that dynamic
configuration is just too hard for the kernel to do and that we're better
off putting the configuration into DT. Pinctrl and clocks are at least
partially in that category.

It's always best if you can get the kernel to do things in the ideal
way where that is possible, but getting there may be just not worth it.

I have no idea where it should be for SMMU, but it's something to consider:
if you can take reasonable shortcuts by reading parts of the configuration
from DT, you may just as well do that.

	Arnd
