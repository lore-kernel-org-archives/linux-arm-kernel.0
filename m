From: mporter@linaro.org (Matt Porter)
Date: Thu, 19 Dec 2013 09:23:07 -0500
Subject: [PATCH v8 6/9] usb: gadget: s3c-hsotg: get phy bus width from phy
 subsystem
In-Reply-To: <1387462990-12039-1-git-send-email-mporter@linaro.org>
References: <1387462990-12039-1-git-send-email-mporter@linaro.org>
Message-ID: <1387462990-12039-7-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for querying the phy bus width from the generic phy
subsystem. Configure UTMI bus width in GUSBCFG based on this value.

Signed-off-by: Matt Porter <mporter@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/gadget/s3c-hsotg.c | 14 +++++++++++++-
 drivers/usb/gadget/s3c-hsotg.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 8f9bcdb..93ba8b6 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -146,6 +146,7 @@ struct s3c_hsotg_ep {
  * @regs: The memory area mapped for accessing registers.
  * @irq: The IRQ number we are using
  * @supplies: Definition of USB power supplies
+ * @phyif: PHY interface width
  * @dedicated_fifos: Set if the hardware has dedicated IN-EP fifos.
  * @num_of_eps: Number of available EPs (excluding EP0)
  * @debug_root: root directrory for debugfs.
@@ -174,6 +175,7 @@ struct s3c_hsotg {
 
 	struct regulator_bulk_data supplies[ARRAY_SIZE(s3c_hsotg_supply_names)];
 
+	u32			phyif;
 	unsigned int		dedicated_fifos:1;
 	unsigned char           num_of_eps;
 
@@ -2279,7 +2281,7 @@ static void s3c_hsotg_core_init(struct s3c_hsotg *hsotg)
 	 */
 
 	/* set the PLL on, remove the HNP/SRP and set the PHY */
-	writel(GUSBCFG_PHYIf16 | GUSBCFG_TOutCal(7) |
+	writel(hsotg->phyif | GUSBCFG_TOutCal(7) |
 	       (0x5 << 10), hsotg->regs + GUSBCFG);
 
 	s3c_hsotg_init_fifo(hsotg);
@@ -3638,6 +3640,16 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 		goto err_supplies;
 	}
 
+	/* Set default UTMI width */
+	hsotg->phyif = GUSBCFG_PHYIf16;
+
+	/*
+	 * If using the generic PHY framework, check if the PHY bus
+	 * width is 8-bit and set the phyif appropriately.
+	 */
+	if (hsotg->phy && (phy_get_bus_width(phy) == 8))
+		hsotg->phyif = GUSBCFG_PHYIf8;
+
 	if (hsotg->phy)
 		phy_init(hsotg->phy);
 
diff --git a/drivers/usb/gadget/s3c-hsotg.h b/drivers/usb/gadget/s3c-hsotg.h
index d650b12..85f549f 100644
--- a/drivers/usb/gadget/s3c-hsotg.h
+++ b/drivers/usb/gadget/s3c-hsotg.h
@@ -55,6 +55,7 @@
 #define GUSBCFG_HNPCap				(1 << 9)
 #define GUSBCFG_SRPCap				(1 << 8)
 #define GUSBCFG_PHYIf16			(1 << 3)
+#define GUSBCFG_PHYIf8				(0 << 3)
 #define GUSBCFG_TOutCal_MASK			(0x7 << 0)
 #define GUSBCFG_TOutCal_SHIFT			(0)
 #define GUSBCFG_TOutCal_LIMIT			(0x7)
-- 
1.8.4
