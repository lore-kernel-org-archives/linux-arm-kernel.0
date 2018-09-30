From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 30 Sep 2018 11:32:26 +0800
Subject: [PATCH V3 1/3] ARM: imx: add i.mx6ulz msl support
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1538278348-7716-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 6ULZ processor is a high-performance, ultra
cost-efficient consumer Linux processor featuring an
advanced implementation of a single Arm? Cortex?-A7 core,
which operates at speeds up to 900 MHz.

This patch adds basic MSL support for i.MX6ULZ, the
i.MX6ULZ has same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6]
is to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means
i.MX6ULZ and 1'b0 means i.MX6ULL.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	remove "fsl,imx6ulz" on kernel side and add "fsl,imx6ull" into DT machine compatible
	to save code change on kernel side, as well as clock driver.
 arch/arm/mach-imx/anatop.c  | 20 ++++++++++++++++++++
 arch/arm/mach-imx/cpu.c     |  3 +++
 arch/arm/mach-imx/mxc.h     |  7 +++++++
 arch/arm/mach-imx/pm-imx6.c |  4 ++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 61f3d94..45d618a 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -31,6 +31,8 @@
 #define ANADIG_DIGPROG_IMX6SL	0x280
 #define ANADIG_DIGPROG_IMX7D	0x800
 
+#define SRC_SBMR2		0x1c
+
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
@@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
 		major_part = (digprog >> 8) & 0xf;
 		minor_part = digprog & 0xf;
 		revision = ((major_part + 1) << 4) | minor_part;
+
+		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
+			void __iomem *src_base;
+			u32 sbmr2;
+
+			np = of_find_compatible_node(NULL, NULL,
+						     "fsl,imx6ul-src");
+			src_base = of_iomap(np, 0);
+			WARN_ON(!src_base);
+			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
+			iounmap(src_base);
+
+			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
+			if (sbmr2 & (1 << 6)) {
+				digprog &= ~(0xff << 16);
+				digprog |= (MXC_CPU_IMX6ULZ << 16);
+			}
+		}
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c6b1bf9..c73593e 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6ULL:
 		soc_id = "i.MX6ULL";
 		break;
+	case MXC_CPU_IMX6ULZ:
+		soc_id = "i.MX6ULZ";
+		break;
 	case MXC_CPU_IMX6SLL:
 		soc_id = "i.MX6SLL";
 		break;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 026e2ca..b130a53 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -40,6 +40,8 @@
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
+/* virtual cpu id for i.mx6ulz */
+#define MXC_CPU_IMX6ULZ		0x6b
 #define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
@@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
 }
 
+static inline bool cpu_is_imx6ulz(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULZ;
+}
+
 static inline bool cpu_is_imx6sll(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 529f4b5..87f45b9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -331,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4
