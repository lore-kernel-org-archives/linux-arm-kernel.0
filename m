From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 2 Dec 2014 13:05:24 +0100
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <2039644.fesfKXTybP@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
 <547D84F4.8030204@samsung.com> <2039644.fesfKXTybP@wuerfel>
Message-ID: <20141202120523.GA7134@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 10:36:59AM +0100, Arnd Bergmann wrote:
> On Tuesday 02 December 2014 10:23:00 Marek Szyprowski wrote:
> > >> +static inline void of_iommu_set_ops(struct device_node *np,
> > >> +                                   const struct iommu_ops *ops)
> > >> +{
> > >> +       np->data = (struct iommu_ops *)ops;
> > >> +}
> > >> +
> > >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > >> +{
> > >> +       return np->data;
> > >> +}
> > > This may collide with other users. While use of it is rare, PPC uses
> > > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > > sets it. There may be some coming usage with the DT overlay code or
> > > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > > really should try to get rid of this pointer rather than expand it's
> > > usage.
> > 
> > I think that for the initial version it is ok to use np->data. When 
> > per-iommu
> > controller structure is introduced later, it can be reused also for 
> > performing
> > of_node to iommu_ops lookup, because IOMMU framework will need to keep track
> > on all such iommu controllers anyway.
> 
> Agreed. I think in the long run, we will have a 'struct iommu' that is
> added into a global linked list and that contains (among other things)
> an iommu_ops pointer and a device_node pointer. The of_iommu_get_ops
> function then walks the list to find the right iommu instance.

If we end up doing that, how is this any different from what Hiroshi and
I initially proposed over a year ago (and then again earlier this year)?

The only remaining difference would be that this current proposal needs
IOMMUs to be registered even before other devices are instantiated for
no apparent reason other than ordering. The original proposal allowed
the IOMMU driver to register just like any other driver and ordering to
be handled via deferred probing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/124488df/attachment.sig>
