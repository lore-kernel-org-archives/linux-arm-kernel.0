From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 25 Mar 2016 12:02:34 +0800
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <CAOCOHw7wgzyp5JmhBF9i1mAsjOHHJhwvn4sw=aMdQjOQPDGqWA@mail.gmail.com>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <56CADCE9.9090305@linaro.org> <20160222220750.GI21240@tuxbot>
 <CADRPPNRH28W6u8adSb9Ja0JSJvFgcKF+2jYa3GSKBcGVsZcdLQ@mail.gmail.com>
 <CADRPPNS0q3Q9j4AYvqRfcSaQ6BzLiL6zM5tn7MwJ613iNA1iPQ@mail.gmail.com>
 <CAOCOHw7wgzyp5JmhBF9i1mAsjOHHJhwvn4sw=aMdQjOQPDGqWA@mail.gmail.com>
Message-ID: <20160325040234.GA6185@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 07:40:08PM -0800, Bjorn Andersson wrote:
> On Tue, Mar 8, 2016 at 11:52 AM, Li Yang <leoli@freescale.com> wrote:
> > On Wed, Mar 2, 2016 at 4:59 PM, Li Yang <leoli@freescale.com> wrote:
> >> On Mon, Feb 22, 2016 at 4:07 PM, Bjorn Andersson
> >> <bjorn.andersson@linaro.org> wrote:
> >>> On Mon 22 Feb 02:03 PST 2016, Srinivas Kandagatla wrote:
> >>>
> >>>>
> >>>>
> >>>> On 22/02/16 05:32, Bjorn Andersson wrote:
> >>>> >On certain platforms (e.g. ARM64) the dma_ops needs to be explicitly set
> >>>> >to be able to do DMA allocations, so use the of_dma_configure() helper
> >>>> >to populate the dma properties and assign an appropriate dma_ops.
> [..]
> >>>> None of the drivers call of_dma_configure() explicitly, which makes me feel
> >>>> that we are doing something wrong. TBH, this should be handled in more
> >>>> generic way rather than driver like this having an explicit call to
> >>>> of_dma_configure().
> >>>>
> >>>
> 
> I had the chance to go through this with Arnd and the verdict is that
> devices not described in DT should not do DMA (or allocate buffers for
> doing DMA).
> 
> So I believe the solution is to fall back on Peter's description; the
> chipidea driver is the core driver and the Qualcomm code should just
> be a platform layer.
> 
> My suggestion is that we turn the chipidea core into a set of APIs
> that can called by the platform specific pieces. That way we will have
> the chipidea core be the device described in the DT.
> 

Hi Bjorn,

After reading the DMA documentation Russell supplied and several related
DMA APIs, would you please try below patch on your ARM64 platform?
Since the core device has no device node at all, I don't know why
your patch can work, or am I missing something?

>From bcf7eaf694d29fb7557a9406fb6c89213216069c Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@freescale.com>
Date: Fri, 25 Mar 2016 11:54:21 +0800
Subject: [PATCH 1/1] usb: chipidea: add DMA mask configuration API

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_msm.c |    6 ++++++
 drivers/usb/chipidea/core.c        |   25 +++++++++++++++++++++++++
 include/linux/usb/chipidea.h       |    2 ++
 3 files changed, 33 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 3889809..43ceb38 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -5,6 +5,7 @@
  * only version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -56,6 +57,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 {
 	struct platform_device *plat_ci;
 	struct usb_phy *phy;
+	int ret;
 
 	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
 
@@ -70,6 +72,10 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	ci_hdrc_msm_platdata.usb_phy = phy;
 
+	ret = ci_hdrc_set_dma_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	plat_ci = ci_hdrc_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci_hdrc_msm_platdata);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..b8ca5e3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -62,6 +62,7 @@
 #include <linux/usb/chipidea.h>
 #include <linux/usb/of.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/ehci_def.h>
@@ -811,6 +812,30 @@ static void ci_extcon_unregister(struct ci_hdrc *ci)
 
 static DEFINE_IDA(ci_ida);
 
+/**
+ * ci_hdrc_set_dma_mask
+ *
+ * Set dma mask and coherent dma mask for glue layer device, and the core
+ * device will inherit these values. If the 'dma-ranges' is specified at
+ * DT, it will use this value for both dma mask and coherent dma mask.
+ *
+ * @dev: a pointer to the device struct of glue layer device
+ * @ci_coherent_dma_mask: the mask for both dma_mask and cohrent_dma_mask
+ */
+int ci_hdrc_set_dma_mask(struct device *dev, u64 ci_coherent_dma_mask)
+{
+	int ret = dma_set_mask_and_coherent(dev, ci_coherent_dma_mask);
+	if (ret) {
+		dev_err(dev, "dma_set_mask_and_coherent fails\n");
+		return ret;
+	}
+
+	if (dev_of_node(dev))
+		of_dma_configure(dev, dev->of_node);
+
+	return ret;
+}
+
 struct platform_device *ci_hdrc_add_device(struct device *dev,
 			struct resource *res, int nres,
 			struct ci_hdrc_platform_data *platdata)
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 5dd75fa..8649930 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -84,4 +84,6 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 /* Remove ci hdrc device */
 void ci_hdrc_remove_device(struct platform_device *pdev);
 
+int ci_hdrc_set_dma_mask(struct device *dev, u64 ci_coherent_dma_mask);
+
 #endif

-- 
Best Regards,
Peter Chen
