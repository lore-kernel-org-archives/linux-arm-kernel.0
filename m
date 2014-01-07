From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  7 Jan 2014 17:35:03 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

This commit add quirk in the mvebu platform code to check the SoC
version and then add the "offload-broken" property for the i2c
controller according to the revision of the SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index e2acff98e750..c93ac68779e0 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -21,6 +21,7 @@
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
+#include <linux/mvebu-soc-id.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -45,8 +46,31 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 #endif
 }
 
+static struct property i2c_offload_broken = {
+	.name = "offload-broken",
+};
+
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
+	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c")
+		of_add_property(np, &i2c_offload_broken);
+	return;
+}
+
 static void __init armada_370_xp_dt_init(void)
 {
+	i2c_quirk();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.1.2
