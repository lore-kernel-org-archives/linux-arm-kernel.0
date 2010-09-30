From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Sep 2010 10:16:05 +0200
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <4CA3AE89.2030107@pelagicore.com>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
	<4CA3AE89.2030107@pelagicore.com>
Message-ID: <20100930081605.GA2655@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Wed, Sep 29, 2010 at 11:24:25PM +0200, Richard R?jfors wrote:
> On 09/29/2010 10:07 PM, Wolfram Sang wrote:
> >We need to carry some information per host, e.g. the clock. Add a
> >structure for it and initialize it in the generic part. Also do not use
> >the parent of the platform_device (if it is available), this breaks the
> >clock-matching on ARM.
> 
> The reason it's there is for instance a case when the shdci device is exposed
> from a MFD device which sits on top of PCI. Then the parent (PCI device)
> is the device that is DMA capable. This patch will break such usage.

I feared that there is a reason. The problem I see is now, that the parent gets
always set (from drivers/base/platform.c):

37c12e74 (Russell King            2005-11-05 21:19:33 +0000  235) int platform_device_add(struct platform_device *pdev)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  236) {
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  237)       int i, ret = 0;
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  238) 
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  239)       if (!pdev)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  240)               return -EINVAL;
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  241) 
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  242)       if (!pdev->dev.parent)
^1da177e (Linus Torvalds          2005-04-16 15:20:36 -0700  243)               pdev->dev.parent = &platform_bus;
...

So, sdhci-plftm cannot access the platform_data connected to the original
platform_device via host->mmc->parent.

> What is the purpose of this patch? You allocate space for an extra struct,
> which you have a pointer pointing to, but you never use the pointer?

We want to extend sdhci-pltfm to support the various sdhci-cores on (for now
mainly) ARM platforms. A number of those cores need board specific information
to be used in a custom init()-call, which shall be passed via platform_data.
The pointer will be used in the platform specific extensions.

> >
> >Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
> >Cc: Richard R?jfors<richard.rojfors.ext@mocean-labs.com>
> >---
> >
> >Changes since last version:
> >
> >* added types.h
> 
> I saw no types.h?

In the second chunk, the include file.

Thanks,

   Wolfram

> 
> >* removed usage of pdev->dev.parent to ensure clk-matching
> >   Please speak up if this has a use case I failed to see!
> >
> >  drivers/mmc/host/sdhci-pltfm.c |    8 ++++----
> >  drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> >index e045e3c..095ca9d 100644
> >--- a/drivers/mmc/host/sdhci-pltfm.c
> >+++ b/drivers/mmc/host/sdhci-pltfm.c
> >@@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
> >  	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
> >  	const struct platform_device_id *platid = platform_get_device_id(pdev);
> >  	struct sdhci_host *host;
> >+	struct sdhci_pltfm_host *pltfm_host;
> >  	struct resource *iomem;
> >  	int ret;
> >
> >@@ -71,16 +72,15 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "Invalid iomem size. You may "
> >  			"experience problems.\n");
> >
> >-	if (pdev->dev.parent)
> >-		host = sdhci_alloc_host(pdev->dev.parent, 0);
> >-	else
> >-		host = sdhci_alloc_host(&pdev->dev, 0);
> >+	host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
> >
> >  	if (IS_ERR(host)) {
> >  		ret = PTR_ERR(host);
> >  		goto err;
> >  	}
> >
> >+	pltfm_host = sdhci_priv(host);
> >+
> >  	host->hw_name = "platform";
> >  	if (pdata&&  pdata->ops)
> >  		host->ops = pdata->ops;
> >diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> >index 900f329..93a0319 100644
> >--- a/drivers/mmc/host/sdhci-pltfm.h
> >+++ b/drivers/mmc/host/sdhci-pltfm.h
> >@@ -11,8 +11,15 @@
> >  #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
> >  #define _DRIVERS_MMC_SDHCI_PLTFM_H
> >
> >+#include<linux/clk.h>
> >+#include<linux/types.h>
> >  #include<linux/sdhci-pltfm.h>
> >
> >+struct sdhci_pltfm_host {
> >+	struct clk *clk;
> >+	u32 scratchpad; /* to handle quirks across io-accessor calls */
> >+};
> >+
> >  extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> >
> >  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100930/fba09373/attachment.sig>
