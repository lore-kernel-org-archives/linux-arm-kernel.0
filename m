From: hl@rock-chips.com (Lin Huang)
Date: Fri, 22 Jul 2016 17:07:14 +0800
Subject: [PATCH v3 1/7] firmware: rockchip: sip: Add rockchip SIP runtime
 service
In-Reply-To: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
Message-ID: <1469178440-4668-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shengfei xu <xsf@rock-chips.com>

This patch adds support for the SiP interface, we can pass dram
paramtert to bl31, and control ddr frequency scaling in bl31.

Signed-off-by: Shengfei xu <xsf@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v3:
- None

Changes in v2:
- None

Changes in v1:
- None

 drivers/firmware/Kconfig        |  7 +++++
 drivers/firmware/Makefile       |  1 +
 drivers/firmware/rockchip_sip.c | 64 +++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/rockchip_sip.h | 59 +++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 drivers/firmware/rockchip_sip.c
 create mode 100644 drivers/firmware/rockchip_sip.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 0e22f24..6f585c5 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -206,6 +206,13 @@ config QCOM_SCM_64
 config HAVE_ARM_SMCCC
 	bool
 
+config ROCKCHIP_SIP
+	bool "Rockchip SIP interface"
+	depends on ARM64 && ARM_PSCI_FW
+	help
+	  Say Y here if you want to enable SIP callbacks for Rockchip platforms
+	  This option enables support for communicating with the ATF.
+
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 44a59dc..e9eab5b 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -25,3 +25,4 @@ obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
+obj-$(CONFIG_ROCKCHIP_SIP)	+= rockchip_sip.o
diff --git a/drivers/firmware/rockchip_sip.c b/drivers/firmware/rockchip_sip.c
new file mode 100644
index 0000000..7756af9
--- /dev/null
+++ b/drivers/firmware/rockchip_sip.c
@@ -0,0 +1,64 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2016 ARM Limited
+ */
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/printk.h>
+#include "rockchip_sip.h"
+
+typedef unsigned long (psci_fn)(unsigned long, unsigned long,
+				unsigned long, unsigned long);
+asmlinkage psci_fn __invoke_psci_fn_smc;
+
+#define CONFIG_DRAM_INIT	0x00
+#define CONFIG_DRAM_SET_RATE	0x01
+#define CONFIG_DRAM_ROUND_RATE	0x02
+#define CONFIG_DRAM_SET_AT_SR	0x03
+#define CONFIG_DRAM_GET_BW	0x04
+#define CONFIG_DRAM_GET_RATE	0x05
+#define CONFIG_DRAM_CLR_IRQ	0x06
+#define CONFIG_DRAM_SET_PARAM   0x07
+
+uint64_t sip_smc_ddr_init(void)
+{
+	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0,
+				    0, CONFIG_DRAM_INIT);
+}
+
+uint64_t sip_smc_set_ddr_param(uint64_t param)
+{
+	return __invoke_psci_fn_smc(SIP_DDR_FREQ, param,
+				    0, CONFIG_DRAM_SET_PARAM);
+}
+
+uint64_t sip_smc_set_ddr_rate(uint64_t rate)
+{
+	return __invoke_psci_fn_smc(SIP_DDR_FREQ, rate, 0,
+				    CONFIG_DRAM_SET_RATE);
+}
+
+uint64_t sip_smc_get_ddr_rate(void)
+{
+	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_GET_RATE);
+}
+
+uint64_t sip_smc_clr_ddr_irq(void)
+{
+	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_CLR_IRQ);
+}
+
+uint64_t sip_smc_get_call_count(void)
+{
+	return __invoke_psci_fn_smc(SIP_SVC_CALL_COUNT, 0, 0, 0);
+}
diff --git a/drivers/firmware/rockchip_sip.h b/drivers/firmware/rockchip_sip.h
new file mode 100644
index 0000000..6487734
--- /dev/null
+++ b/drivers/firmware/rockchip_sip.h
@@ -0,0 +1,59 @@
+/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __SIP_INT_H
+#define __SIP_INT_H
+
+/* SMC function IDs for SiP Service queries */
+#define SIP_SVC_CALL_COUNT		0x8200ff00
+#define SIP_SVC_UID			0x8200ff01
+#define SIP_SVC_VERSION			0x8200ff03
+#define SIP_DDR_FREQ			0xC2000008
+
+#if IS_ENABLED(CONFIG_ROCKCHIP_SIP)
+uint64_t sip_smc_set_ddr_rate(uint64_t rate);
+uint64_t sip_smc_get_ddr_rate(void);
+uint64_t sip_smc_clr_ddr_irq(void);
+uint64_t sip_smc_get_call_count(void);
+uint64_t sip_smc_ddr_init(void);
+uint64_t sip_smc_set_ddr_param(uint64_t param);
+#else
+static inline uint64_t sip_smc_set_ddr_rate(uint64_t rate)
+{
+	return 0;
+}
+
+static inline uint64_t sip_smc_get_ddr_rate(void)
+{
+	return 0;
+}
+
+static inline uint64_t sip_smc_clr_ddr_irq(void)
+{
+	return 0;
+}
+
+static inline uint64_t sip_smc_get_call_count(void)
+{
+	return 0;
+}
+
+static inline uint64_t sip_smc_ddr_init(void)
+{
+	return 0;
+}
+
+static inline uint64_t sip_smc_set_ddr_param(uint64_t param)
+{
+	return 0;
+}
+#endif
+#endif
-- 
2.6.6
