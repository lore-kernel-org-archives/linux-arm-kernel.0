From: linux.amoon@gmail.com (Anand Moon)
Date: Sun,  7 Jun 2015 22:50:42 +0930
Subject: [RESEND 2/2] usb: ohci-exynos: Make provision for vdd regulators
In-Reply-To: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1433683242-3945-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Facilitate getting required 3.3V and 1.0V VDD supply for
OHCI controller on Exynos.

With patches for regulators' nodes merged in 3.15:
c8c253f ARM: dts: Add regulator entries to smdk5420
275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
the exynos systems turn on only minimal number of regulators.

Until now, the VDD regulator supplies were either turned on
by the bootloader, or the regulators were enabled by default
in the kernel, so that the controller drivers did not need to
care about turning on these regulators on their own.
This was rather bad about these controller drivers.
So ensuring now that the controller driver requests the necessary
VDD regulators (if available, unless there are direct VDD rails),
and enable them so as to make them working.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
Initial version of this patch was part of following series, though
they are not dependent on each other, resubmitting after rebasing.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266419.html
---
 .../devicetree/bindings/usb/exynos-usb.txt         |  4 ++
 drivers/usb/host/ohci-exynos.c                     | 55 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 776fa03..3883baa 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -63,6 +63,10 @@ Required properties:
 			      port 2 is HSIC phy1
 	- phys: from the *Generic PHY* bindings, specifying phy used by port.
 
+Optional properties:
+ - vdd33-supply: handle to 3.3V Vdd supply regulator for the controller.
+ - vdd10-supply: handle to 1.0V Vdd supply regulator for the controller.
+
 Example:
 	usb at 12120000 {
 		compatible = "samsung,exynos4210-ohci";
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 2cd105b..ce757ea 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -36,6 +37,8 @@ static struct hc_driver __read_mostly exynos_ohci_hc_driver;
 struct exynos_ohci_hcd {
 	struct clk *clk;
 	struct phy *phy[PHY_NUMBER];
+	struct regulator *vdd33;
+	struct regulator *vdd10;
 };
 
 static int exynos_ohci_get_phy(struct device *dev,
@@ -139,7 +142,27 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
-		goto fail_clk;
+		goto fail_regulator1;
+
+	exynos_ohci->vdd33 = devm_regulator_get_optional(&pdev->dev, "vdd33");
+	if (!IS_ERR(exynos_ohci->vdd33)) {
+		err = regulator_enable(exynos_ohci->vdd33);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to enable 3.3V Vdd supply\n");
+			goto fail_regulator1;
+		}
+	}
+
+	exynos_ohci->vdd10 = devm_regulator_get_optional(&pdev->dev, "vdd10");
+	if (!IS_ERR(exynos_ohci->vdd10)) {
+		err = regulator_enable(exynos_ohci->vdd10);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to enable 1.0V Vdd supply\n");
+			goto fail_regulator2;
+		}
+	}
 
 skip_phy:
 	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
@@ -191,6 +214,10 @@ fail_add_hcd:
 fail_io:
 	clk_disable_unprepare(exynos_ohci->clk);
 fail_clk:
+	regulator_disable(exynos_ohci->vdd10);
+fail_regulator2:
+	regulator_disable(exynos_ohci->vdd33);
+fail_regulator1:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -206,6 +233,11 @@ static int exynos_ohci_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
+	if (!IS_ERR(exynos_ohci->vdd33))
+		regulator_disable(exynos_ohci->vdd33);
+	if (!IS_ERR(exynos_ohci->vdd10))
+		regulator_disable(exynos_ohci->vdd10);
+
 	usb_put_hcd(hcd);
 
 	return 0;
@@ -234,6 +266,11 @@ static int exynos_ohci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
+	if (!IS_ERR(exynos_ohci->vdd33))
+		regulator_disable(exynos_ohci->vdd33);
+	if (!IS_ERR(exynos_ohci->vdd10))
+		regulator_disable(exynos_ohci->vdd10);
+
 	return 0;
 }
 
@@ -243,6 +280,22 @@ static int exynos_ohci_resume(struct device *dev)
 	struct exynos_ohci_hcd *exynos_ohci	= to_exynos_ohci(hcd);
 	int ret;
 
+	if (!IS_ERR(exynos_ohci->vdd33)) {
+		ret = regulator_enable(exynos_ohci->vdd33);
+		if (ret) {
+			dev_err(dev, "Failed to enable 3.3V Vdd supply\n");
+			return ret;
+		}
+	}
+
+	if (!IS_ERR(exynos_ohci->vdd10)) {
+		ret = regulator_enable(exynos_ohci->vdd10);
+		if (ret) {
+			dev_err(dev, "Failed to enable 1.0V Vdd supply\n");
+			return ret;
+		}
+	}
+
 	clk_prepare_enable(exynos_ohci->clk);
 
 	ret = exynos_ohci_phy_enable(dev);
-- 
2.4.3
