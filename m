From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 16 Dec 2011 21:38:25 +0900
Subject: [PATCH] iommu: Initialize domain->handler in	iommu_domain_alloc()
In-Reply-To: <20111215081056.GC4475@8bytes.org>
References: <1323760466-30333-1-git-send-email-pullip.cho@samsung.com>
 <20111215081056.GC4475@8bytes.org>
Message-ID: <000401ccbbef$9b0389e0$d10a9da0$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 05:11:26PM +0100, Joerg Roedel wrote:
> On Tue, Dec 13, 2011 at 04:14:20PM +0900, KyongHo Cho wrote:
> > Since it is not guaranteed that an iommu driver initializes in its
> > domain_init() function, it must be initialized with NULL to prevent
> > calling a function in an arbitrary location when iommu fault occurred.
> >
> > Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> > ---
> >  drivers/iommu/iommu.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 7cc3c65..1afb896 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -148,6 +148,7 @@ struct iommu_domain *iommu_domain_alloc(struct
> bus_type *bus)
> >  		return NULL;
> >
> >  	domain->ops = bus->iommu_ops;
> > +	domain->handler = NULL;
> 
> Good catch. But it is better to change the kmalloc in the function to
> kzalloc. This will implicitly initialize all future members correctly.
Hi.

Here is the patch that change kmalloc -> kzalloc
according to your advice.

>From 821141fcf00a64fe4fbacc78b2bbe90e15da9fca Mon Sep 17 00:00:00 2001
From: KyongHo Cho <pullip.cho@samsung.com>
Date: Tue, 13 Dec 2011 16:08:51 +0900
Subject: [PATCH] iommu: Initialize domain->handler in iommu_domain_alloc()

Since it is not guaranteed that an iommu driver initializes in its
domain_init() function, it must be initialized with NULL to prevent
calling a function in an arbitrary location when iommu fault occurred.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7cc3c65..2198b2d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -143,7 +143,7 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	domain = kmalloc(sizeof(*domain), GFP_KERNEL);
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-- 
1.7.1
