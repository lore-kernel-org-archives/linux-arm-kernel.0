From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 18 Oct 2018 21:10:11 +0530
Subject: [PATCH v2 04/10] firmware: ti_sci: Add RM mapping table for am654
In-Reply-To: <20181018154017.7112-1-lokeshvutla@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
Message-ID: <20181018154017.7112-5-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the resource mapping table for AM654 SoC as defined
in http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
Introduce a new compatible for AM654 "ti,am654-sci" for using
this resource map table.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v1:
- new patch added.

 .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
 drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index b56a02c10ae6..6f0cd31c1520 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
 
 Required properties:
 -------------------
-- compatible: should be "ti,k2g-sci"
+- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
+		should be "ti,am654-sci" for for TI AM654 SoC
 - mbox-names:
 	"rx" - Mailbox corresponding to receive path
 	"tx" - Mailbox corresponding to transmit path
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 987bfb29475c..c2f0815edab6 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2500,10 +2500,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
+	.rm_type_map = NULL,
+};
+
+static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
+	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
+	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
+	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
+	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
+	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
+	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
+	{.dev_id = 0, .type = 0x000}, /* end of table */
+};
+
+/* Description for AM654 */
+static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
+	.default_host_id = 12,
+	/* Conservative duration */
+	.max_rx_timeout_ms = 10000,
+	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
+	.max_msgs = 20,
+	.max_msg_size = 60,
+	.rm_type_map = ti_sci_am654_rm_type_map,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
 	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
+	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_of_match);
-- 
2.19.1
