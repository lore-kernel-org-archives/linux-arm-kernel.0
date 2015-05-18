From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 18 May 2015 11:50:07 +0530
Subject: [PATCH v1 2/2] ARM: vf610: Add SoC bus support for Vybrid
In-Reply-To: <cover.1431928866.git.maitysanchayan@gmail.com>
References: <cover.1431928866.git.maitysanchayan@gmail.com>
Message-ID: <653ed53ef933a6834c4fd3c90ee47e5fb5c78160.1431928866.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implements SoC bus support to export SoC specific information. Read
the unique SoC ID from the Vybrid On Chip One Time Programmable
(OCOTP) controller, SoC specific information from the Miscellaneous
System Control Module (MSCM), revision from the ROM revision register
and expose it via the SoC bus infrastructure.

Sample Output:

root at vf:/sys/devices/soc0# cat soc_id
df63c12a2e2161d4
root at vf:/sys/devices/soc0# cat family
Freescale Vybrid VF500
root at vf:/sys/devices/soc0# cat revision
00000013
root at vf:/sys/devices/soc0# cat machine
Freescale Vybrid

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/mach-imx/mach-vf610.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 2e7c75b..64c78e4 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -11,6 +11,86 @@
 #include <linux/irqchip.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/random.h>
+
+#define OCOTP_CFG0_OFFSET      0x00000410
+#define OCOTP_CFG1_OFFSET      0x00000420
+#define MSCM_CPxCOUNT_OFFSET   0x0000002C
+#define MSCM_CPxCFG1_OFFSET    0x00000014
+#define ROM_REVISION_OFFSET    0x00000080
+
+static void __init vf610_init_machine(void)
+{
+	struct regmap *ocotp_regmap, *mscm_regmap, *rom_regmap;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device *parent = NULL;
+	struct soc_device *soc_dev;
+	char soc_type[] = "xx0";
+	u32 cpxcount, cpxcfg1;
+	u32 soc_id1, soc_id2, rom_rev;
+	u64 soc_id;
+
+	ocotp_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocotp");
+	if (IS_ERR(ocotp_regmap)) {
+		pr_err("regmap lookup for octop failed\n");
+		goto out;
+	}
+
+	mscm_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-mscm-cpucfg");
+	if (IS_ERR(mscm_regmap)) {
+		pr_err("regmap lookup for mscm failed");
+		goto out;
+	}
+
+	rom_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocrom");
+	if (IS_ERR(rom_regmap)) {
+		pr_err("regmap lookup for ocrom failed");
+		goto out;
+	}
+
+	regmap_read(ocotp_regmap, OCOTP_CFG0_OFFSET, &soc_id1);
+	regmap_read(ocotp_regmap, OCOTP_CFG1_OFFSET, &soc_id2);
+
+	soc_id = (u64) soc_id1 << 32 | soc_id2;
+	add_device_randomness(&soc_id, sizeof(soc_id));
+
+	regmap_read(mscm_regmap, MSCM_CPxCOUNT_OFFSET, &cpxcount);
+	regmap_read(mscm_regmap, MSCM_CPxCFG1_OFFSET, &cpxcfg1);
+
+	soc_type[0] = cpxcount ? '6' : '5'; /* Dual Core => VF6x0 */
+	soc_type[1] = cpxcfg1 ? '1' : '0'; /* L2 Cache => VFx10 */
+
+	regmap_read(rom_regmap, ROM_REVISION_OFFSET, &rom_rev);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		goto out;
+
+	soc_dev_attr->machine = kasprintf(GFP_KERNEL, "Freescale Vybrid");
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%016llx", soc_id);
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Freescale Vybrid VF%s",
+								 soc_type);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%08x", rom_rev);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr->machine);
+		kfree(soc_dev_attr);
+		goto out;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+
+out:
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+}
 
 static const char * const vf610_dt_compat[] __initconst = {
 	"fsl,vf500",
@@ -23,5 +103,6 @@ static const char * const vf610_dt_compat[] __initconst = {
 DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF5xx/VF6xx (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.init_machine = vf610_init_machine,
 	.dt_compat	= vf610_dt_compat,
 MACHINE_END
-- 
2.4.1
