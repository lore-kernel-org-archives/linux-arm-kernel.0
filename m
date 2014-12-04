From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Dec 2014 10:21:27 +0000
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <3152553.esaQuZiCgi@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2579924.PPXuLn3o19@wuerfel> <20141204094953.GA13224@arm.com>
 <3152553.esaQuZiCgi@wuerfel>
Message-ID: <20141204102127.GF13224@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 10:10:17AM +0000, Arnd Bergmann wrote:
> On Thursday 04 December 2014 09:49:53 Will Deacon wrote:
> > On Wed, Dec 03, 2014 at 07:57:50PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 02 December 2014 14:16:57 Grant Likely wrote:
> > > > On Mon, Dec 1, 2014 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> > > > > On Mon, Dec 1, 2014 at 10:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > > >>
> > > > >> +static inline void of_iommu_set_ops(struct device_node *np,
> > > > >> +                                   const struct iommu_ops *ops)
> > > > >> +{
> > > > >> +       np->data = (struct iommu_ops *)ops;
> > > > >> +}
> > > > >> +
> > > > >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > > > >> +{
> > > > >> +       return np->data;
> > > > >> +}
> > > > >
> > > > > This may collide with other users. While use of it is rare, PPC uses
> > > > > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > > > > sets it. There may be some coming usage with the DT overlay code or
> > > > > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > > > > really should try to get rid of this pointer rather than expand it's
> > > > > usage.
> > > > >
> > > > > I didn't see a user of this. I'm guessing that is coming in a SMMU patch?
> > > > 
> > > > Good catch. This is not good. The data pointer should be avoided since
> > > > there are no controls over its use. Until a better solution can be
> > > > implemented, probably the safest thing to do is add a struct iommu_ops
> > > > pointer to struct device_node. However, assuming that only a small
> > > > portion of nodes will actually have iommu_ops set, I'd rather see a
> > > > separate registry that matches device_nodes to iommu_ops.
> > > 
> > > Fair enough. Will, can you take a copy of drivers/dma/of-dma.c and
> > > adapt it as needed? It should be exactly what we need to start
> > > out and can be extended and generalized later.
> > 
> > Sure, I'll add this to my list of stuff to do for 3.20.
> 
> Does that mean the we don't get any of the patches for 3.19 despite the
> Acks?

Hmm, I don't know how useful they are without the get/set ops and I don't
think I can get those ready for 3.19 given where we currently are.

Grant's suggestion of adding an iommu_ops pointer to device_node would work
as a temporary hack, but anything more advanced is going to need proper
review.

Will
