From: ruxandra.radulescu@nxp.com (Ruxandra Ioana Radulescu)
Date: Thu, 25 May 2017 12:31:17 +0000
Subject: [PATCH 1/2] staging: fsl-dpaa2/eth: Fix address translations
In-Reply-To: <59257DB0.8010604@nxp.com>
References: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
 <59257DB0.8010604@nxp.com>
Message-ID: <VI1PR0402MB28477848AE840A1E5C819C3E94FF0@VI1PR0402MB2847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Wednesday, May 24, 2017 3:34 PM
> To: Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>;
> gregkh at linuxfoundation.org
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org;
> agraf at suse.de; arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> iommu at lists.linux-foundation.org; Bogdan Purcareata
> <bogdan.purcareata@nxp.com>; stuyoder at gmail.com; Nipun Gupta
> <nipun.gupta@nxp.com>
> Subject: Re: [PATCH 1/2] staging: fsl-dpaa2/eth: Fix address translations
> 
> Hi Ioana,
> 
> Debatable nit inline.
> 
> On 05/24/2017 03:13 PM, Ioana Radulescu wrote:
> > Use the correct mechanisms for translating a DMA-mapped IOVA
> > address into a virtual one. Without this fix, once SMMU is
> > enabled on Layerscape platforms, the Ethernet driver throws
> > IOMMU translation faults.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> > ---
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 25
> +++++++++++++++++++------
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |  1 +
> >   2 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > index 6f9eed66c64d..3fee0d6f17e0 100644
> > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > @@ -37,6 +37,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/msi.h>
> >   #include <linux/kthread.h>
> > +#include <linux/iommu.h>
> >
> >   #include "../../fsl-mc/include/mc.h"
> >   #include "../../fsl-mc/include/mc-sys.h"
> > @@ -54,6 +55,16 @@ MODULE_DESCRIPTION("Freescale DPAA2 Ethernet
> Driver");
> >
> >   const char dpaa2_eth_drv_version[] = "0.1";
> >
> > +static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
> 
> if you pass a "struct dpaa2_eth_priv *priv" instead of "iommu_domain"
> you can move the priv->iommu_domain reference in the function and
> slightly simplify the call sites.
 
Fair point, but I'd prefer keeping this function independent of the
Ethernet driver's private data structure. This way, if other (future)
DPAA2 drivers will need a similar function, we can just move it
to a common area instead of duplicating the code.

Thanks,
Ioana
