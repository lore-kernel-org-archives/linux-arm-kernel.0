From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 19:18:13 +0200
Subject: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a
 device with a set of IDs
In-Reply-To: <20140901163400.GK24594@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <2811939.9L5BJIvoiz@wuerfel> <20140901163400.GK24594@arm.com>
Message-ID: <3685256.rQ7X7CQ9Fx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 17:34:00 Will Deacon wrote:
> On Mon, Sep 01, 2014 at 03:39:16PM +0100, Arnd Bergmann wrote:
> > On Monday 01 September 2014 10:13:22 Thierry Reding wrote:
> > > On Fri, Aug 29, 2014 at 04:54:26PM +0100, Will Deacon wrote:
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > index 20f9a527922a..3dd1b99c4542 100644
> > > > --- a/include/linux/iommu.h
> > > > +++ b/include/linux/iommu.h
> > > > @@ -114,6 +114,8 @@ struct iommu_ops {
> > > >       int (*domain_has_cap)(struct iommu_domain *domain,
> > > >                             unsigned long cap);
> > > >       int (*add_device)(struct device *dev);
> > > > +     int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
> > > > +                                  void *data);
> > > 
> > > If we want to pass around IOMMU instances I think we should make them
> > > proper objects rather than some loosely specified void *.
> > 
> > Agreed.
> 
> For OF, this data argument is the data field of the device_node for the
> IOMMU. That's private to the corresponding IOMMU driver and I don't see
> what we gain by making that a generic structure. It's likely going to
> represent some internal driver data structures anyway, so that the IDs can
> be recorded in the relevant place and for the relevant group etc.
> 
> In other words, I have no idea what a generic data structure would look
> like for this.

Something like

	struct iommu {
		struct device *dev;
		const struct iommu_ops *ops;
		struct list_head domains;
		void *private;
	};

There are probably a few more fields we will need in the long run.

	Arnd
