From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 08:40:09 +0200
Subject: [PATCH 5/5] arm: mvebu: parse ATAGS to find the network interfaces
 MAC addresses
In-Reply-To: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370414409-29991-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the atags_to_fdt code stores the ATAGS in /chosen/atags in
the Device Tree, the platform-specific code of Armada 370/XP can parse
those ATAGS, and search for the Marvell custom ATAG that contains the
MAC addresses, and use the newly introduced of_set_mac_address() to
adjust the Device Tree with those MAC addresses.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c | 52 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/armada-370-xp.h | 13 ++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 1c48890..1ee6fa4 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/time-armada-370-xp.h>
@@ -21,10 +22,13 @@
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
 #include <linux/irqchip.h>
+#include <linux/slab.h>
+#include <linux/if_ether.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/setup.h>
 #include "armada-370-xp.h"
 #include "common.h"
 #include "coherency.h"
@@ -73,8 +77,56 @@ void __init armada_370_xp_init_early(void)
 #endif
 }
 
+/* Get MAC address for the legacy ATAGs, if available */
+static void __init armada_370_xp_get_mac_addr(void)
+{
+	const struct tag *atag, *mvatag;
+	const struct tag_mv_uboot *mvubootatag;
+	struct device_node *aliases, *chosen;
+	const void *atag_list;
+	int i;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return;
+
+	atag_list = of_get_property(chosen, "atags", NULL);
+	if (!atag_list)
+		return;
+
+	mvatag = NULL;
+	for_each_tag(atag, atag_list) {
+		if (atag->hdr.tag == ATAG_MV_UBOOT) {
+			mvatag = atag;
+			break;
+		}
+	}
+
+	if (!mvatag)
+		return;
+
+	mvubootatag = ((void *) mvatag) + sizeof(struct tag_header);
+
+	aliases = of_find_node_by_path("/aliases");
+	for (i = 0; i < 4; i++) {
+		struct device_node *ethnode;
+		const char *ethnodepath;
+		char ethname[5];
+		snprintf(ethname, sizeof(ethname), "eth%d", i);
+		if (of_property_read_string(aliases, ethname, &ethnodepath) < 0)
+			continue;
+
+		ethnode = of_find_node_by_path(ethnodepath);
+		if (!ethnode)
+			continue;
+
+		of_set_mac_address(ethnode, mvubootatag->macaddr[i]);
+	}
+}
+
 static void __init armada_370_xp_dt_init(void)
 {
+	armada_370_xp_get_mac_addr();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	coherency_init();
 }
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 2070e1b..329fb66 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -25,6 +25,19 @@
 #define ARMADA_370_XP_SDRAM_WINS_BASE   (ARMADA_370_XP_REGS_PHYS_BASE + 0x20180)
 #define ARMADA_370_XP_SDRAM_WINS_SIZE   0x20
 
+/* Marvell uboot parameters */
+#define ATAG_MV_UBOOT	0x41000403
+
+struct tag_mv_uboot {
+	__u32 uboot_version;
+	__u32 tclk;
+	__u32 sysclk;
+	__u32 isusbhost;
+	__u8  macaddr[4][6];
+	__u16 mtu[4];
+	__u32 nand_ecc;
+};
+
 #ifdef CONFIG_SMP
 #include <linux/cpumask.h>
 
-- 
1.8.1.2
