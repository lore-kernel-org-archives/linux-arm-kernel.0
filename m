From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 21:01:56 +0100
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <20141114192754.GB9291@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <3630936.HRExZgJGyp@wuerfel> <20141114192754.GB9291@arm.com>
Message-ID: <2043949.GdM3BkS8d4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 19:27:54 Will Deacon wrote:
> 
> > At the moment, iommu_ops is a structure that can get used for any
> > number of iommus of the same type, but by putting per-device private
> > data into the same structure you have to duplicate it per instance.
> 
> I'm not sure I agree -- the pgsize_bitmap, for example, could vary between
> different implementations of the same IOMMU. I think we already have this in
> Juno (some SMMUs can only do 64k pages, whilst others can do 4k and 64k).

Ah, I hadn't noticed that, it should be in the 'struct iommu' then of course,
not in iommu_ops.

> > I think rather than adding a .priv pointer to iommu_ops, we should do
> > the same thing that a lot of other subsystems have:
> > 
> > /* generic structure */
> > struct iommu {
> >       struct iommu_ops *ops;
> >       /* possibly other generic per-instance members */
> > };
> > 
> > /* driver specific structure */
> > struct arm_smmu {
> >       struct iommu iommu;
> > 
> >       /* smmu specific members */
> > };
> > static inline struct arm_smmu *to_arm_smmu(struct iommu *iommu)
> > {
> >       return container_of(iommu, struct arm_smmu, iommu);
> > }
> 
> Regardless of the arguments above, I think this layout is cleaner. We could
> also move the pgsize_bitmap into struct iommu in that case, however, that
> would be a more invasive patch series than I what I currently have.

Right, it can be done as a follow-up. It's certainly not urgent.
 
> If I do another version of the patch, I can easily add a struct iommu and
> stash that in the device_node data for the IOMMU instead of directly
> putting the ops there. That's at least a step in the right direction.

Sounds good, yes. Alternatively, why not do the pointer in the opposite
direction and put a 'struct device_node *dn' and a list_head into
'struct iommu'. This means you will have to traverse the list of iommus
in of_iommu_get_ops, but I think it's safe to assume this is a short
list and it gets walked rarely. It would be somewhat cleaner not to have
to use device_node->data this way.

	Arnd
