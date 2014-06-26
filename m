From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Jun 2014 15:42:58 +0200
Subject: [PATCH] ARM: mvebu: Enable SCU Speculative linefills to L2 for Armada
 375/38x
Message-ID: <1403790178-23902-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

When set, coherent linefill requests are sent speculatively to the
L2C-310 in parallel with the tag look-up. If the tag look-up misses,
the confirmed linefill is sent to the L2C-310 and gets RDATA earlier
because the data request was already initiated by the speculative
request.

This feature may improve overall system performance.

[Gregory: use a define for the SCU Speculative linefills enable bit,
modify the title of the patch]

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 8bb742fdf5ca..c9b02651e895 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -33,6 +33,10 @@
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
+#define SCU_CTRL		0x00
+#define SCU_SPEC_LINEFILL_EN	    BIT(3)
+
+
 /*
  * Enables the SCU when available. Obviously, this is only useful on
  * Cortex-A based SOCs, not on PJ4B based ones.
@@ -44,7 +48,15 @@ static void __init mvebu_scu_enable(void)
 	struct device_node *np =
 		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 	if (np) {
+		u32 scu_ctrl;
 		scu_base = of_iomap(np, 0);
+		/* already enabled? */
+		scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+		if (!(scu_ctrl & 1)) {
+			/* Enable SCU Speculative linefills to L2 */
+			scu_ctrl |= SCU_SPEC_LINEFILL_EN;
+			__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+		}
 		scu_enable(scu_base);
 		of_node_put(np);
 	}
-- 
1.8.1.2
