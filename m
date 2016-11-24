From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:28:31 +0100
Subject: [PATCH v2 3/3] ARM: davinci: remove ohci platform usage
In-Reply-To: <20161124152831.26678-1-ahaslam@baylibre.com>
References: <20161124152831.26678-1-ahaslam@baylibre.com>
Message-ID: <20161124152831.26678-4-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all users of ohci platform data have been converted
to use a regulator, we dont need to pass platform
data to register the ohci device anymore.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  | 2 +-
 arch/arm/mach-davinci/usb-da8xx.c           | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 253d9af..223de79 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -130,7 +130,7 @@ static __init void da830_evm_usb_init(void)
 		pr_warn("%s: USB 1.1 regulator register failed: %d\n",
 			__func__, ret);
 
-	ret = da8xx_register_usb11(NULL);
+	ret = da8xx_register_usb11();
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
 }
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a252404..cbe7324 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -197,7 +197,7 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	ret = da8xx_register_usb11(NULL);
+	ret = da8xx_register_usb11();
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n",
 			__func__, ret);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 85ff218..b21ef07 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -91,7 +91,7 @@ int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
-int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
+int da8xx_register_usb11(void);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index b010e5f..a438e2b 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -119,9 +119,8 @@ static struct platform_device da8xx_usb11_device = {
 	.resource	= da8xx_usb11_resources,
 };
 
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+int __init da8xx_register_usb11(void)
 {
-	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
 }
 
-- 
2.9.3
