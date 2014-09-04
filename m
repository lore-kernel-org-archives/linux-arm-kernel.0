From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 13:59:50 +0200
Subject: [RFC PATCH v2 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <20140904112625.GE7156@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <5768908.PeRFksrdyQ@wuerfel> <20140904112625.GE7156@arm.com>
Message-ID: <30707436.FH2aSkoH5H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 12:26:25 Will Deacon wrote:
> > 
> > > +               } else if (iommu != data) {
> > > +                       pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> > > +                               dev_name(dev));
> > > +                       iommu = NULL;
> > > +               }
> > > +
> > > +               of_node_put(np);
> > > +
> > > +               if (!iommu)
> > > +                       break;
> > > +
> > > +               idx++;
> > > +       }
> > > +
> > > +       if (!iommu)
> > > +               return NULL;
> > > +
> > > +       mapping = devm_kzalloc(dev, sizeof(*mapping), GFP_KERNEL);
> > > +       if (!mapping)
> > > +               return NULL;
> > > 
> > 
> > I don't think it's safe to use devm_* functions here: this is during
> > device discovery, and this data will be freed if probe() fails or
> > the device gets removed from a driver.
> 
> So I can make this a standard kzalloc, but I have no idea where the
> corresponding kfree should live. Is there something equivalent to
> of_dma_unconfigure, or is this data that is expected to persist?
> 

Can this be a simple kfree in of_platform_device_create_pdata?

	Arnd
