From: b20788@freescale.com (Anson Huang)
Date: Mon, 13 Jan 2014 13:58:38 +0800
Subject: [PATCH V3 5/5] ARM: imx: add suspend in ocram support on i.mx6sl
In-Reply-To: <1389592718-9999-1-git-send-email-b20788@freescale.com>
References: <1389592718-9999-1-git-send-email-b20788@freescale.com>
Message-ID: <1389592718-9999-5-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL's suspend in ocram function is derived from i.MX6Q,
the only difference is the offset of DDR IO pins. It can
lower the DDR IO power from ~10mA at 1.2V to ~1mA at 1.2V,
measured on i.MX6SL EVK board, SH5.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
Changes since V2:
    Do necessary change based on i.mx6q's suspend to ocram
function, only cpu type, MMDC IOs' info need changed, and
need to add i.mx6sl's special setting/operation during suspend/resume.

 arch/arm/mach-imx/Makefile       |    2 +-
 arch/arm/mach-imx/pm-imx6q.c     |   19 ++++++++++
 arch/arm/mach-imx/suspend-imx6.S |   74 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)

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
index 670070b..5350b09 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -67,6 +67,7 @@
 #define MX6_MAX_MMDC_IO_NUM		33
 #define MX6Q_MMDC_IO_NUM		33
 #define MX6DL_MMDC_IO_NUM		33
+#define MX6SL_MMDC_IO_NUM		19
 
 static void __iomem *ccm_base;
 static void __iomem *suspend_ocram_base;
@@ -116,6 +117,14 @@ static u32 imx6dl_mmdc_io_dsm_offset[] = {
 	0x74c			    /* GPR_ADDS */
 };
 
+static u32 imx6sl_mmdc_io_dsm_offset[] = {
+	0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
+	0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
+	0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
+	0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
+	0x330, 0x334, 0x320,	    /* SDCKE0, SDCKE1, RESET */
+};
+
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -448,6 +457,16 @@ static int __init imx6q_ocram_suspend_init(void)
 				readl_relaxed(*(&pm_info->iomuxc_base.vbase) +
 				imx6dl_mmdc_io_dsm_offset[i]);
 		}
+	} else if (cpu_is_imx6sl()) {
+		pm_info->cpu_type = MXC_CPU_IMX6SL;
+		pm_info->mmdc_io_num = MX6SL_MMDC_IO_NUM;
+		for (i = 0; i < MX6SL_MMDC_IO_NUM; i++) {
+			pm_info->mmdc_io_val[i][0] =
+				imx6sl_mmdc_io_dsm_offset[i];
+			pm_info->mmdc_io_val[i][1] =
+				readl_relaxed(*(&pm_info->iomuxc_base.vbase) +
+				imx6sl_mmdc_io_dsm_offset[i]);
+		}
 	}
 
 	imx6_suspend_in_ocram_fn = (void *)fncpy(
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index da1f806..db4fa8d 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -65,6 +65,7 @@
 #define MX6Q_SRC_GPR1	0x20
 #define MX6Q_SRC_GPR2	0x24
 #define MX6Q_MMDC_MAPSR	0x404
+#define MX6Q_MMDC_MPDGCTRL0	0x83c
 #define MX6Q_GPC_IMR1	0x08
 #define MX6Q_GPC_IMR2	0x0c
 #define MX6Q_GPC_IMR3	0x10
@@ -143,10 +144,15 @@ poll_dvfs_set_1:
 	ands	r7, r7, #(1 << 25)
 	beq	poll_dvfs_set_1
 
+	ldr	r10, [r0, #PM_INFO_CPU_TYPE_OFFSET]
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
 	ldr	r6, =0x0
 	ldr	r7, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
 	ldr	r8, =PM_INFO_MMDC_IO_VAL_OFFSET
+	/* i.MX6SL's last 3 IOs need special setting */
+	cmp 	r10, #MXC_CPU_IMX6SL
+	bne	set_mmdc_io_lpm
+	sub	r7, r7, #0x3
 set_mmdc_io_lpm:
 	ldr	r9, [r0, r8]
 	str	r6, [r11, r9]
@@ -155,6 +161,20 @@ set_mmdc_io_lpm:
 	cmp     r7, #0x0
 	bne	set_mmdc_io_lpm
 
+	cmp 	r10, #MXC_CPU_IMX6SL
+	bne	set_mmdc_io_lpm_done
+	ldr	r6, =0x1000
+	ldr	r9, [r0, r8]
+	str	r6, [r11, r9]
+	add	r8, r8, #0x8
+	ldr	r9, [r0, r8]
+	str	r6, [r11, r9]
+	add	r8, r8, #0x8
+	ldr	r6, =0x80000
+	ldr	r9, [r0, r8]
+	str	r6, [r11, r9]
+set_mmdc_io_lpm_done:
+
 	/*
 	 * mask all GPC interrupts before
 	 * enabling the RBC counters to
@@ -239,6 +259,33 @@ restore_mmdc_io:
 	cmp     r6, #0x0
 	bne	restore_mmdc_io
 
+	ldr	r6, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	cmp 	r6, #MXC_CPU_IMX6SL
+	bne	restore_mmdc_io_done
+
+	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+fifo_reset1_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+fifo_reset2_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset2_wait
+restore_mmdc_io_done:
+
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
 	/* let DDR out of self-refresh. */
 	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
@@ -288,6 +335,33 @@ dsm_restore_mmdc_io:
 	cmp     r6, #0x0
 	bne	dsm_restore_mmdc_io
 
+	ldr	r6, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	cmp 	r6, #MXC_CPU_IMX6SL
+	bne	dsm_restore_mmdc_io_done
+
+	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+dsm_fifo_reset1_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+dsm_fifo_reset2_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset2_wait
+dsm_restore_mmdc_io_done:
+
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
 	/* let DDR out of self-refresh */
 	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
-- 
1.7.9.5
