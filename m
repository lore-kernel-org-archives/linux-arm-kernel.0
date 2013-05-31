From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 May 2013 19:42:06 -0300
Subject: [PATCH v2 1/2] ARM: mxs: Print silicon version on boot
Message-ID: <1370040127-15072-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Introduce functions that identify the SoC type (i.MX23 or iMX28)
and also report the silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use MXS as prefix in the revision definitions
- Retrieve the base address from dt
- Remove unneeded blank line
- Treat 0x0 as TO1.1
- Use u32

 arch/arm/mach-mxs/mach-mxs.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 66fe810..462fa14 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -38,12 +38,27 @@
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
@@ -361,8 +376,79 @@ static void __init cfa10037_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static const char *mxs_get_cpu_type(void)
+{
+	u32 reg;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-digctl");
+	digctl_base = of_iomap(np, 0);
+	WARN_ON(!digctl_base);
+
+	reg = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_CHIPID_MASK;
+	switch (reg) {
+	case HW_DIGCTL_CHIPID_MX23:
+		return "23";
+	case HW_DIGCTL_CHIPID_MX28:
+		return "28";
+	default:
+		return "unknown";
+	}
+}
+
+static int mxs_get_cpu_rev(void)
+{
+	u32 reg, rev;
+
+	reg = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_CHIPID_MASK;
+	rev = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_REV_MASK;
+
+	switch (reg) {
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
+static void mxs_print_silicon_rev(const char *cpu, int srev)
+{
+	if (srev == MXS_CHIP_REV_UNKNOWN)
+		pr_info("CPU identified as i.MX%s, unknown revision\n", cpu);
+	else
+		pr_info("CPU identified as i.MX%s, silicon rev %d.%d\n",
+				cpu, (srev >> 4) & 0xf, srev & 0xf);
+}
+
 static void __init mxs_machine_init(void)
 {
+	const char *cpu_char = mxs_get_cpu_type();
+	int cpu_rev = mxs_get_cpu_rev();
+
+	mxs_print_silicon_rev(cpu_char, cpu_rev);
+
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
-- 
1.8.1.2
