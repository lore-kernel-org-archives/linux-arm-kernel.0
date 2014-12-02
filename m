From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:36:59 +0100
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
 drivers
In-Reply-To: <547D84F4.8030204@samsung.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
 <547D84F4.8030204@samsung.com>
Message-ID: <2039644.fesfKXTybP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 10:23:00 Marek Szyprowski wrote:
> >> +static inline void of_iommu_set_ops(struct device_node *np,
> >> +                                   const struct iommu_ops *ops)
> >> +{
> >> +       np->data = (struct iommu_ops *)ops;
> >> +}
> >> +
> >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> >> +{
> >> +       return np->data;
> >> +}
> > This may collide with other users. While use of it is rare, PPC uses
> > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > sets it. There may be some coming usage with the DT overlay code or
> > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > really should try to get rid of this pointer rather than expand it's
> > usage.
> 
> I think that for the initial version it is ok to use np->data. When 
> per-iommu
> controller structure is introduced later, it can be reused also for 
> performing
> of_node to iommu_ops lookup, because IOMMU framework will need to keep track
> on all such iommu controllers anyway.

Agreed. I think in the long run, we will have a 'struct iommu' that is
added into a global linked list and that contains (among other things)
an iommu_ops pointer and a device_node pointer. The of_iommu_get_ops
function then walks the list to find the right iommu instance.

	Arnd
