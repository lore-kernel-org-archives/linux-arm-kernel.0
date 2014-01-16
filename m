From: b20788@freescale.com (Anson Huang)
Date: Thu, 16 Jan 2014 10:41:45 +0800
Subject: [PATCH V6 3/3] ARM: imx: add suspend in ocram support for i.mx6sl
In-Reply-To: <1389840105-17625-1-git-send-email-b20788@freescale.com>
References: <1389840105-17625-1-git-send-email-b20788@freescale.com>
Message-ID: <1389840105-17625-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL's suspend in ocram function is derived from i.MX6Q,
it can lower the DDR IO power from ~10mA at 1.2V to ~1mA at 1.2V,
measured on i.MX6SL EVK board, SH5.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
Changes since V5:
    1. Improve asm code and make reused code as macro define.

 arch/arm/mach-imx/Makefile       |    2 +-
 arch/arm/mach-imx/pm-imx6q.c     |   18 +++++++++++-
 arch/arm/mach-imx/suspend-imx6.S |   57 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3d96a45..f2df89f 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -105,7 +105,7 @@ ifeq ($(CONFIG_PM),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
 # i.MX6SL reuses i.MX6Q code
-obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
+obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o suspend-imx6.o
 endif
 
 # i.MX5 based machines
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 8c2d912..03e7be4 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -137,6 +137,22 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
 	},
 };
 
+static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
+	.cpu_type = MXC_CPU_IMX6SL,
+	.mmdc_compat = "fsl,imx6sl-mmdc",
+	.src_compat = "fsl,imx6sl-src",
+	.iomuxc_compat = "fsl,imx6sl-iomuxc",
+	.gpc_compat = "fsl,imx6sl-gpc",
+	.mmdc_io_num = 19,
+	.mmdc_io_offset = {
+		0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
+		0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
+		0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
+		0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, MODE_CTL, MODE */
+		0x330, 0x334, 0x320,        /* SDCKE0, SDCKE1, RESET */
+	},
+};
+
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -528,5 +544,5 @@ void __init imx6dl_pm_init(void)
 
 void __init imx6sl_pm_init(void)
 {
-	imx6_pm_common_init(NULL);
+	imx6_pm_common_init(&imx6sl_pm_data);
 }
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index f4930e2..570fede 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -63,6 +63,7 @@
 #define MX6Q_SRC_GPR1	0x20
 #define MX6Q_SRC_GPR2	0x24
 #define MX6Q_MMDC_MAPSR	0x404
+#define MX6Q_MMDC_MPDGCTRL0	0x83c
 #define MX6Q_GPC_IMR1	0x08
 #define MX6Q_GPC_IMR2	0x0c
 #define MX6Q_GPC_IMR3	0x10
@@ -119,6 +120,31 @@
 
 	.endm
 
+	.macro reset_mmdc_read_fifo
+
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+1:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	1b
+
+	/* reset FIFO a second time */
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+2:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	2b
+
+	.endm
+
 ENTRY(imx6_suspend)
 	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
 	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
@@ -178,12 +204,28 @@ poll_dvfs_set:
 	ldr	r7, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
 	ldr	r8, =PM_INFO_MMDC_IO_VAL_OFFSET
 	add	r8, r8, r0
+	/* i.MX6SL's last 3 IOs need special setting */
+	cmp	r3, #MXC_CPU_IMX6SL
+	bne	set_mmdc_io_lpm
+	sub	r7, r7, #0x3
 set_mmdc_io_lpm:
 	ldr	r9, [r8], #0x8
 	str	r6, [r11, r9]
 	subs	r7, r7, #0x1
 	bne	set_mmdc_io_lpm
 
+	cmp 	r3, #MXC_CPU_IMX6SL
+	bne	set_mmdc_io_lpm_done
+	ldr	r6, =0x1000
+	ldr	r9, [r8], #0x8
+	str	r6, [r11, r9]
+	ldr	r9, [r8], #0x8
+	str	r6, [r11, r9]
+	ldr	r6, =0x80000
+	ldr	r9, [r8]
+	str	r6, [r11, r9]
+set_mmdc_io_lpm_done:
+
 	/*
 	 * mask all GPC interrupts before
 	 * enabling the RBC counters to
@@ -259,6 +301,13 @@ rbc_loop:
 	restore_mmdc_io
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
+
+	cmp 	r3, #MXC_CPU_IMX6SL
+	bne	restore_mmdc_io_done
+
+	reset_mmdc_read_fifo
+restore_mmdc_io_done:
+
 	enable_mmdc_access
 
 	/* return to suspend finish */
@@ -286,6 +335,14 @@ resume:
 	restore_mmdc_io
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
+
+	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	cmp 	r3, #MXC_CPU_IMX6SL
+	bne	dsm_restore_mmdc_io_done
+
+	reset_mmdc_read_fifo
+dsm_restore_mmdc_io_done:
+
 	enable_mmdc_access
 
 	mov	pc, lr
-- 
1.7.9.5
