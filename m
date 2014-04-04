From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 15:55:48 +0200
Subject: [PATCH v2 4/6] ARM: mvebu: extend the PMSU registers
In-Reply-To: <1396619750-4790-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396619750-4790-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396619750-4790-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The initial binding for PMSU was wrong, as it didn't take into account
all the registers from the PMSU and moreover it referred to the CPU
reset registers which are not part of PMSU.

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. These registers are needed for the CPU idle
implementation for the Armada 370/XP, it allows to enter a deep CPU
idle state where the Coherency Fabric and the L2 cache are powered
down.

This commit adds support for a new compatible for the PMSU node which
includes the registers related to the coherency fabric. It also keeps
compatibility with the old compatible string.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt         | 14 ++++++--------
 arch/arm/mach-mvebu/pmsu.c                                 | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 926b4d6..9761887 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -4,17 +4,15 @@ Available on Marvell SOCs: Armada 370 and Armada XP
 
 Required properties:
 
-- compatible: "marvell,armada-370-xp-pmsu"
+- compatible: should be "marvell,armada-370-pmsu", whereas
+  "marvell,armada-370-xp-pmsu" is deprecated and will be removed
 
-- reg: Should contain PMSU registers location and length. First pair
-  for the per-CPU SW Reset Control registers, second pair for the
-  Power Management Service Unit.
+- reg: Should contain PMSU registers location and length.
 
 Example:
 
-armada-370-xp-pmsu at d0022000 {
-	compatible = "marvell,armada-370-xp-pmsu";
-	reg = <0xd0022100 0x430>,
-	      <0xd0020800 0x20>;
+armada-370-xp-pmsu at 22000 {
+	compatible = "marvell,armada-370-pmsu";
+	reg = <0x22000 0x1000>;
 };
 
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index b337fe5..4ae3ea1 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -30,10 +30,14 @@
 
 static void __iomem *pmsu_mp_base;
 
-#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
+#define PMSU_BASE_OFFSET    0x100
+#define PMSU_REG_SIZE	    0x1000
+
+#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x124)
 
 static struct of_device_id of_pmsu_table[] = {
-	{.compatible = "marvell,armada-370-xp-pmsu"},
+	{ .compatible = "marvell,armada-370-pmsu", },
+	{ .compatible = "marvell,armada-370-xp-pmsu", },
 	{ /* end of list */ },
 };
 
@@ -80,6 +84,12 @@ static int __init armada_370_xp_pmsu_init(void)
 		goto out;
 	}
 
+	if (of_device_is_compatible(np, "marvell,armada-370-xp-pmsu")) {
+		pr_warn(FW_WARN "deprecated pmsu binding\n");
+		res.start = res.start - PMSU_BASE_OFFSET;
+		res.end = res.start + PMSU_REG_SIZE - 1;
+	}
+
 	if (!request_mem_region(res.start, resource_size(&res),
 				np->full_name)) {
 		pr_err("unable to request region\n");
-- 
1.8.3.2
