From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Sep 2012 09:58:14 +0200
Subject: [PATCH 25/34] dma: imx-dma: remove mach/hardware.h inclusion
In-Reply-To: <1347860103-4141-26-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-26-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917075814.GO6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:34:54PM +0800, Shawn Guo wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the controller type, and updates the platform code
> accordingly.
> 
> As the result, mach/hardware.h inclusion gets removed from the driver.

I know the important thing for you is to get rid of the mach/hardware.h
inclusion, but I think the subject for this patch should rather be that
you switch to platform_device_id for this driver.

This patch misses to adjust the clock lookups according to the new
platform_device_ids. Please fixup the patch with the following.

Sascha

8<---------------------------------------------------------

>From 3094908fcbb4532056034539ea57042cd60abf47 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 17 Sep 2012 09:39:30 +0200
Subject: [PATCH] ARM i.MX DMA: Fixup clock lookups after platform_device_id conversion

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx1.c          |    3 ++-
 arch/arm/mach-imx/clk-imx21.c         |    4 ++--
 arch/arm/mach-imx/clk-imx27.c         |    4 ++--
 include/linux/platform_data/dma-imx.h |    4 +++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 7b76bc3..e8d9242 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -82,7 +82,8 @@ int __init mx1_clocks_init(unsigned long fref)
 			pr_err("imx1 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
-	clk_register_clkdev(clk[dma_gate], "ahb", "imx-dma");
+	clk_register_clkdev(clk[dma_gate], "ahb", "imx1-dma");
+	clk_register_clkdev(clk[hclk], "ipg", "imx1-dma");
 	clk_register_clkdev(clk[mma_gate], "mma", NULL);
 	clk_register_clkdev(clk[usbd_gate], NULL, "imx_udc.0");
 	clk_register_clkdev(clk[per1], "per", "imx-gpt.0");
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index 52b0563..d7ed660 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -162,8 +162,8 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[usb_gate], "per", "imx21-hcd.0");
 	clk_register_clkdev(clk[usb_hclk_gate], "ahb", "imx21-hcd.0");
 	clk_register_clkdev(clk[nfc_gate], NULL, "imx21-nand.0");
-	clk_register_clkdev(clk[dma_hclk_gate], "ahb", "imx-dma");
-	clk_register_clkdev(clk[dma_gate], "ipg", "imx-dma");
+	clk_register_clkdev(clk[dma_hclk_gate], "ahb", "imx21-dma");
+	clk_register_clkdev(clk[dma_gate], "ipg", "imx21-dma");
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[i2c_gate], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[kpp_gate], NULL, "mxc-keypad");
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index e813745..d286bac 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -241,8 +241,8 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[nfc_baud_gate], NULL, "imx27-nand.0");
 	clk_register_clkdev(clk[vpu_baud_gate], "per", "imx-vpu");
 	clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "imx-vpu");
-	clk_register_clkdev(clk[dma_ahb_gate], "ahb", "imx-dma");
-	clk_register_clkdev(clk[dma_ipg_gate], "ipg", "imx-dma");
+	clk_register_clkdev(clk[dma_ahb_gate], "ahb", "imx27-dma");
+	clk_register_clkdev(clk[dma_ipg_gate], "ipg", "imx27-dma");
 	clk_register_clkdev(clk[fec_ipg_gate], "ipg", "imx27-fec.0");
 	clk_register_clkdev(clk[fec_ahb_gate], "ahb", "imx27-fec.0");
 	clk_register_clkdev(clk[wdog_ipg_gate], NULL, "imx2-wdt.0");
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 1b90803..f6d30cc 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -61,7 +61,9 @@ static inline int imx_dma_is_ipu(struct dma_chan *chan)
 static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 {
 	return strstr(dev_name(chan->device->dev), "sdma") ||
-		!strcmp(dev_name(chan->device->dev), "imx-dma");
+		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
+		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
+		!strcmp(dev_name(chan->device->dev), "imx27-dma");
 }
 
 #endif
-- 
1.7.10.4

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
