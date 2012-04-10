From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:44 +0200
Subject: [PATCH 31/40] ARM i.MX31: implement clocks using common clock
 framework
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-32-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig     |    1 +
 arch/arm/mach-imx/Makefile    |    2 +-
 arch/arm/mach-imx/clk-imx31.c |  168 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-imx31.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index efed8f9..692de7b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -68,6 +68,7 @@ config SOC_IMX31
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
+	select COMMON_CLK
 	select SMP_ON_UP if SMP
 
 config SOC_IMX35
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ab418..fdad8f4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-imx3.o
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
new file mode 100644
index 0000000..de3addb
--- /dev/null
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2012 Sascha Hauer <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/mx31.h>
+#include <mach/common.h>
+
+#include "clk.h"
+#include "crmregs-imx3.h"
+
+static char *mcu_main_sel[] = { "spll", "mpll", };
+static char *per_sel[] = { "per_div", "ipg", };
+static char *csi_sel[] = { "upll", "spll", };
+
+#define clkdev(d, n, c) \
+	{ \
+		.dev_id = d, \
+		.con_id = n, \
+		.clkname = c, \
+	},
+
+static struct clk_lookup lookups[] = {
+	clkdev("imx-gpt.0", "per", "gpt_gate")
+	clkdev("imx-gpt.0", "ipg", "ipg")
+	clkdev("imx31-cspi.0", NULL, "cspi1_gate")
+	clkdev("imx31-cspi.1", NULL, "cspi2_gate")
+	clkdev("imx31-cspi.2", NULL, "cspi3_gate")
+	clkdev(NULL, "pwm", "pwm_gate")
+	clkdev("imx2-wdt.0", NULL, "wdog_gate")
+	clkdev(NULL, "rtc", "rtc_gate")
+	clkdev(NULL, "epit", "epit1_gate")
+	clkdev(NULL, "epit", "epit2_gate")
+	clkdev("mxc_nand.0", NULL, "nfc")
+	clkdev("ipu-core", NULL, "ipu_gate")
+	clkdev("mx3_sdc_fb", NULL, "ipu_gate")
+	clkdev(NULL, "kpp", "kpp_gate")
+	clkdev("mxc-ehci.0", "per", "usb_div_post")
+	clkdev("mxc-ehci.0", "ahb", "usb_gate")
+	clkdev("mxc-ehci.0", "ipg", "ipg")
+	clkdev("mxc-ehci.1", "per", "usb_div_post")
+	clkdev("mxc-ehci.1", "ahb", "usb_gate")
+	clkdev("mxc-ehci.1", "ipg", "ipg")
+	clkdev("mxc-ehci.2", "per", "usb_div_post")
+	clkdev("mxc-ehci.2", "ahb", "usb_gate")
+	clkdev("mxc-ehci.2", "ipg", "ipg")
+	clkdev("fsl-usb2-udc", "per", "usb_div_post")
+	clkdev("fsl-usb2-udc", "ahb", "usb_gate")
+	clkdev("fsl-usb2-udc", "ipg", "ipg")
+	clkdev("mx3-camera.0", NULL, "csi_gate")
+	/* i.mx31 has the i.mx21 type uart */
+	clkdev("imx21-uart.0", "per", "uart1_gate")
+	clkdev("imx21-uart.0", "ipg", "ipg")
+	clkdev("imx21-uart.1", "per", "uart2_gate")
+	clkdev("imx21-uart.1", "ipg", "ipg")
+	clkdev("imx21-uart.2", "per", "uart3_gate")
+	clkdev("imx21-uart.2", "ipg", "ipg")
+	clkdev("imx21-uart.3", "per", "uart4_gate")
+	clkdev("imx21-uart.3", "ipg", "ipg")
+	clkdev("imx21-uart.4", "per", "uart5_gate")
+	clkdev("imx21-uart.4", "ipg", "ipg")
+	clkdev("imx-i2c.0", NULL, "i2c1_gate")
+	clkdev("imx-i2c.1", NULL, "i2c2_gate")
+	clkdev("imx-i2c.2", NULL, "i2c3_gate")
+	clkdev("mxc_w1.0", NULL, "owire_gate")
+	clkdev("mxc-mmc.0", NULL, "sdhc1_gate")
+	clkdev("mxc-mmc.1", NULL, "sdhc2_gate")
+	clkdev("imx-ssi.0", NULL, "ssi1_gate")
+	clkdev("imx-ssi.1", NULL, "ssi2_gate")
+	clkdev(NULL, "firi", "firi_gate")
+	clkdev("pata_imx", NULL, "pata_gate")
+	clkdev(NULL, "rtic", "rtic_gate")
+	clkdev(NULL, "rng", "rng_gate")
+	clkdev("imx31-sdma", NULL, "sdma_gate")
+	clkdev(NULL, "iim", "iim_gate")
+};
+
+int __init mx31_clocks_init(unsigned long fref)
+{
+	struct clk *emi, *upll, *csisel, *iim;
+	void __iomem *base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
+
+	imx_clk_fixed("ckih", fref);
+	imx_clk_fixed("ckil", 32768);
+	imx_clk_pllv1("mpll", "ckih", base + MXC_CCM_MPCTL);
+	imx_clk_pllv1("spll", "ckih", base + MXC_CCM_SRPCTL);
+	upll = imx_clk_pllv1("upll", "ckih", base + MXC_CCM_UPCTL);
+	imx_clk_mux("mcu_main", base + MXC_CCM_PMCR0, 31, 1, mcu_main_sel, ARRAY_SIZE(mcu_main_sel));
+	imx_clk_divider("hsp", "mcu_main", base + MXC_CCM_PDR0, 11, 3);
+	imx_clk_divider("ahb", "mcu_main", base + MXC_CCM_PDR0, 3, 3);
+	imx_clk_divider("nfc", "ahb", base + MXC_CCM_PDR0, 8, 3);
+	imx_clk_divider("ipg", "ahb", base + MXC_CCM_PDR0, 6, 2);
+	imx_clk_divider("per_div", "upll", base + MXC_CCM_PDR0, 16, 5);
+	imx_clk_mux("per", base + MXC_CCM_CCMR, 24, 1, per_sel, ARRAY_SIZE(per_sel));
+	csisel = imx_clk_mux("csi_sel", base + MXC_CCM_CCMR, 25, 1, csi_sel, ARRAY_SIZE(csi_sel));
+	imx_clk_divider("csi_div", "csi_sel", base + MXC_CCM_PDR0, 23, 9);
+	imx_clk_divider("usb_div_pre", "upll", base + MXC_CCM_PDR1, 30, 2);
+	imx_clk_divider("usb_div_post", "usb_div_pre", base + MXC_CCM_PDR1, 27, 3);
+	imx_clk_gate2("sdhc1_gate", "per", base + MXC_CCM_CGR0, 0);
+	imx_clk_gate2("sdhc2_gate", "per", base + MXC_CCM_CGR0, 2);
+	imx_clk_gate2("gpt_gate", "per", base + MXC_CCM_CGR0, 4);
+	imx_clk_gate2("epit1_gate", "per", base + MXC_CCM_CGR0, 6);
+	imx_clk_gate2("epit2_gate", "per", base + MXC_CCM_CGR0, 8);
+	iim = imx_clk_gate2("iim_gate", "ipg", base + MXC_CCM_CGR0, 10);
+	imx_clk_gate2("ata_gate", "ipg", base + MXC_CCM_CGR0, 12);
+	imx_clk_gate2("sdma_gate", "ahb", base + MXC_CCM_CGR0, 14);
+	imx_clk_gate2("cspi3_gate", "ipg", base + MXC_CCM_CGR0, 16);
+	imx_clk_gate2("rng_gate", "ipg", base + MXC_CCM_CGR0, 18);
+	imx_clk_gate2("uart1_gate", "per", base + MXC_CCM_CGR0, 20);
+	imx_clk_gate2("uart2_gate", "per", base + MXC_CCM_CGR0, 22);
+	imx_clk_gate2("ssi1_gate", "spll", base + MXC_CCM_CGR0, 24);
+	imx_clk_gate2("i2c1_gate", "per", base + MXC_CCM_CGR0, 26);
+	imx_clk_gate2("i2c2_gate", "per", base + MXC_CCM_CGR0, 28);
+	imx_clk_gate2("i2c3_gate", "per", base + MXC_CCM_CGR0, 30);
+	imx_clk_gate2("hantro_gate", "per", base + MXC_CCM_CGR1, 0);
+	imx_clk_gate2("mstick1_gate", "per", base + MXC_CCM_CGR1, 2);
+	imx_clk_gate2("mstick2_gate", "per", base + MXC_CCM_CGR1, 4);
+	imx_clk_gate2("csi_gate", "csi_div", base + MXC_CCM_CGR1, 6);
+	imx_clk_gate2("rtc_gate", "ipg", base + MXC_CCM_CGR1, 8);
+	imx_clk_gate2("wdog_gate", "ipg", base + MXC_CCM_CGR1, 10);
+	imx_clk_gate2("pwm_gate", "per", base + MXC_CCM_CGR1, 12);
+	imx_clk_gate2("sim_gate", "per", base + MXC_CCM_CGR1, 14);
+	imx_clk_gate2("ect_gate", "per", base + MXC_CCM_CGR1, 16);
+	imx_clk_gate2("usb_gate", "ahb", base + MXC_CCM_CGR1, 18);
+	imx_clk_gate2("kpp_gate", "ipg", base + MXC_CCM_CGR1, 20);
+	imx_clk_gate2("ipu_gate", "hsp", base + MXC_CCM_CGR1, 22);
+	imx_clk_gate2("uart3_gate", "per", base + MXC_CCM_CGR1, 24);
+	imx_clk_gate2("uart4_gate", "per", base + MXC_CCM_CGR1, 26);
+	imx_clk_gate2("uart5_gate", "per", base + MXC_CCM_CGR1, 28);
+	imx_clk_gate2("owire_gate", "per", base + MXC_CCM_CGR1, 30);
+	imx_clk_gate2("ssi2_gate", "spll", base + MXC_CCM_CGR2, 0);
+	imx_clk_gate2("cspi1_gate", "ipg", base + MXC_CCM_CGR2, 2);
+	imx_clk_gate2("cspi2_gate", "ipg", base + MXC_CCM_CGR2, 4);
+	imx_clk_gate2("gacc_gate", "per", base + MXC_CCM_CGR2, 6);
+	emi = imx_clk_gate2("emi_gate", "ahb", base + MXC_CCM_CGR2, 8);
+	imx_clk_gate2("rtic_gate", "ahb", base + MXC_CCM_CGR2, 10);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	clk_set_parent(csisel, upll);
+	clk_prepare_enable(emi);
+	clk_prepare_enable(iim);
+	mx31_revision();
+	clk_disable_unprepare(iim);
+
+	mxc_timer_init(NULL, MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR),
+			MX31_INT_GPT);
+
+	return 0;
+}
-- 
1.7.9.5
