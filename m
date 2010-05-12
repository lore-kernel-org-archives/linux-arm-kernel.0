From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:34 -0700
Subject: [PATCH 05/25] msm: generalize clock support.
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'PCOM' method of clock control (commands issued to the radio
CPU) is shared across several (but not all) Qualcomm SOCs.
Generalize this clock mechanism so these other SOCs can be added.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Makefile             |    2 +-
 arch/arm/mach-msm/board-halibut.c      |    2 +-
 arch/arm/mach-msm/board-trout.c        |    2 +-
 arch/arm/mach-msm/clock-7x01a.c        |  126 ----------------
 arch/arm/mach-msm/clock-pcom.c         |  131 ++++++++++++++++
 arch/arm/mach-msm/clock-pcom.h         |  153 +++++++++++++++++++
 arch/arm/mach-msm/clock.c              |  257 +++++++++++++++++++++++---------
 arch/arm/mach-msm/clock.h              |   70 ++++++++-
 arch/arm/mach-msm/devices-msm7x00.c    |   47 ++++++
 arch/arm/mach-msm/devices.h            |    5 +
 arch/arm/mach-msm/include/mach/board.h |    5 +-
 arch/arm/mach-msm/include/mach/clk.h   |   57 +++++++
 12 files changed, 651 insertions(+), 206 deletions(-)
 delete mode 100644 arch/arm/mach-msm/clock-7x01a.c
 create mode 100644 arch/arm/mach-msm/clock-pcom.c
 create mode 100644 arch/arm/mach-msm/clock-pcom.h
 create mode 100644 arch/arm/mach-msm/include/mach/clk.h

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 435d83c..70fa970 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -2,7 +2,7 @@ obj-y += io.o idle.o irq.o timer.o dma.o
 obj-y += proc_comm.o
 obj-y += vreg.o
 obj-y += acpuclock-arm11.o
-obj-y += clock.o clock-7x01a.o
+obj-y += clock.o clock-pcom.o
 
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index acc2288..7bd72e8 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -90,7 +90,7 @@ static void __init halibut_fixup(struct machine_desc *desc, struct tag *tags,
 static void __init halibut_map_io(void)
 {
 	msm_map_common_io();
-	msm_clock_init();
+	msm_clock_init(msm_clocks_7x01a, msm_num_clocks_7x01a);
 }
 
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index b88aec2..dca5a5f 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -78,7 +78,7 @@ static void __init trout_map_io(void)
 	writeb(0x80, TROUT_CPLD_BASE + 0x00);
 #endif
 
-	msm_clock_init();
+	msm_clock_init(msm_clocks_7x01a, msm_num_clocks_7x01a);
 }
 
 MACHINE_START(TROUT, "HTC Dream")
diff --git a/arch/arm/mach-msm/clock-7x01a.c b/arch/arm/mach-msm/clock-7x01a.c
deleted file mode 100644
index 62230a3..0000000
--- a/arch/arm/mach-msm/clock-7x01a.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/* arch/arm/mach-msm/clock-7x01a.c
- *
- * Clock tables for MSM7X01A
- *
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2007 QUALCOMM Incorporated
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include "clock.h"
-#include "devices.h"
-
-/* clock IDs used by the modem processor */
-
-#define ACPU_CLK	0   /* Applications processor clock */
-#define ADM_CLK		1   /* Applications data mover clock */
-#define ADSP_CLK	2   /* ADSP clock */
-#define EBI1_CLK	3   /* External bus interface 1 clock */
-#define EBI2_CLK	4   /* External bus interface 2 clock */
-#define ECODEC_CLK	5   /* External CODEC clock */
-#define EMDH_CLK	6   /* External MDDI host clock */
-#define GP_CLK		7   /* General purpose clock */
-#define GRP_CLK		8   /* Graphics clock */
-#define I2C_CLK		9   /* I2C clock */
-#define ICODEC_RX_CLK	10  /* Internal CODEX RX clock */
-#define ICODEC_TX_CLK	11  /* Internal CODEX TX clock */
-#define IMEM_CLK	12  /* Internal graphics memory clock */
-#define MDC_CLK		13  /* MDDI client clock */
-#define MDP_CLK		14  /* Mobile display processor clock */
-#define PBUS_CLK	15  /* Peripheral bus clock */
-#define PCM_CLK		16  /* PCM clock */
-#define PMDH_CLK	17  /* Primary MDDI host clock */
-#define SDAC_CLK	18  /* Stereo DAC clock */
-#define SDC1_CLK	19  /* Secure Digital Card clocks */
-#define SDC1_PCLK	20
-#define SDC2_CLK	21
-#define SDC2_PCLK	22
-#define SDC3_CLK	23
-#define SDC3_PCLK	24
-#define SDC4_CLK	25
-#define SDC4_PCLK	26
-#define TSIF_CLK	27  /* Transport Stream Interface clocks */
-#define TSIF_REF_CLK	28
-#define TV_DAC_CLK	29  /* TV clocks */
-#define TV_ENC_CLK	30
-#define UART1_CLK	31  /* UART clocks */
-#define UART2_CLK	32
-#define UART3_CLK	33
-#define UART1DM_CLK	34
-#define UART2DM_CLK	35
-#define USB_HS_CLK	36  /* High speed USB core clock */
-#define USB_HS_PCLK	37  /* High speed USB pbus clock */
-#define USB_OTG_CLK	38  /* Full speed USB clock */
-#define VDC_CLK		39  /* Video controller clock */
-#define VFE_CLK		40  /* Camera / Video Front End clock */
-#define VFE_MDC_CLK	41  /* VFE MDDI client clock */
-
-#define NR_CLKS		42
-
-#define CLOCK(clk_name, clk_id, clk_dev, clk_flags) {	\
-	.name = clk_name, \
-	.id = clk_id, \
-	.flags = clk_flags, \
-	.dev = clk_dev, \
-	}
-
-#define OFF CLKFLAG_AUTO_OFF
-#define MINMAX CLKFLAG_USE_MIN_MAX_TO_SET
-
-struct clk msm_clocks[] = {
-	CLOCK("adm_clk",	ADM_CLK,	NULL, 0),
-	CLOCK("adsp_clk",	ADSP_CLK,	NULL, 0),
-	CLOCK("ebi1_clk",	EBI1_CLK,	NULL, 0),
-	CLOCK("ebi2_clk",	EBI2_CLK,	NULL, 0),
-	CLOCK("ecodec_clk",	ECODEC_CLK,	NULL, 0),
-	CLOCK("emdh_clk",	EMDH_CLK,	NULL, OFF),
-	CLOCK("gp_clk",		GP_CLK,		NULL, 0),
-	CLOCK("grp_clk",	GRP_CLK,	NULL, OFF),
-	CLOCK("i2c_clk",	I2C_CLK,	&msm_device_i2c.dev, 0),
-	CLOCK("icodec_rx_clk",	ICODEC_RX_CLK,	NULL, 0),
-	CLOCK("icodec_tx_clk",	ICODEC_TX_CLK,	NULL, 0),
-	CLOCK("imem_clk",	IMEM_CLK,	NULL, OFF),
-	CLOCK("mdc_clk",	MDC_CLK,	NULL, 0),
-	CLOCK("mdp_clk",	MDP_CLK,	NULL, OFF),
-	CLOCK("pbus_clk",	PBUS_CLK,	NULL, 0),
-	CLOCK("pcm_clk",	PCM_CLK,	NULL, 0),
-	CLOCK("pmdh_clk",	PMDH_CLK,	NULL, OFF | MINMAX),
-	CLOCK("sdac_clk",	SDAC_CLK,	NULL, OFF),
-	CLOCK("sdc_clk",	SDC1_CLK,	&msm_device_sdc1.dev, OFF),
-	CLOCK("sdc_pclk",	SDC1_PCLK,	&msm_device_sdc1.dev, OFF),
-	CLOCK("sdc_clk",	SDC2_CLK,	&msm_device_sdc2.dev, OFF),
-	CLOCK("sdc_pclk",	SDC2_PCLK,	&msm_device_sdc2.dev, OFF),
-	CLOCK("sdc_clk",	SDC3_CLK,	&msm_device_sdc3.dev, OFF),
-	CLOCK("sdc_pclk",	SDC3_PCLK,	&msm_device_sdc3.dev, OFF),
-	CLOCK("sdc_clk",	SDC4_CLK,	&msm_device_sdc4.dev, OFF),
-	CLOCK("sdc_pclk",	SDC4_PCLK,	&msm_device_sdc4.dev, OFF),
-	CLOCK("tsif_clk",	TSIF_CLK,	NULL, 0),
-	CLOCK("tsif_ref_clk",	TSIF_REF_CLK,	NULL, 0),
-	CLOCK("tv_dac_clk",	TV_DAC_CLK,	NULL, 0),
-	CLOCK("tv_enc_clk",	TV_ENC_CLK,	NULL, 0),
-	CLOCK("uart_clk",	UART1_CLK,	&msm_device_uart1.dev, OFF),
-	CLOCK("uart_clk",	UART2_CLK,	&msm_device_uart2.dev, 0),
-	CLOCK("uart_clk",	UART3_CLK,	&msm_device_uart3.dev, OFF),
-	CLOCK("uart1dm_clk",	UART1DM_CLK,	NULL, OFF),
-	CLOCK("uart2dm_clk",	UART2DM_CLK,	NULL, 0),
-	CLOCK("usb_hs_clk",	USB_HS_CLK,	&msm_device_hsusb.dev, OFF),
-	CLOCK("usb_hs_pclk",	USB_HS_PCLK,	&msm_device_hsusb.dev, OFF),
-	CLOCK("usb_otg_clk",	USB_OTG_CLK,	NULL, 0),
-	CLOCK("vdc_clk",	VDC_CLK,	NULL, OFF | MINMAX),
-	CLOCK("vfe_clk",	VFE_CLK,	NULL, OFF),
-	CLOCK("vfe_mdc_clk",	VFE_MDC_CLK,	NULL, OFF),
-};
-
-unsigned msm_num_clocks = ARRAY_SIZE(msm_clocks);
diff --git a/arch/arm/mach-msm/clock-pcom.c b/arch/arm/mach-msm/clock-pcom.c
new file mode 100644
index 0000000..a3b4562
--- /dev/null
+++ b/arch/arm/mach-msm/clock-pcom.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/ctype.h>
+#include <linux/stddef.h>
+#include <mach/clk.h>
+
+#include "proc_comm.h"
+#include "clock.h"
+
+/*
+ * glue for the proc_comm interface
+ */
+int pc_clk_enable(unsigned id)
+{
+	int rc = msm_proc_comm(PCOM_CLKCTL_RPC_ENABLE, &id, NULL);
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+void pc_clk_disable(unsigned id)
+{
+	msm_proc_comm(PCOM_CLKCTL_RPC_DISABLE, &id, NULL);
+}
+
+int pc_clk_reset(unsigned id, enum clk_reset_action action)
+{
+	int rc;
+
+	if (action == CLK_RESET_ASSERT)
+		rc = msm_proc_comm(PCOM_CLKCTL_RPC_RESET_ASSERT, &id, NULL);
+	else
+		rc = msm_proc_comm(PCOM_CLKCTL_RPC_RESET_DEASSERT, &id, NULL);
+
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+int pc_clk_set_rate(unsigned id, unsigned rate)
+{
+	/* The rate _might_ be rounded off to the nearest KHz value by the
+	 * remote function. So a return value of 0 doesn't necessarily mean
+	 * that the exact rate was set successfully.
+	 */
+	int rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+int pc_clk_set_min_rate(unsigned id, unsigned rate)
+{
+	int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+int pc_clk_set_max_rate(unsigned id, unsigned rate)
+{
+	int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MAX_RATE, &id, &rate);
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+int pc_clk_set_flags(unsigned id, unsigned flags)
+{
+	int rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_FLAGS, &id, &flags);
+	if (rc < 0)
+		return rc;
+	else
+		return (int)id < 0 ? -EINVAL : 0;
+}
+
+unsigned pc_clk_get_rate(unsigned id)
+{
+	if (msm_proc_comm(PCOM_CLKCTL_RPC_RATE, &id, NULL))
+		return 0;
+	else
+		return id;
+}
+
+unsigned pc_clk_is_enabled(unsigned id)
+{
+	if (msm_proc_comm(PCOM_CLKCTL_RPC_ENABLED, &id, NULL))
+		return 0;
+	else
+		return id;
+}
+
+long pc_clk_round_rate(unsigned id, unsigned rate)
+{
+
+	/* Not really supported; pc_clk_set_rate() does rounding on it's own. */
+	return rate;
+}
+
+struct clk_ops clk_ops_pcom = {
+	.enable = pc_clk_enable,
+	.disable = pc_clk_disable,
+	.auto_off = pc_clk_disable,
+	.reset = pc_clk_reset,
+	.set_rate = pc_clk_set_rate,
+	.set_min_rate = pc_clk_set_min_rate,
+	.set_max_rate = pc_clk_set_max_rate,
+	.set_flags = pc_clk_set_flags,
+	.get_rate = pc_clk_get_rate,
+	.is_enabled = pc_clk_is_enabled,
+	.round_rate = pc_clk_round_rate,
+};
diff --git a/arch/arm/mach-msm/clock-pcom.h b/arch/arm/mach-msm/clock-pcom.h
new file mode 100644
index 0000000..17d027b
--- /dev/null
+++ b/arch/arm/mach-msm/clock-pcom.h
@@ -0,0 +1,153 @@
+/* Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above
+ *       copyright notice, this list of conditions and the following
+ *       disclaimer in the documentation and/or other materials provided
+ *       with the distribution.
+ *     * Neither the name of Code Aurora Forum, Inc. nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#ifndef __ARCH_ARM_MACH_MSM_CLOCK_PCOM_H
+#define __ARCH_ARM_MACH_MSM_CLOCK_PCOM_H
+
+/* clock IDs used by the modem processor */
+
+#define P_ACPU_CLK	0   /* Applications processor clock */
+#define P_ADM_CLK	1   /* Applications data mover clock */
+#define P_ADSP_CLK	2   /* ADSP clock */
+#define P_EBI1_CLK	3   /* External bus interface 1 clock */
+#define P_EBI2_CLK	4   /* External bus interface 2 clock */
+#define P_ECODEC_CLK	5   /* External CODEC clock */
+#define P_EMDH_CLK	6   /* External MDDI host clock */
+#define P_GP_CLK	7   /* General purpose clock */
+#define P_GRP_3D_CLK	8   /* Graphics clock */
+#define P_I2C_CLK	9   /* I2C clock */
+#define P_ICODEC_RX_CLK	10  /* Internal CODEX RX clock */
+#define P_ICODEC_TX_CLK	11  /* Internal CODEX TX clock */
+#define P_IMEM_CLK	12  /* Internal graphics memory clock */
+#define P_MDC_CLK	13  /* MDDI client clock */
+#define P_MDP_CLK	14  /* Mobile display processor clock */
+#define P_PBUS_CLK	15  /* Peripheral bus clock */
+#define P_PCM_CLK	16  /* PCM clock */
+#define P_PMDH_CLK	17  /* Primary MDDI host clock */
+#define P_SDAC_CLK	18  /* Stereo DAC clock */
+#define P_SDC1_CLK	19  /* Secure Digital Card clocks */
+#define P_SDC1_P_CLK	20
+#define P_SDC2_CLK	21
+#define P_SDC2_P_CLK	22
+#define P_SDC3_CLK	23
+#define P_SDC3_P_CLK	24
+#define P_SDC4_CLK	25
+#define P_SDC4_P_CLK	26
+#define P_TSIF_CLK	27  /* Transport Stream Interface clocks */
+#define P_TSIF_REF_CLK	28
+#define P_TV_DAC_CLK	29  /* TV clocks */
+#define P_TV_ENC_CLK	30
+#define P_UART1_CLK	31  /* UART clocks */
+#define P_UART2_CLK	32
+#define P_UART3_CLK	33
+#define P_UART1DM_CLK	34
+#define P_UART2DM_CLK	35
+#define P_USB_HS_CLK	36  /* High speed USB core clock */
+#define P_USB_HS_P_CLK	37  /* High speed USB pbus clock */
+#define P_USB_OTG_CLK	38  /* Full speed USB clock */
+#define P_VDC_CLK	39  /* Video controller clock */
+#define P_VFE_MDC_CLK	40  /* Camera / Video Front End clock */
+#define P_VFE_CLK	41  /* VFE MDDI client clock */
+#define P_MDP_LCDC_PCLK_CLK	42
+#define P_MDP_LCDC_PAD_PCLK_CLK 43
+#define P_MDP_VSYNC_CLK	44
+#define P_SPI_CLK	45
+#define P_VFE_AXI_CLK	46
+#define P_USB_HS2_CLK	47  /* High speed USB 2 core clock */
+#define P_USB_HS2_P_CLK	48  /* High speed USB 2 pbus clock */
+#define P_USB_HS3_CLK	49  /* High speed USB 3 core clock */
+#define P_USB_HS3_P_CLK	50  /* High speed USB 3 pbus clock */
+#define P_GRP_3D_P_CLK	51  /* Graphics pbus clock */
+#define P_USB_PHY_CLK	52  /* USB PHY clock */
+#define P_USB_HS_CORE_CLK	53  /* High speed USB 1 core clock */
+#define P_USB_HS2_CORE_CLK	54  /* High speed USB 2 core clock */
+#define P_USB_HS3_CORE_CLK	55  /* High speed USB 3 core clock */
+#define P_CAM_M_CLK		56
+#define P_CAMIF_PAD_P_CLK	57
+#define P_GRP_2D_CLK		58
+#define P_GRP_2D_P_CLK		59
+#define P_I2S_CLK		60
+#define P_JPEG_CLK		61
+#define P_JPEG_P_CLK		62
+#define P_LPA_CODEC_CLK		63
+#define P_LPA_CORE_CLK		64
+#define P_LPA_P_CLK		65
+#define P_MDC_IO_CLK		66
+#define P_MDC_P_CLK		67
+#define P_MFC_CLK		68
+#define P_MFC_DIV2_CLK		69
+#define P_MFC_P_CLK		70
+#define P_QUP_I2C_CLK		71
+#define P_ROTATOR_IMEM_CLK	72
+#define P_ROTATOR_P_CLK		73
+#define P_VFE_CAMIF_CLK		74
+#define P_VFE_P_CLK		75
+#define P_VPE_CLK		76
+#define P_I2C_2_CLK		77
+#define P_MI2S_CODEC_RX_S_CLK	78
+#define P_MI2S_CODEC_RX_M_CLK	79
+#define P_MI2S_CODEC_TX_S_CLK	80
+#define P_MI2S_CODEC_TX_M_CLK	81
+#define P_PMDH_P_CLK		82
+#define P_EMDH_P_CLK		83
+#define P_SPI_P_CLK		84
+#define P_TSIF_P_CLK		85
+#define P_MDP_P_CLK		86
+#define P_SDAC_M_CLK		87
+#define P_MI2S_S_CLK		88
+#define P_MI2S_M_CLK		89
+#define P_AXI_ROTATOR_CLK	90
+#define P_HDMI_CLK		91
+#define P_CSI0_CLK		92
+#define P_CSI0_VFE_CLK		93
+#define P_CSI0_P_CLK		94
+#define P_CSI1_CLK		95
+#define P_CSI1_VFE_CLK		96
+#define P_CSI1_P_CLK		97
+#define P_GSBI_CLK		98
+#define P_GSBI_P_CLK		99
+
+#define P_NR_CLKS		100
+
+struct clk_ops;
+extern struct clk_ops clk_ops_pcom;
+
+int pc_clk_reset(unsigned id, enum clk_reset_action action);
+
+#define CLK_PCOM(clk_name, clk_id, clk_dev, clk_flags) {	\
+	.name = clk_name, \
+	.id = P_##clk_id, \
+	.remote_id = P_##clk_id, \
+	.ops = &clk_ops_pcom, \
+	.flags = clk_flags, \
+	.dev = clk_dev, \
+	.dbg_name = #clk_id, \
+	}
+
+#endif
diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index 3b1ce36..34c6a52 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -1,7 +1,7 @@
 /* arch/arm/mach-msm/clock.c
  *
  * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2007 QUALCOMM Incorporated
+ * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -22,6 +22,10 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spinlock.h>
+#include <linux/debugfs.h>
+#include <linux/ctype.h>
+#include <linux/pm_qos_params.h>
+#include <mach/clk.h>
 
 #include "clock.h"
 #include "proc_comm.h"
@@ -29,61 +33,15 @@
 static DEFINE_MUTEX(clocks_mutex);
 static DEFINE_SPINLOCK(clocks_lock);
 static LIST_HEAD(clocks);
+struct clk *msm_clocks;
+unsigned msm_num_clocks;
 
 /*
- * glue for the proc_comm interface
+ * Bitmap of enabled clocks, excluding ACPU which is always
+ * enabled
  */
-static inline int pc_clk_enable(unsigned id)
-{
-	return msm_proc_comm(PCOM_CLKCTL_RPC_ENABLE, &id, NULL);
-}
-
-static inline void pc_clk_disable(unsigned id)
-{
-	msm_proc_comm(PCOM_CLKCTL_RPC_DISABLE, &id, NULL);
-}
-
-static inline int pc_clk_set_rate(unsigned id, unsigned rate)
-{
-	return msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
-}
-
-static inline int pc_clk_set_min_rate(unsigned id, unsigned rate)
-{
-	return msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
-}
-
-static inline int pc_clk_set_max_rate(unsigned id, unsigned rate)
-{
-	return msm_proc_comm(PCOM_CLKCTL_RPC_MAX_RATE, &id, &rate);
-}
-
-static inline int pc_clk_set_flags(unsigned id, unsigned flags)
-{
-	return msm_proc_comm(PCOM_CLKCTL_RPC_SET_FLAGS, &id, &flags);
-}
-
-static inline unsigned pc_clk_get_rate(unsigned id)
-{
-	if (msm_proc_comm(PCOM_CLKCTL_RPC_RATE, &id, NULL))
-		return 0;
-	else
-		return id;
-}
-
-static inline unsigned pc_clk_is_enabled(unsigned id)
-{
-	if (msm_proc_comm(PCOM_CLKCTL_RPC_ENABLED, &id, NULL))
-		return 0;
-	else
-		return id;
-}
-
-static inline int pc_pll_request(unsigned id, unsigned on)
-{
-	on = !!on;
-	return msm_proc_comm(PCOM_CLKCTL_RPC_PLL_REQUEST, &id, &on);
-}
+static DECLARE_BITMAP(clock_map_enabled, NR_CLKS);
+static DEFINE_SPINLOCK(clock_map_lock);
 
 /*
  * Standard clock functions defined in include/linux/clk.h
@@ -119,8 +77,12 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	spin_lock_irqsave(&clocks_lock, flags);
 	clk->count++;
-	if (clk->count == 1)
-		pc_clk_enable(clk->id);
+	if (clk->count == 1) {
+		clk->ops->enable(clk->id);
+		spin_lock(&clock_map_lock);
+		clock_map_enabled[BIT_WORD(clk->id)] |= BIT_MASK(clk->id);
+		spin_unlock(&clock_map_lock);
+	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 	return 0;
 }
@@ -132,31 +94,54 @@ void clk_disable(struct clk *clk)
 	spin_lock_irqsave(&clocks_lock, flags);
 	BUG_ON(clk->count == 0);
 	clk->count--;
-	if (clk->count == 0)
-		pc_clk_disable(clk->id);
+	if (clk->count == 0) {
+		clk->ops->disable(clk->id);
+		spin_lock(&clock_map_lock);
+		clock_map_enabled[BIT_WORD(clk->id)] &= ~BIT_MASK(clk->id);
+		spin_unlock(&clock_map_lock);
+	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
+int clk_reset(struct clk *clk, enum clk_reset_action action)
+{
+	if (!clk->ops->reset)
+		clk->ops->reset = &pc_clk_reset;
+	return clk->ops->reset(clk->remote_id, action);
+}
+EXPORT_SYMBOL(clk_reset);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
-	return pc_clk_get_rate(clk->id);
+	return clk->ops->get_rate(clk->id);
 }
 EXPORT_SYMBOL(clk_get_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	int ret;
-	if (clk->flags & CLKFLAG_USE_MIN_MAX_TO_SET) {
-		ret = pc_clk_set_max_rate(clk->id, rate);
-		if (ret)
-			return ret;
-		return pc_clk_set_min_rate(clk->id, rate);
-	}
-	return pc_clk_set_rate(clk->id, rate);
+	return clk->ops->set_rate(clk->id, rate);
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->ops->round_rate(clk->id, rate);
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_min_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->ops->set_min_rate(clk->id, rate);
+}
+EXPORT_SYMBOL(clk_set_min_rate);
+
+int clk_set_max_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->ops->set_max_rate(clk->id, rate);
+}
+EXPORT_SYMBOL(clk_set_max_rate);
+
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return -ENOSYS;
@@ -173,22 +158,153 @@ int clk_set_flags(struct clk *clk, unsigned long flags)
 {
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
-	return pc_clk_set_flags(clk->id, flags);
+	return clk->ops->set_flags(clk->id, flags);
 }
 EXPORT_SYMBOL(clk_set_flags);
 
+/* EBI1 is the only shared clock that several clients want to vote on as of
+ * this commit. If this changes in the future, then it might be better to
+ * make clk_min_rate handle the voting or make ebi1_clk_set_min_rate more
+ * generic to support different clocks.
+ */
+static struct clk *ebi1_clk;
 
-void __init msm_clock_init(void)
+static void __init set_clock_ops(struct clk *clk)
+{
+	if (!clk->ops) {
+		clk->ops = &clk_ops_pcom;
+		clk->id = clk->remote_id;
+	}
+}
+
+void __init msm_clock_init(struct clk *clock_tbl, unsigned num_clocks)
 {
 	unsigned n;
 
 	spin_lock_init(&clocks_lock);
 	mutex_lock(&clocks_mutex);
-	for (n = 0; n < msm_num_clocks; n++)
+	msm_clocks = clock_tbl;
+	msm_num_clocks = num_clocks;
+	for (n = 0; n < msm_num_clocks; n++) {
+		set_clock_ops(&msm_clocks[n]);
 		list_add_tail(&msm_clocks[n].list, &clocks);
+	}
 	mutex_unlock(&clocks_mutex);
+
+	ebi1_clk = clk_get(NULL, "ebi1_clk");
+	BUG_ON(ebi1_clk == NULL);
+
+}
+
+#if defined(CONFIG_DEBUG_FS)
+static struct clk *msm_clock_get_nth(unsigned index)
+{
+	if (index < msm_num_clocks)
+		return msm_clocks + index;
+	else
+		return 0;
+}
+
+static int clock_debug_rate_set(void *data, u64 val)
+{
+	struct clk *clock = data;
+	int ret;
+
+	/* Only increases to max rate will succeed, but that's actually good
+	 * for debugging purposes. So we don't check for error. */
+	if (clock->flags & CLK_MAX)
+		clk_set_max_rate(clock, val);
+	if (clock->flags & CLK_MIN)
+		ret = clk_set_min_rate(clock, val);
+	else
+		ret = clk_set_rate(clock, val);
+	if (ret != 0)
+		printk(KERN_ERR "clk_set%s_rate failed (%d)\n",
+			(clock->flags & CLK_MIN) ? "_min" : "", ret);
+	return ret;
+}
+
+static int clock_debug_rate_get(void *data, u64 *val)
+{
+	struct clk *clock = data;
+	*val = clk_get_rate(clock);
+	return 0;
+}
+
+static int clock_debug_enable_set(void *data, u64 val)
+{
+	struct clk *clock = data;
+	int rc = 0;
+
+	if (val)
+		rc = clock->ops->enable(clock->id);
+	else
+		clock->ops->disable(clock->id);
+
+	return rc;
 }
 
+static int clock_debug_enable_get(void *data, u64 *val)
+{
+	struct clk *clock = data;
+
+	*val = clock->ops->is_enabled(clock->id);
+
+	return 0;
+}
+
+static int clock_debug_local_get(void *data, u64 *val)
+{
+	struct clk *clock = data;
+
+	*val = clock->ops != &clk_ops_pcom;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(clock_rate_fops, clock_debug_rate_get,
+			clock_debug_rate_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(clock_enable_fops, clock_debug_enable_get,
+			clock_debug_enable_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(clock_local_fops, clock_debug_local_get,
+			NULL, "%llu\n");
+
+static int __init clock_debug_init(void)
+{
+	struct dentry *dent_rate, *dent_enable, *dent_local;
+	struct clk *clock;
+	unsigned n = 0;
+	char temp[50], *ptr;
+
+	dent_rate = debugfs_create_dir("clk_rate", 0);
+	if (IS_ERR(dent_rate))
+		return PTR_ERR(dent_rate);
+
+	dent_enable = debugfs_create_dir("clk_enable", 0);
+	if (IS_ERR(dent_enable))
+		return PTR_ERR(dent_enable);
+
+	dent_local = debugfs_create_dir("clk_local", NULL);
+	if (IS_ERR(dent_local))
+		return PTR_ERR(dent_local);
+
+	while ((clock = msm_clock_get_nth(n++)) != 0) {
+		strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
+		for (ptr = temp; *ptr; ptr++)
+			*ptr = tolower(*ptr);
+		debugfs_create_file(temp, 0644, dent_rate,
+				    clock, &clock_rate_fops);
+		debugfs_create_file(temp, 0644, dent_enable,
+				    clock, &clock_enable_fops);
+		debugfs_create_file(temp, S_IRUGO, dent_local,
+				    clock, &clock_local_fops);
+	}
+	return 0;
+}
+
+device_initcall(clock_debug_init);
+#endif
+
 /* The bootloader and/or AMSS may have left various clocks enabled.
  * Disable any clocks that belong to us (CLKFLAG_AUTO_OFF) but have
  * not been explicitly enabled by a clk_enable() call.
@@ -205,7 +321,7 @@ static int __init clock_late_init(void)
 			spin_lock_irqsave(&clocks_lock, flags);
 			if (!clk->count) {
 				count++;
-				pc_clk_disable(clk->id);
+				clk->ops->auto_off(clk->id);
 			}
 			spin_unlock_irqrestore(&clocks_lock, flags);
 		}
@@ -216,3 +332,4 @@ static int __init clock_late_init(void)
 }
 
 late_initcall(clock_late_init);
+
diff --git a/arch/arm/mach-msm/clock.h b/arch/arm/mach-msm/clock.h
index f875e15..598db92 100644
--- a/arch/arm/mach-msm/clock.h
+++ b/arch/arm/mach-msm/clock.h
@@ -1,7 +1,7 @@
 /* arch/arm/mach-msm/clock.h
  *
  * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2007 QUALCOMM Incorporated
+ * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -18,6 +18,9 @@
 #define __ARCH_ARM_MACH_MSM_CLOCK_H
 
 #include <linux/list.h>
+#include <mach/clk.h>
+
+#include "clock-pcom.h"
 
 #define CLKFLAG_INVERT			0x00000001
 #define CLKFLAG_NOINVERT		0x00000002
@@ -25,14 +28,32 @@
 #define CLKFLAG_NORESET			0x00000008
 
 #define CLK_FIRST_AVAILABLE_FLAG	0x00000100
-#define CLKFLAG_USE_MIN_MAX_TO_SET	0x00000200
-#define CLKFLAG_AUTO_OFF		0x00000400
+#define CLKFLAG_AUTO_OFF		0x00000200
+#define CLKFLAG_MIN			0x00000400
+#define CLKFLAG_MAX			0x00000800
+
+struct clk_ops {
+	int (*enable)(unsigned id);
+	void (*disable)(unsigned id);
+	void (*auto_off)(unsigned id);
+	int (*reset)(unsigned id, enum clk_reset_action action);
+	int (*set_rate)(unsigned id, unsigned rate);
+	int (*set_min_rate)(unsigned id, unsigned rate);
+	int (*set_max_rate)(unsigned id, unsigned rate);
+	int (*set_flags)(unsigned id, unsigned flags);
+	unsigned (*get_rate)(unsigned id);
+	unsigned (*is_enabled)(unsigned id);
+	long (*round_rate)(unsigned id, unsigned rate);
+};
 
 struct clk {
 	uint32_t id;
+	uint32_t remote_id;
 	uint32_t count;
 	uint32_t flags;
 	const char *name;
+	struct clk_ops *ops;
+	const char *dbg_name;
 	struct list_head list;
 	struct device *dev;
 };
@@ -41,8 +62,47 @@ struct clk {
 #define A11S_CLK_SEL_ADDR		(MSM_CSR_BASE + 0x104)
 #define A11S_VDD_SVS_PLEVEL_ADDR	(MSM_CSR_BASE + 0x124)
 
-extern struct clk msm_clocks[];
-extern unsigned msm_num_clocks;
+#ifdef CONFIG_DEBUG_FS
+#define CLOCK_DBG_NAME(x) .dbg_name = x,
+#else
+#define CLOCK_DBG_NAME(x)
+#endif
+
+#define CLOCK(clk_name, clk_id, clk_dev, clk_flags) {	\
+	.name = clk_name, \
+	.id = clk_id, \
+	.flags = clk_flags, \
+	.dev = clk_dev, \
+	 CLOCK_DBG_NAME(#clk_id) \
+	}
+
+#define OFF CLKFLAG_AUTO_OFF
+#define CLK_MIN CLKFLAG_MIN
+#define CLK_MAX CLKFLAG_MAX
+#define CLK_MINMAX (CLK_MIN | CLK_MAX)
+#define NR_CLKS	P_NR_CLKS
+
+enum {
+	PLL_0 = 0,
+	PLL_1,
+	PLL_2,
+	PLL_3,
+	PLL_4,
+	PLL_5,
+	PLL_6,
+	NUM_PLL
+};
+
+enum clkvote_client {
+	CLKVOTE_ACPUCLK = 0,
+	CLKVOTE_PMQOS,
+	CLKVOTE_MAX,
+};
+
+int msm_clock_require_tcxo(unsigned long *reason, int nbits);
+int msm_clock_get_name(uint32_t id, char *name, uint32_t size);
+int ebi1_clk_set_min_rate(enum clkvote_client client, unsigned long rate);
+unsigned long clk_get_max_axi_khz(void);
 
 #endif
 
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 982f1da..fde9d8f 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -24,6 +24,8 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
+
+#include "clock.h"
 #include <mach/mmc.h>
 
 static struct resource resources_uart1[] = {
@@ -344,3 +346,48 @@ int __init msm_add_sdcc(unsigned int controller, struct mmc_platform_data *plat,
 	return platform_device_register(pdev);
 }
 
+struct clk msm_clocks_7x01a[] = {
+	CLK_PCOM("adm_clk",	ADM_CLK,	NULL, 0),
+	CLK_PCOM("adsp_clk",	ADSP_CLK,	NULL, 0),
+	CLK_PCOM("ebi1_clk",	EBI1_CLK,	NULL, 0),
+	CLK_PCOM("ebi2_clk",	EBI2_CLK,	NULL, 0),
+	CLK_PCOM("ecodec_clk",	ECODEC_CLK,	NULL, 0),
+	CLK_PCOM("emdh_clk",	EMDH_CLK,	NULL, OFF),
+	CLK_PCOM("gp_clk",		GP_CLK,		NULL, 0),
+	CLK_PCOM("grp_clk",	GRP_3D_CLK,	NULL, OFF),
+	CLK_PCOM("i2c_clk",	I2C_CLK,	&msm_device_i2c.dev, 0),
+	CLK_PCOM("icodec_rx_clk",	ICODEC_RX_CLK,	NULL, 0),
+	CLK_PCOM("icodec_tx_clk",	ICODEC_TX_CLK,	NULL, 0),
+	CLK_PCOM("imem_clk",	IMEM_CLK,	NULL, OFF),
+	CLK_PCOM("mdc_clk",	MDC_CLK,	NULL, 0),
+	CLK_PCOM("mdp_clk",	MDP_CLK,	NULL, OFF),
+	CLK_PCOM("pbus_clk",	PBUS_CLK,	NULL, 0),
+	CLK_PCOM("pcm_clk",	PCM_CLK,	NULL, 0),
+	CLK_PCOM("pmdh_clk",	PMDH_CLK,	NULL, OFF ),
+	CLK_PCOM("sdac_clk",	SDAC_CLK,	NULL, OFF),
+	CLK_PCOM("sdc_clk",	SDC1_CLK,	&msm_device_sdc1.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC1_P_CLK,	&msm_device_sdc1.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC2_CLK,	&msm_device_sdc2.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC2_P_CLK,	&msm_device_sdc2.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC3_CLK,	&msm_device_sdc3.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC3_P_CLK,	&msm_device_sdc3.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC4_CLK,	&msm_device_sdc4.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC4_P_CLK,	&msm_device_sdc4.dev, OFF),
+	CLK_PCOM("tsif_clk",	TSIF_CLK,	NULL, 0),
+	CLK_PCOM("tsif_ref_clk",	TSIF_REF_CLK,	NULL, 0),
+	CLK_PCOM("tv_dac_clk",	TV_DAC_CLK,	NULL, 0),
+	CLK_PCOM("tv_enc_clk",	TV_ENC_CLK,	NULL, 0),
+	CLK_PCOM("uart_clk",	UART1_CLK,	&msm_device_uart1.dev, OFF),
+	CLK_PCOM("uart_clk",	UART2_CLK,	&msm_device_uart2.dev, 0),
+	CLK_PCOM("uart_clk",	UART3_CLK,	&msm_device_uart3.dev, OFF),
+	CLK_PCOM("uart1dm_clk",	UART1DM_CLK,	NULL, OFF),
+	CLK_PCOM("uart2dm_clk",	UART2DM_CLK,	NULL, 0),
+	CLK_PCOM("usb_hs_clk",	USB_HS_CLK,	&msm_device_hsusb.dev, OFF),
+	CLK_PCOM("usb_hs_pclk",	USB_HS_P_CLK,	&msm_device_hsusb.dev, OFF),
+	CLK_PCOM("usb_otg_clk",	USB_OTG_CLK,	NULL, 0),
+	CLK_PCOM("vdc_clk",	VDC_CLK,	NULL, OFF ),
+	CLK_PCOM("vfe_clk",	VFE_CLK,	NULL, OFF),
+	CLK_PCOM("vfe_mdc_clk",	VFE_MDC_CLK,	NULL, OFF),
+};
+
+unsigned msm_num_clocks_7x01a = ARRAY_SIZE(msm_clocks_7x01a);
diff --git a/arch/arm/mach-msm/devices.h b/arch/arm/mach-msm/devices.h
index 0744c4a..19c5de9 100644
--- a/arch/arm/mach-msm/devices.h
+++ b/arch/arm/mach-msm/devices.h
@@ -16,6 +16,8 @@
 #ifndef __ARCH_ARM_MACH_MSM_DEVICES_H
 #define __ARCH_ARM_MACH_MSM_DEVICES_H
 
+#include "clock.h"
+
 extern struct platform_device msm_device_uart1;
 extern struct platform_device msm_device_uart2;
 extern struct platform_device msm_device_uart3;
@@ -33,4 +35,7 @@ extern struct platform_device msm_device_smd;
 
 extern struct platform_device msm_device_nand;
 
+extern struct clk msm_clocks_7x01a[];
+extern unsigned msm_num_clocks_7x01a;
+
 #endif
diff --git a/arch/arm/mach-msm/include/mach/board.h b/arch/arm/mach-msm/include/mach/board.h
index 7933641..e302fbd 100644
--- a/arch/arm/mach-msm/include/mach/board.h
+++ b/arch/arm/mach-msm/include/mach/board.h
@@ -30,14 +30,15 @@ struct msm_acpu_clock_platform_data
 	unsigned long wait_for_irq_khz;
 };
 
-  
+struct clk;
+
 /* common init routines for use by arch/arm/mach-msm/board-*.c */
 
 void __init msm_add_devices(void);
 void __init msm_map_common_io(void);
 void __init msm_init_irq(void);
 void __init msm_init_gpio(void);
-void __init msm_clock_init(void);
+void __init msm_clock_init(struct clk *clock_tbl, unsigned num_clocks);
 void __init msm_acpu_clock_init(struct msm_acpu_clock_platform_data *);
 
 #endif
diff --git a/arch/arm/mach-msm/include/mach/clk.h b/arch/arm/mach-msm/include/mach/clk.h
new file mode 100644
index 0000000..c05ca40
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/clk.h
@@ -0,0 +1,57 @@
+/* Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above
+ *       copyright notice, this list of conditions and the following
+ *       disclaimer in the documentation and/or other materials provided
+ *       with the distribution.
+ *     * Neither the name of Code Aurora Forum, Inc. nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+#ifndef __MACH_CLK_H
+#define __MACH_CLK_H
+
+/* Magic rate value for use with PM QOS to request the board's maximum
+ * supported AXI rate. PM QOS will only pass positive s32 rate values
+ * through to the clock driver, so INT_MAX is used.
+ */
+#define MSM_AXI_MAX_FREQ	LONG_MAX
+
+enum clk_reset_action {
+	CLK_RESET_DEASSERT	= 0,
+	CLK_RESET_ASSERT	= 1
+};
+
+struct clk;
+
+/* Rate is minimum clock rate in Hz */
+int clk_set_min_rate(struct clk *clk, unsigned long rate);
+
+/* Rate is maximum clock rate in Hz */
+int clk_set_max_rate(struct clk *clk, unsigned long rate);
+
+/* Assert/Deassert reset to a hardware block associated with a clock */
+int clk_reset(struct clk *clk, enum clk_reset_action action);
+
+/* Set clock-specific configuration parameters */
+int clk_set_flags(struct clk *clk, unsigned long flags);
+
+#endif
-- 
1.6.2.3
