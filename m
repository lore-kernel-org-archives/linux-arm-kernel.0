From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 2 Dec 2016 14:39:32 +0800
Subject: [PATCH 09/11] ARM: imx: correct i.mx6sll dram io low power mode
In-Reply-To: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480660774-25055-10-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL has different DRAM IO offset, and it has no
CAS/RAS/ODT/RESET pin now, correct the DRAM IO offset.

To better support all different i.MX6 SoCs and different
DRAM types, introduce a new column to store the low power
settings for DRAM IO, then suspend asm code no need to check
SoC or DRAM type, just get the DRAM IO's low power
settings from OCRAM pm_info and set to each DRAM IO.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c      | 17 ++++++++++++++++-
 arch/arm/mach-imx/suspend-imx6.S | 29 +++++++----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 2ed4316..5fb78a9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -230,7 +230,7 @@ struct imx6_cpu_pm_info {
 	struct imx6_pm_base gpc_base;
 	struct imx6_pm_base l2_base;
 	u32 mmdc_io_num; /* Number of MMDC IOs which need saved/restored. */
-	u32 mmdc_io_val[MX6_MAX_MMDC_IO_NUM][2]; /* To save offset and value */
+	u32 mmdc_io_val[MX6_MAX_MMDC_IO_NUM][3]; /* To save offset,value and low power setting */
 } __aligned(8);
 
 void imx6_set_int_mem_clk_lpm(bool enable)
@@ -570,6 +570,21 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 		pm_info->mmdc_io_val[i][1] =
 			readl_relaxed(pm_info->iomuxc_base.vbase +
 			mmdc_offset_array[i]);
+		pm_info->mmdc_io_val[i][2] = 0;
+
+	}
+
+	/* i.MX6SLL has no DRAM RESET pin */
+	if (cpu_is_imx6sll()) {
+		pm_info->mmdc_io_val[pm_info->mmdc_io_num - 2][2] = 0x1000;
+		pm_info->mmdc_io_val[pm_info->mmdc_io_num - 1][2] = 0x1000;
+	} else {
+		if (pm_info->ddr_type == IMX_DDR_TYPE_LPDDR2) {
+			 /* for LPDDR2, CKE0/1 and RESET pin need special setting */
+			pm_info->mmdc_io_val[pm_info->mmdc_io_num - 3][2] = 0x1000;
+			pm_info->mmdc_io_val[pm_info->mmdc_io_num - 2][2] = 0x1000;
+			pm_info->mmdc_io_val[pm_info->mmdc_io_num - 1][2] = 0x80000;
+		}
 	}
 
 	imx6_suspend_in_ocram_fn = fncpy(
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 76ee2ce..c9a26f4 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -104,7 +104,7 @@
 	add	r7, r7, r0
 1:
 	ldr	r8, [r7], #0x4
-	ldr	r9, [r7], #0x4
+	ldr	r9, [r7], #0x8
 	str	r9, [r11, r8]
 	subs	r6, r6, #0x1
 	bne	1b
@@ -179,7 +179,6 @@ ENTRY(imx6_suspend)
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
 	ldr	r6, [r11, #0x0]
 
-	/* use r11 to store the IO address */
 	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_V_OFFSET]
 	/* store physical resume addr and pm_info address. */
 	str	r9, [r11, #MX6Q_SRC_GPR1]
@@ -207,32 +206,18 @@ poll_dvfs_set:
 	ands	r7, r7, #(1 << 25)
 	beq	poll_dvfs_set
 
+	/* use r11 to store the IO address */
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
-	ldr	r6, =0x0
-	ldr	r7, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
+	ldr	r6, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
 	ldr	r8, =PM_INFO_MMDC_IO_VAL_OFFSET
 	add	r8, r8, r0
-	/* LPDDR2's last 3 IOs need special setting */
-	cmp	r3, #IMX_DDR_TYPE_LPDDR2
-	subeq	r7, r7, #0x3
 set_mmdc_io_lpm:
-	ldr	r9, [r8], #0x8
-	str	r6, [r11, r9]
-	subs	r7, r7, #0x1
+	ldr	r7, [r8], #0x8
+	ldr	r9, [r8], #0x4
+	str	r9, [r11, r7]
+	subs	r6, r6, #0x1
 	bne	set_mmdc_io_lpm
 
-	cmp 	r3, #IMX_DDR_TYPE_LPDDR2
-	bne	set_mmdc_io_lpm_done
-	ldr	r6, =0x1000
-	ldr	r9, [r8], #0x8
-	str	r6, [r11, r9]
-	ldr	r9, [r8], #0x8
-	str	r6, [r11, r9]
-	ldr	r6, =0x80000
-	ldr	r9, [r8]
-	str	r6, [r11, r9]
-set_mmdc_io_lpm_done:
-
 	/*
 	 * mask all GPC interrupts before
 	 * enabling the RBC counters to
-- 
1.9.1
