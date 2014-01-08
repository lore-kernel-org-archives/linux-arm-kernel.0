From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Jan 2014 16:06:27 +0100
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks AX3-4
 board
In-Reply-To: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

This commit add quirk in the mvebu platform code to check the SoC
version and then update the compatible string for the i2c controller
according to the revision of the SoC. Currently only some OpenBlocks
AX3-4 boards are known to use an A0 revision so the check is done only
for these boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-mvebu/armada-370-xp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index e2acff98e750..0f61a4f22fb5 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -21,6 +21,7 @@
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
+#include <linux/slab.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -28,6 +29,7 @@
 #include "armada-370-xp.h"
 #include "common.h"
 #include "coherency.h"
+#include "mvebu-soc-id.h"
 
 static void __init armada_370_xp_map_io(void)
 {
@@ -45,8 +47,38 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 #endif
 }
 
+static void __init i2c_quirk(void)
+{
+	struct device_node *np;
+	u32 dev, rev;
+
+	/*
+	 * Only revisons more recent than A0 support the offload
+	 * mechanism. We can exit only if we are sure that we can
+	 * get the SoC revision and it is more recent than A0.
+	 */
+	if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
+		return;
+
+	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
+		struct property *new_compat;
+
+		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+
+		new_compat->name =  kstrdup("compatible", GFP_KERNEL);
+		new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
+		new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
+						GFP_KERNEL);
+
+		of_update_property(np, new_compat);
+	}
+	return;
+}
+
 static void __init armada_370_xp_dt_init(void)
 {
+	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
+		i2c_quirk();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.1.2
