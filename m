From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  3 Jun 2013 19:52:24 -0300
Subject: [PATCH] ARM: mxs: Use soc bus infrastructure 
Message-ID: <1370299944-7656-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the soc bus infrastructure is helpful for reporting several SoC related
information such as: family, machine, SoC name and SoC revision.

$ cat /sys/bus/soc/devices/soc0/family 
Freescale MXS Family

$ cat /sys/bus/soc/devices/soc0/machine 
Freescale i.MX28 Evaluation Kit

$ cat /sys/bus/soc/devices/soc0/soc_id 
i.MX28

$ cat /sys/bus/soc/devices/soc0/revision 
TO1.2 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/Kconfig    |   1 +
 arch/arm/mach-mxs/mach-mxs.c | 117 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4dc2fbb..59c30ef 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -25,6 +25,7 @@ config ARCH_MXS
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK_PREPARE
 	select PINCTRL
+	select SOC_BUS
 	select SOC_IMX23
 	select SOC_IMX28
 	select STMP_DEVICE
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index bd225e9..bc72393 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -25,6 +25,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/sys_soc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -38,12 +39,27 @@
 #define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
 #define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
 
+#define HW_DIGCTL_CHIPID	0x310
+#define HW_DIGCTL_CHIPID_MASK	(0xffff << 16)
+#define HW_DIGCTL_REV_MASK	0xff
+#define HW_DIGCTL_CHIPID_MX23	(0x3780 << 16)
+#define HW_DIGCTL_CHIPID_MX28	(0x2800 << 16)
+
+#define MXS_CHIP_REVISION_1_0	0x10
+#define MXS_CHIP_REVISION_1_1	0x11
+#define MXS_CHIP_REVISION_1_2	0x12
+#define MXS_CHIP_REVISION_1_3	0x13
+#define MXS_CHIP_REVISION_1_4	0x14
+#define MXS_CHIP_REV_UNKNOWN	0xff
+
 #define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
 
 #define MXS_SET_ADDR		0x4
 #define MXS_CLR_ADDR		0x8
 #define MXS_TOG_ADDR		0xc
 
+static void __iomem *digctl_base;
+
 static inline void __mxs_setl(u32 mask, void __iomem *reg)
 {
 	__raw_writel(mask, reg + MXS_SET_ADDR);
@@ -361,8 +377,107 @@ static void __init cfa10037_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static const char __init *mxs_get_soc_id(void)
+{
+	u32 socid;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-digctl");
+	digctl_base = of_iomap(np, 0);
+	WARN_ON(!digctl_base);
+
+	socid = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_CHIPID_MASK;
+	switch (socid) {
+	case HW_DIGCTL_CHIPID_MX23:
+		return "i.MX23";
+	case HW_DIGCTL_CHIPID_MX28:
+		return "i.MX28";
+	default:
+		return "unknown";
+	}
+}
+
+static int __init mxs_get_cpu_rev(void)
+{
+	u32 socid, rev;
+
+	socid = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_CHIPID_MASK;
+	rev = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_REV_MASK;
+
+	switch (socid) {
+	case HW_DIGCTL_CHIPID_MX23:
+		switch (rev) {
+		case 0x0:
+			return MXS_CHIP_REVISION_1_0;
+		case 0x1:
+			return MXS_CHIP_REVISION_1_1;
+		case 0x2:
+			return MXS_CHIP_REVISION_1_2;
+		case 0x3:
+			return MXS_CHIP_REVISION_1_3;
+		case 0x4:
+			return MXS_CHIP_REVISION_1_4;
+		default:
+			return MXS_CHIP_REV_UNKNOWN;
+		}
+	case HW_DIGCTL_CHIPID_MX28:
+		switch (rev) {
+		case 0x0:
+			return MXS_CHIP_REVISION_1_1;
+		case 0x1:
+			return MXS_CHIP_REVISION_1_2;
+		default:
+			return MXS_CHIP_REV_UNKNOWN;
+		}
+	default:
+		return MXS_CHIP_REV_UNKNOWN;
+	}
+}
+
+static const char __init *mxs_get_revision(void)
+{
+	u32 rev = mxs_get_cpu_rev();
+
+	if (rev != MXS_CHIP_REV_UNKNOWN)
+		return kasprintf(GFP_KERNEL, "TO%d.%d", (rev >> 4) & 0xf,
+				rev & 0xf);
+
+	else
+		return kasprintf(GFP_KERNEL, "%s", "Unknown");
+}
+
 static void __init mxs_machine_init(void)
 {
+	struct device_node *root;
+	struct device *parent;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	int ret;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return;
+
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		return;
+
+	soc_dev_attr->family = "Freescale MXS Family";
+	soc_dev_attr->soc_id = mxs_get_soc_id();
+	soc_dev_attr->revision = mxs_get_revision();
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
@@ -373,7 +488,7 @@ static void __init mxs_machine_init(void)
 		cfa10049_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
-			     mxs_auxdata_lookup, NULL);
+			     mxs_auxdata_lookup, parent);
 
 	if (of_machine_is_compatible("karo,tx28"))
 		tx28_post_init();
-- 
1.8.1.2
