From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 08 May 2015 22:49:09 +0200
Subject: [V3 PATCH 3/5] device property: Introduces
 device_dma_is_coherent()
In-Reply-To: <554C3790.4010407@oracle.com>
References: <1431045436-8690-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1431045436-8690-4-git-send-email-Suravee.Suthikulpanit@amd.com>
 <554C3790.4010407@oracle.com>
Message-ID: <4329505.9FeAdJdNVY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 07, 2015 09:12:00 PM santosh.shilimkar at oracle.com wrote:
> On 5/7/15 5:37 PM, Suravee Suthikulpanit wrote:
> > Currently, device drivers, which support both OF and ACPI,
> > need to call two separate APIs, of_dma_is_coherent() and
> > acpi_dma_is_coherent()) to determine device coherency attribute.
> >
> > This patch simplifies this process by introducing a new device
> > property API, device_dma_is_coherent(), which calls the appropriate
> > interface based on the booting architecture.
> >
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > ---
> >   drivers/base/property.c  | 12 ++++++++++++
> >   include/linux/property.h |  2 ++
> >   2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 1d0b116..8123c6e 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/export.h>
> >   #include <linux/kernel.h>
> >   #include <linux/of.h>
> > +#include <linux/of_address.h>
> >   #include <linux/property.h>
> >
> >   /**
> > @@ -519,3 +520,14 @@ unsigned int device_get_child_node_count(struct device *dev)
> >   	return count;
> >   }
> >   EXPORT_SYMBOL_GPL(device_get_child_node_count);
> > +
> > +bool device_dma_is_coherent(struct device *dev)
> > +{
> > +	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> 
> Do you really need that IS_ENABLED(CONFIG_OF) ?
> In other words, dev->of_node should be null for !CONFIG_OF

Yes, but IS_ENABLED(CONFIG_OF) causes the check to be optimized away by the
compiler if CONFIG_OF is not enabled.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
