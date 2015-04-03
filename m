From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Apr 2015 14:42:01 +0200
Subject: [PATCH/RFC 4/6] staging: board: kzm9d: Translate hwirq numbers to
 virq numbers
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1428064923-24950-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), GIC IRQ numbers are virtual, breaking hardcoded hardware IRQ
numbers in platform device resources.

Translate the hardware IRQ numbers to virtual IRQ numbers to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware
---
 drivers/staging/board/kzm9d.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
index 533f3026e17aa723..8ea7a1a9bd777dc7 100644
--- a/drivers/staging/board/kzm9d.c
+++ b/drivers/staging/board/kzm9d.c
@@ -4,16 +4,22 @@
 #include <linux/platform_device.h>
 #include "board.h"
 
-static const struct resource usbs1_res[] __initconst = {
+static struct resource usbs1_res[] __initdata = {
 	DEFINE_RES_MEM(0xe2800000, 0x2000),
 	DEFINE_RES_IRQ(159),
 };
 
 static void __init kzm9d_init(void)
 {
-	if (!board_staging_dt_node_available(usbs1_res, ARRAY_SIZE(usbs1_res)))
+	board_staging_setup_hwirq_xlate("arm,cortex-a9-gic", 32);
+
+	if (!board_staging_dt_node_available(usbs1_res,
+					     ARRAY_SIZE(usbs1_res))) {
+		board_staging_fixup_irq_resources(usbs1_res,
+						  ARRAY_SIZE(usbs1_res));
 		platform_device_register_simple("emxx_udc", -1, usbs1_res,
 						ARRAY_SIZE(usbs1_res));
+	}
 }
 
 board_staging("renesas,kzm9d", kzm9d_init);
-- 
1.9.1
