From: b20788@freescale.com (Anson Huang)
Date: Mon, 13 Jan 2014 13:58:36 +0800
Subject: [PATCH V3 3/5] ARM: imx: add suspend in ocram support on i.mx6dl
In-Reply-To: <1389592718-9999-1-git-send-email-b20788@freescale.com>
References: <1389592718-9999-1-git-send-email-b20788@freescale.com>
Message-ID: <1389592718-9999-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6DL's suspend in ocram function is derived from i.MX6Q,
the only difference is the offset of DDR IO pins. It can
lower the DDR IO power from ~26mA at 1.5V to ~15mA at 1.5V,
measured on i.MX6Q/DL SabreSD board, R25.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
Changes since V2:
    Only do necessary change based on i.mx6q's suspend
to ocram function, only cpu type and MMDC IOs' info need changed.

 arch/arm/mach-imx/pm-imx6q.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 8997f58..670070b 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -66,6 +66,7 @@
 #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
 #define MX6_MAX_MMDC_IO_NUM		33
 #define MX6Q_MMDC_IO_NUM		33
+#define MX6DL_MMDC_IO_NUM		33
 
 static void __iomem *ccm_base;
 static void __iomem *suspend_ocram_base;
@@ -103,6 +104,18 @@ static u32 imx6q_mmdc_io_dsm_offset[] = {
 	0x74c			    /* GPR_ADDS */
 };
 
+static u32 imx6dl_mmdc_io_dsm_offset[] = {
+	0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
+	0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
+	0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
+	0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
+	0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
+	0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
+	0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
+	0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
+	0x74c			    /* GPR_ADDS */
+};
+
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -425,6 +438,16 @@ static int __init imx6q_ocram_suspend_init(void)
 				readl_relaxed(*(&pm_info->iomuxc_base.vbase) +
 				imx6q_mmdc_io_dsm_offset[i]);
 		}
+	} else if (cpu_is_imx6dl()) {
+		pm_info->cpu_type = MXC_CPU_IMX6DL;
+		pm_info->mmdc_io_num = MX6DL_MMDC_IO_NUM;
+		for (i = 0; i < MX6DL_MMDC_IO_NUM; i++) {
+			pm_info->mmdc_io_val[i][0] =
+				imx6dl_mmdc_io_dsm_offset[i];
+			pm_info->mmdc_io_val[i][1] =
+				readl_relaxed(*(&pm_info->iomuxc_base.vbase) +
+				imx6dl_mmdc_io_dsm_offset[i]);
+		}
 	}
 
 	imx6_suspend_in_ocram_fn = (void *)fncpy(
-- 
1.7.9.5
