From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 29 May 2013 16:44:22 -0300
Subject: [PATCH 1/2] ARM: mxs: Print silicon version on boot
Message-ID: <1369856663-29314-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce functions that identify the SoC type (i.MX23 or iMX28)
and also report the silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 66fe810..b632323 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -38,6 +38,21 @@
 #define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
 #define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
 
+
+#define MXS_DIGCTL_BASE_ADDR	0x8001c000
+#define HW_DIGCTL_CHIPID	0x310
+#define HW_DIGCTL_CHIPID_MASK	(0xffff << 16)
+#define HW_DIGCTL_REV_MASK	0xff
+#define HW_DIGCTL_CHIPID_MX23	(0x3780 << 16)
+#define HW_DIGCTL_CHIPID_MX28	(0x2800 << 16)
+
+#define IMX_CHIP_REVISION_1_0	0x10
+#define IMX_CHIP_REVISION_1_1	0x11
+#define IMX_CHIP_REVISION_1_2	0x12
+#define IMX_CHIP_REVISION_1_3	0x13
+#define IMX_CHIP_REVISION_1_4	0x14
+#define IMX_CHIP_REV_UNKNOWN	0xff
+
 #define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
 
 #define MXS_SET_ADDR		0x4
@@ -361,8 +376,78 @@ static void __init cfa10037_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static const char *mxs_get_cpu_type(void)
+{
+	int reg;
+	void __iomem *digctl_base = ioremap(MXS_DIGCTL_BASE_ADDR, SZ_8K);
+
+	if (!digctl_base)
+		return "unknown";
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
+	int reg, rev;
+	void __iomem *digctl_base = ioremap(MXS_DIGCTL_BASE_ADDR, SZ_8K);
+
+	if (!digctl_base)
+		return -ENOMEM;
+
+	reg = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_CHIPID_MASK;
+	rev = readl(digctl_base + HW_DIGCTL_CHIPID) & HW_DIGCTL_REV_MASK;
+
+	switch (reg) {
+	case HW_DIGCTL_CHIPID_MX23:
+		switch (rev) {
+		case 0x0:
+			return IMX_CHIP_REVISION_1_0;
+		case 0x1:
+			return IMX_CHIP_REVISION_1_1;
+		case 0x2:
+			return IMX_CHIP_REVISION_1_2;
+		case 0x3:
+			return IMX_CHIP_REVISION_1_3;
+		case 0x4:
+			return IMX_CHIP_REVISION_1_4;
+		default:
+			return IMX_CHIP_REV_UNKNOWN;
+		}
+	case HW_DIGCTL_CHIPID_MX28:
+		switch (rev) {
+		case 0x1:
+			return IMX_CHIP_REVISION_1_2;
+		default:
+			return IMX_CHIP_REV_UNKNOWN;
+		}
+	default:
+		return IMX_CHIP_REV_UNKNOWN;
+	}
+}
+
+static void mxs_print_silicon_rev(const char *cpu, int srev)
+{
+	if (srev == IMX_CHIP_REV_UNKNOWN)
+		pr_info("CPU identified as i.MX%s, unknown revision\n", cpu);
+	else
+		pr_info("CPU identified as i.MX%s, silicon rev %d.%d\n",
+				cpu, (srev >> 4) & 0xf, srev & 0xf);
+}
+
 static void __init mxs_machine_init(void)
 {
+
+	mxs_print_silicon_rev(mxs_get_cpu_type(), mxs_get_cpu_rev());
+
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
-- 
1.8.1.2
