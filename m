From: rogerq@ti.com (Roger Quadros)
Date: Thu, 27 Feb 2014 16:18:26 +0200
Subject: [PATCH v9 4/9] mfd: omap-usb-host: Use clock names as per function
 for reference clocks
In-Reply-To: <1393510711-4697-1-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
Message-ID: <1393510711-4697-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a meaningful name for the reference clocks so that it indicates the function.

Update the OMAP4+ USB Host node as well to be in sync with the changes.

CC: Beno?t Cousson <bcousson@baylibre.com>
CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |  6 ++++++
 arch/arm/boot/dts/omap5.dtsi |  6 ++++++
 drivers/mfd/omap-usb-host.c  | 12 ++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..39a05ce 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -697,6 +697,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&init_60m_fclk>,
+				 <&xclk60mhsp1_ck>,
+				 <&xclk60mhsp2_ck>;
+			clock-names = "refclk_60m_int",
+				      "refclk_60m_ext_p1",
+				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci at 4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..d4dae48 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -775,6 +775,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&l3init_60m_fclk>,
+				 <&xclk60mhsp1_ck>,
+				 <&xclk60mhsp2_ck>;
+			clock-names = "refclk_60m_int",
+				      "refclk_60m_ext_p1",
+				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci at 4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 865c276..651e249 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -718,24 +718,24 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp1_ck = devm_clk_get(dev, "xclk60mhsp1_ck");
+	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp1_ck);
-		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
+		dev_err(dev, "refclk_60m_ext_p1 failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp2_ck = devm_clk_get(dev, "xclk60mhsp2_ck");
+	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp2_ck);
-		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
+		dev_err(dev, "refclk_60m_ext_p2 failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->init_60m_fclk = devm_clk_get(dev, "init_60m_fclk");
+	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
 	if (IS_ERR(omap->init_60m_fclk)) {
 		ret = PTR_ERR(omap->init_60m_fclk);
-		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
+		dev_err(dev, "refclk_60m_int failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-- 
1.8.3.2
