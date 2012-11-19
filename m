From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:50 +0100
Subject: [PATCH 12/30] dma: mv_xor: change the driver name to 'mv_xor'
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we got rid of the per-XOR channel 'mv_xor' driver, now the
per-XOR engine driver that used to be called 'mv_xor_shared' can
simply be named 'mv_xor'.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c              |    9 +++++----
 arch/arm/mach-kirkwood/board-dt.c        |    5 +++--
 arch/arm/mach-kirkwood/common.c          |    4 ++--
 arch/arm/plat-orion/common.c             |    4 ++--
 drivers/dma/mv_xor.c                     |    2 +-
 include/linux/platform_data/dma-mv_xor.h |    2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 4b09d12..a209444 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <plat/time.h>
 #include <linux/platform_data/usb-ehci-orion.h>
+#include <linux/platform_data/dma-mv_xor.h>
 #include <plat/irq.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
@@ -124,8 +125,8 @@ static void __init dove_clk_init(void)
 	orion_clkdev_add(NULL, "mv_crypto", crypto);
 	orion_clkdev_add(NULL, "dove-ac97", ac97);
 	orion_clkdev_add(NULL, "dove-pdma", pdma);
-	orion_clkdev_add(NULL, "mv_xor_shared.0", xor0);
-	orion_clkdev_add(NULL, "mv_xor_shared.1", xor1);
+	orion_clkdev_add(NULL, MV_XOR_NAME ".0", xor0);
+	orion_clkdev_add(NULL, MV_XOR_NAME ".1", xor1);
 }
 
 /*****************************************************************************
@@ -410,11 +411,11 @@ static void __init dove_legacy_clk_init(void)
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CLOCK_GATING_BIT_XOR0;
-	orion_clkdev_add(NULL, "mv_xor_shared.0",
+	orion_clkdev_add(NULL, MV_XOR_NAME ".0",
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CLOCK_GATING_BIT_XOR1;
-	orion_clkdev_add(NULL, "mv_xor_shared.1",
+	orion_clkdev_add(NULL, MV_XOR_NAME ".1",
 			 of_clk_get_from_provider(&clkspec));
 }
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ffec16c..994ce26 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -21,6 +21,7 @@
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/usb-ehci-orion.h>
+#include <linux/platform_data/dma-mv_xor.h>
 #include <plat/irq.h>
 #include <plat/common.h>
 #include "common.h"
@@ -60,11 +61,11 @@ static void __init kirkwood_legacy_clk_init(void)
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CGC_BIT_XOR0;
-	orion_clkdev_add(NULL, "mv_xor_shared.0",
+	orion_clkdev_add(NULL, MV_XOR_NAME ".0",
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CGC_BIT_XOR1;
-	orion_clkdev_add(NULL, "mv_xor_shared.1",
+	orion_clkdev_add(NULL, MV_XOR_NAME ".1",
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CGC_BIT_PEX1;
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 2c6c218..401dac1 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -260,8 +260,8 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add(NULL, "orion_nand", runit);
 	orion_clkdev_add(NULL, "mvsdio", sdio);
 	orion_clkdev_add(NULL, "mv_crypto", crypto);
-	orion_clkdev_add(NULL, MV_XOR_SHARED_NAME ".0", xor0);
-	orion_clkdev_add(NULL, MV_XOR_SHARED_NAME ".1", xor1);
+	orion_clkdev_add(NULL, MV_XOR_NAME ".0", xor0);
+	orion_clkdev_add(NULL, MV_XOR_NAME ".1", xor1);
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
 	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index edd57a6..31517ce 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -641,7 +641,7 @@ static struct mv_xor_platform_data orion_xor0_pdata = {
 };
 
 static struct platform_device orion_xor0_shared = {
-	.name		= MV_XOR_SHARED_NAME,
+	.name		= MV_XOR_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(orion_xor0_shared_resources),
 	.resource	= orion_xor0_shared_resources,
@@ -716,7 +716,7 @@ static struct mv_xor_platform_data orion_xor1_pdata = {
 };
 
 static struct platform_device orion_xor1_shared = {
-	.name		= MV_XOR_SHARED_NAME,
+	.name		= MV_XOR_NAME,
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(orion_xor1_shared_resources),
 	.resource	= orion_xor1_shared_resources,
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index ac59816..0ed5183 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1361,7 +1361,7 @@ static struct platform_driver mv_xor_shared_driver = {
 	.remove		= mv_xor_shared_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
-		.name	= MV_XOR_SHARED_NAME,
+		.name	= MV_XOR_NAME,
 	},
 };
 
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 82a5f4b..367bb21 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -10,7 +10,7 @@
 #include <linux/dmaengine.h>
 #include <linux/mbus.h>
 
-#define MV_XOR_SHARED_NAME	"mv_xor_shared"
+#define MV_XOR_NAME	"mv_xor"
 
 struct mv_xor_channel_data {
 	int				hw_id;
-- 
1.7.9.5
