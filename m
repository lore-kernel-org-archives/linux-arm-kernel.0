From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon,  9 Dec 2013 02:53:45 +0400
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386543229-1542-6-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-dts implementation supply required DMA channel numbers as
IORESOURCE_DMA. However, there is was no way to get them from
device tree.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt |  2 +
 arch/arm/boot/dts/pxa27x.dtsi                     |  4 ++
 drivers/mmc/host/pxamci.c                         | 50 ++++++++++++++++++-----
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
index b7025de..27447ec 100644
--- a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
@@ -5,6 +5,7 @@ Driver bindings for the PXA MCI (MMC/SDIO) interfaces
 Required properties:
 - compatible: Should be "marvell,pxa-mmc".
 - vmmc-supply: A regulator for VMMC
+- marvell,dma-channels: 2 PXA DMA channels [0] for RX, [1] for TX
 
 Optional properties:
 - marvell,detect-delay-ms: sets the detection delay timeout in ms.
@@ -19,6 +20,7 @@ mmc0: mmc at 41100000 {
 	compatible = "marvell,pxa-mmc";
 	reg = <0x41100000 0x1000>;
 	interrupts = <23>;
+	marvell,dma-channels = <21 22>;
 	cd-gpios = <&gpio 23 0>;
 	wp-gpios = <&gpio 24 0>;
 };
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 44df554..3f97520 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -16,5 +16,9 @@
 			interrupts = <8>, <9>, <10>;
 			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 		};
+
+		mmc at 41100000 {
+			marvell,dma-channels = <21 22>;
+		};
 	};
 };
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 32fe113..8c7a110 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -613,11 +613,37 @@ static int pxamci_of_init(struct platform_device *pdev)
 
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+        struct device_node *np = pdev->dev.of_node;
+        u32 tmp;
+	int ret;
+
+	ret = of_property_read_u32_index(np, "marvell,dma-channels", 0, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrrx = tmp;
+
+	ret = of_property_read_u32_index(np, "marvell,dma-channels", 1, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrtx = tmp;
+
+	return 0;
+}
 #else
 static int pxamci_of_init(struct platform_device *pdev)
 {
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+	return -ENODATA;
+}
 #endif
 
 static int pxamci_probe(struct platform_device *pdev)
@@ -741,19 +767,21 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmarx) {
-		ret = -ENXIO;
-		goto out;
-	}
-	host->dma_drcmrrx = dmarx->start;
+	if (pxamci_of_init_dma(pdev, host) < 0) {
+		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!dmarx) {
+			ret = -ENXIO;
+			goto out;
+		}
+		host->dma_drcmrrx = dmarx->start;
 
-	dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!dmatx) {
-		ret = -ENXIO;
-		goto out;
+		dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (!dmatx) {
+			ret = -ENXIO;
+			goto out;
+		}
+		host->dma_drcmrtx = dmatx->start;
 	}
-	host->dma_drcmrtx = dmatx->start;
 
 	if (host->pdata) {
 		gpio_cd = host->pdata->gpio_card_detect;
-- 
1.8.4.3
