From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  9 Jul 2014 15:40:13 +0200
Subject: [PATCHv2 09/17] ARM: mvebu: export the SCU address
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404913221-17343-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The SCU address will be needed in other files than board-v7.c,
especially in pmsu.c for cpuidle related activities. So this patch
adds a function that allows to retrieve the virtual address at which
the SCU has been mapped.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 9 +++++++--
 arch/arm/mach-mvebu/common.h   | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index f244622..6478626 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -34,14 +34,14 @@
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
+static void __iomem *scu_base;
+
 /*
  * Enables the SCU when available. Obviously, this is only useful on
  * Cortex-A based SOCs, not on PJ4B based ones.
  */
 static void __init mvebu_scu_enable(void)
 {
-	void __iomem *scu_base;
-
 	struct device_node *np =
 		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 	if (np) {
@@ -51,6 +51,11 @@ static void __init mvebu_scu_enable(void)
 	}
 }
 
+void __iomem *mvebu_get_scu_base(void)
+{
+	return scu_base;
+}
+
 /*
  * Early versions of Armada 375 SoC have a bug where the BootROM
  * leaves an external data abort pending. The kernel is hit by this
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index a97778e..3ccb40c 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -23,4 +23,6 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
+void __iomem *mvebu_get_scu_base(void);
+
 #endif
-- 
2.0.0
