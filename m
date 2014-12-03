From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 20:57:50 +0100
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
 drivers
In-Reply-To: <CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
 <CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
Message-ID: <2579924.PPXuLn3o19@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 14:16:57 Grant Likely wrote:
> On Mon, Dec 1, 2014 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On Mon, Dec 1, 2014 at 10:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> >>
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
> >
> > This may collide with other users. While use of it is rare, PPC uses
> > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > sets it. There may be some coming usage with the DT overlay code or
> > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > really should try to get rid of this pointer rather than expand it's
> > usage.
> >
> > I didn't see a user of this. I'm guessing that is coming in a SMMU patch?
> 
> Good catch. This is not good. The data pointer should be avoided since
> there are no controls over its use. Until a better solution can be
> implemented, probably the safest thing to do is add a struct iommu_ops
> pointer to struct device_node. However, assuming that only a small
> portion of nodes will actually have iommu_ops set, I'd rather see a
> separate registry that matches device_nodes to iommu_ops.

Fair enough. Will, can you take a copy of drivers/dma/of-dma.c and
adapt it as needed? It should be exactly what we need to start
out and can be extended and generalized later.

	ARnd
