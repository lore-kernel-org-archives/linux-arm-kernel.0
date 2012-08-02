From: p.paneri@samsung.com (Praveen Paneri)
Date: Thu, 2 Aug 2012 11:14:13 +0530
Subject: [PATCH 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <201208011520.02353.arnd@arndb.de>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
 <201208011520.02353.arnd@arndb.de>
Message-ID: <CAD6zSYN-prJO=dp8tJT8+4qcC3TxCXyVTU6-Xf5p20650Zb-ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Aug 1, 2012 at 8:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 01 August 2012, Praveen Paneri wrote:
>> This patch set introduces a phy driver for samsung SoCs. It uses the existing
>> transceiver infrastructure to provide phy control functions. Use of this driver
>> can be extended for usb host phy as well. Over the period of time all the phy
>> related code for most of the samsung SoCs can be integrated here.
>> Removing the existing phy code from mach-s3c64xx but not from other machine
>> code.This driver is tested with smdk6410 and Exynos4210(with DT).
>
> This looks very nice overall, great work!
Thank you!
>
> We will still have to take care of the pmu isolation callback in the
> long run, when we get to the point of removing all auxdata. Do you
> have a plan on how to do that? If yes, it would be good to mention
> that in the changelog.
Yes! I understand this problem and this is the reason these patches
were sitting in my system for couple of weeks. In a  discussion with
Thomas an idea of using the existing regulator framework to
enable/disable numerous PHYs came up. For example the PMU unit
of Exynos4210 has a register set dedicated just to control USBD_PHY,
HDMI_PHY, MIPI_PHY, DAC_PHY and more. If a regulator with
each phy control register as LDO is written, the phy driver becomes a
static consumer and will modify as below.

diff --git a/drivers/usb/phy/sec_usbphy.c b/drivers/usb/phy/sec_usbphy.c
index 33119eb..4f69675 100644
--- a/drivers/usb/phy/sec_usbphy.c
+++ b/drivers/usb/phy/sec_usbphy.c
@@ -28,8 +28,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/otg.h>
-#include <linux/platform_data/s3c-hsotg.h>

 #include "sec_usbphy.h"

@@ -41,7 +41,7 @@ enum sec_cpu_type {
 /*
  * struct sec_usbphy - transceiver driver state
  * @phy: transceiver structure
- * @plat: platform data
+ * @vusbphy: PMU regulator for usb phy
  * @dev: The parent device supplied to the probe function
  * @clk: usb phy clock
  * @regs: usb phy register memory base
@@ -49,7 +49,7 @@ enum sec_cpu_type {
  */
 struct sec_usbphy {
 	struct usb_phy	phy;
-	struct s3c_usbphy_plat *plat;
+	struct regulator *vusbphy;
 	struct device	*dev;
 	struct clk	*clk;
 	void __iomem	*regs;
@@ -187,8 +187,11 @@ static int sec_usbphy_init(struct usb_phy *phy)
 	}

 	/* Disable phy isolation */
-	if (sec->plat && sec->plat->pmu_isolation)
-		sec->plat->pmu_isolation(false);
+	ret = regulator_enable(sec->vusbphy);
+	if (ret) {
+		dev_err(sec->dev, "Failed to enable regulator for USBPHY\n");
+		return ret;
+	}

 	/* Initialize usb phy registers */
 	sec_usbphy_enable(sec);
@@ -208,8 +211,8 @@ static void sec_usbphy_shutdown(struct usb_phy *phy)
 	sec_usbphy_disable(sec);

 	/* Enable phy isolation */
-	if (sec->plat && sec->plat->pmu_isolation)
-		sec->plat->pmu_isolation(true);
+	if (regulator_disable(sec->vusbphy))
+		dev_err(sec->dev, "Failed to disable regulator for USBPHY\n");

 	/* Disable the phy clock */
 	sec_usbphy_clk_control(sec, false);
@@ -263,7 +266,6 @@ static int __devinit sec_usbphy_probe(struct
platform_device *pdev)
 		return -ENOMEM;

 	sec->dev		= &pdev->dev;
-	sec->plat		= pdata;
 	sec->regs		= phy_base;
 	sec->phy.dev		= sec->dev;
 	sec->phy.label		= "sec-usbphy";
@@ -271,6 +273,14 @@ static int __devinit sec_usbphy_probe(struct
platform_device *pdev)
 	sec->phy.shutdown	= sec_usbphy_shutdown;
 	sec->cpu_type		= sec_usbphy_get_driver_data(pdev);

+	/* acquire regulator */
+	sec->vusbphy = regulator_get(sec->dev, "usbdphy");
+	if (IS_ERR_OR_NULL(sec->vusbphy)) {
+		dev_err(dev, "failed to get regulator 'usbdphy'\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
 	ret = usb_add_phy(&sec->phy, USB_PHY_TYPE_USB2);
 	if (ret)
 		goto err;
@@ -292,6 +302,7 @@ static int __exit sec_usbphy_remove(struct
platform_device *pdev)
 		clk_put(sec->clk);
 		sec->clk = NULL;
 	}
+	regulator_put(sec->vusbphy);

 	return 0;
 }

This kind of regulator, if generalised can be useful.
Please comment.
>
> My guess is that the PMU code should be moved into a higher-level
> abstraction. I don't know if you would use one of those we already
Could you please point out the location of the code.
> have or whether you'd introduce a new subsystem for those. Apparently.
Havent thought about it. Trying to work it out with the existing infra of the
kernel.
> other platforms have similar issues, so I'd suggest you leave the
> callback for now, but we should at some point discuss what to to
> about it.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Praveen
