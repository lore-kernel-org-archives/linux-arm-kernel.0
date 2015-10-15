From: j-keerthy@ti.com (Keerthy)
Date: Thu, 15 Oct 2015 10:40:06 +0530
Subject: [PATCH v2 1/3] ARM: OMAP2: DRA7: Modify optimize string comparisons
 in soc_is calls
In-Reply-To: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1444885808-6306-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently everytime soc_is calls are made, firstly device tree nodes
are parsed and then string comparisons are made to determine the
soc version. Optimizing it to be done one time and store the result.
Use the stored value in all the subsequent checks for soc_is calls.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Rebased to latest 4.3-rc5

 arch/arm/mach-omap2/id.c  | 17 +++++++++++++++++
 arch/arm/mach-omap2/soc.h | 15 ++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 8a2ae82..4f497cc 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -40,6 +40,7 @@
 #define OMAP_SOC_MAX_NAME_LENGTH		16
 
 static unsigned int omap_revision;
+static unsigned long soc_ids;
 static char soc_name[OMAP_SOC_MAX_NAME_LENGTH];
 static char soc_rev[OMAP_SOC_MAX_NAME_LENGTH];
 u32 omap_features;
@@ -50,6 +51,21 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
+void init_dra_soc_id(void)
+{
+	if (of_machine_is_compatible("ti,dra7"))
+		soc_ids |= DRA7XX;
+	if (of_machine_is_compatible("ti,dra74"))
+		soc_ids |= DRA74X;
+	if (of_machine_is_compatible("ti,dra72"))
+		soc_ids |= DRA72X;
+}
+
+int check_soc_version(unsigned long id)
+{
+	return soc_ids & id;
+}
+
 int omap_type(void)
 {
 	static u32 val = OMAP2_DEVICETYPE_MASK;
@@ -643,6 +659,7 @@ void __init dra7xxx_check_revision(void)
 	u16 hawkeye;
 	u8 rev;
 
+	init_dra_soc_id();
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index fbb3a16..06d8c96 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -125,6 +125,15 @@
 #define OMAP2_DEVICE_TYPE_GP		3
 #define OMAP2_DEVICE_TYPE_BAD		4
 
+/*
+ * SoC types
+ */
+
+#define DRA7XX				BIT(0)
+#define	DRA74X				BIT(1)
+#define DRA72X				BIT(2)
+
+int check_soc_version(unsigned long id);
 int omap_type(void);
 
 /*
@@ -466,9 +475,9 @@ IS_OMAP_TYPE(3430, 0x3430)
 #undef soc_is_dra7xx
 #undef soc_is_dra74x
 #undef soc_is_dra72x
-#define soc_is_dra7xx()	(of_machine_is_compatible("ti,dra7"))
-#define soc_is_dra74x()	(of_machine_is_compatible("ti,dra74"))
-#define soc_is_dra72x()	(of_machine_is_compatible("ti,dra72"))
+#define soc_is_dra7xx()			check_soc_version(DRA7XX)
+#define soc_is_dra74x()			check_soc_version(DRA74X)
+#define soc_is_dra72x()			check_soc_version(DRA72X)
 #endif
 
 /* Various silicon revisions for omap2 */
-- 
1.9.1
