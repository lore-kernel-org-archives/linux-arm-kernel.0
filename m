From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 12 Feb 2018 16:05:03 +0530
Subject: [RFC PATCH] soc: zynqmp: Add support for tap delay settings
Message-ID: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for tep delays programming for zynqmp platform.
This also adds dll reset support.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/soc/xilinx/Kconfig                   |   6 +-
 drivers/soc/xilinx/Makefile                  |   2 +
 drivers/soc/xilinx/zynqmp/Makefile           |   4 +
 drivers/soc/xilinx/zynqmp/tap_delays.c       | 270 +++++++++++++++++++++++++++
 include/linux/soc/xilinx/zynqmp/tap_delays.h |  31 +++
 5 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/tap_delays.c
 create mode 100644 include/linux/soc/xilinx/zynqmp/tap_delays.h

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..aa49859 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -1,4 +1,8 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx firmwares
+
+source "drivers/firmware/xilinx/zynqmp/Kconfig"
+
 menu "Xilinx SoC drivers"

 config XILINX_VCU
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..5440b34 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)       += xlnx_vcu.o
+
+obj-$(CONFIG_ARCH_ZYNQMP) += zynqmp/
diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp/Makefile
new file mode 100644
index 0000000..b33b031
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx zynqmp SoC
+
+obj-$(CONFIG_ARCH_ZYNQMP) += tap_delays.o
diff --git a/drivers/soc/xilinx/zynqmp/tap_delays.c b/drivers/soc/xilinx/zynqmp/tap_delays.c
new file mode 100644
index 0000000..d74fc6f
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/tap_delays.c
@@ -0,0 +1,270 @@
+/*
+ * Xilinx Zynq MPSoC Tap Delay Programming
+ *
+ *  Copyright (C) 2016 Xilinx, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/soc/xilinx/zynqmp/tap_delays.h>
+
+#define SD0_ITAPDLYSEL_HSD             0x15
+#define SD0_ITAPDLYSEL_SD_DDR50                0x3D
+#define SD0_ITAPDLYSEL_MMC_DDR50       0x12
+#define SD1_ITAPDLYSEL_HSD             0x15
+#define SD1_ITAPDLYSEL_SD_DDR50                0x3D
+#define SD1_ITAPDLYSEL_MMC_DDR50       0x12
+
+#define SD0_OTAPDLYSEL_MMC_HSD         0x06
+#define SD0_OTAPDLYSEL_SD_HSD          0x05
+#define SD0_OTAPDLYSEL_SDR50           0x03
+#define SD0_OTAPDLYSEL_SDR104_B0       0x03
+#define SD0_OTAPDLYSEL_SDR104_B2       0x02
+#define SD0_OTAPDLYSEL_SD_DDR50                0x04
+#define SD0_OTAPDLYSEL_MMC_DDR50       0x06
+#define SD1_OTAPDLYSEL_MMC_HSD         0x06
+#define SD1_OTAPDLYSEL_SD_HSD          0x05
+#define SD1_OTAPDLYSEL_SDR50           0x03
+#define SD1_OTAPDLYSEL_SDR104_B0       0x03
+#define SD1_OTAPDLYSEL_SDR104_B2       0x02
+#define SD1_OTAPDLYSEL_SD_DDR50                0x04
+#define SD1_OTAPDLYSEL_MMC_DDR50       0x06
+
+#define MMC_BANK2              0x2
+
+#define MMC_TIMING_MMC_HS       1
+#define MMC_TIMING_SD_HS        2
+#define MMC_TIMING_UHS_SDR25    4
+#define MMC_TIMING_UHS_SDR50    5
+#define MMC_TIMING_UHS_SDR104   6
+#define MMC_TIMING_UHS_DDR50    7
+#define MMC_TIMING_MMC_DDR52    8
+#define MMC_TIMING_MMC_HS200    9
+
+/**
+ * arasan_zynqmp_tap_sdr104 - Program the tap delys for HS and SDR25 modes.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_hs(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid == 0) {
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_INPUT, SD0_ITAPDLYSEL_HSD, NULL);
+               if (timing == MMC_TIMING_MMC_HS)
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_MMC_HSD,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SD_HSD,
+                                      NULL);
+       } else {
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_INPUT, SD1_ITAPDLYSEL_HSD, NULL);
+               if (timing == MMC_TIMING_MMC_HS)
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_MMC_HSD,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SD_HSD,
+                                      NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_ddr50 - Program the tap delys for DDR50 and DDR52 modes.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_ddr50(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid == 0) {
+               if (timing == MMC_TIMING_UHS_DDR50) {
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD0_ITAPDLYSEL_SD_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SD_DDR50,
+                                      NULL);
+               } else {
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD0_ITAPDLYSEL_MMC_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_MMC_DDR50,
+                                      NULL);
+               }
+       } else {
+               if (timing == MMC_TIMING_UHS_DDR50) {
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD1_ITAPDLYSEL_SD_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SD_DDR50,
+                                      NULL);
+               } else {
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD1_ITAPDLYSEL_MMC_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_MMC_DDR50,
+                                      NULL);
+               }
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_sdr50 - Program the tap delys for SDR50 mode.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_sdr50(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid == 0) {
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_OUTPUT,
+                              SD0_OTAPDLYSEL_SDR50,
+                              NULL);
+       } else {
+               /* Program OTAP */
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_OUTPUT,
+                              SD1_OTAPDLYSEL_SDR50,
+                              NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_sdr104 - Program the tap delys for SDR104 and HS200 modes.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_sdr104(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid == 0) {
+               /* Program OTAP */
+               if (bank == MMC_BANK2)
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SDR104_B2,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SDR104_B0,
+                                      NULL);
+       } else {
+               /* Program OTAP */
+               if (bank == MMC_BANK2)
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SDR104_B2,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SDR104_B0,
+                                      NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_set_tap_delay - Program the tap delys based on the mmc timing.
+ * @deviceid:          Unique Id of device
+ * @timing:            Timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank)
+{
+       switch (timing) {
+       case MMC_TIMING_SD_HS:
+       case MMC_TIMING_MMC_HS:
+       case MMC_TIMING_UHS_SDR25:
+               arasan_zynqmp_tap_hs(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_SDR50:
+               arasan_zynqmp_tap_sdr50(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_SDR104:
+       case MMC_TIMING_MMC_HS200:
+               arasan_zynqmp_tap_sdr104(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_DDR50:
+       case MMC_TIMING_MMC_DDR52:
+               arasan_zynqmp_tap_ddr50(deviceid, timing, bank);
+               break;
+       }
+}
+EXPORT_SYMBOL_GPL(arasan_zynqmp_set_tap_delay);
+
+/**
+ * arasan_zynqmp_dll_reset - Issue the DLL reset.
+ * @deviceid:          Unique Id of device
+ */
+void zynqmp_dll_reset(u8 deviceid)
+{
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       /* Issue DLL Reset */
+       if (deviceid == 0)
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
+                              PM_DLL_RESET_PULSE, 0, NULL);
+       else
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
+                              PM_DLL_RESET_PULSE, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_dll_reset);
diff --git a/include/linux/soc/xilinx/zynqmp/tap_delays.h b/include/linux/soc/xilinx/zynqmp/tap_delays.h
new file mode 100644
index 0000000..6eb7328
--- /dev/null
+++ b/include/linux/soc/xilinx/zynqmp/tap_delays.h
@@ -0,0 +1,31 @@
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2016 Xilinx
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#ifdef CONFIG_ARCH_ZYNQMP
+/* API for programming the tap delays */
+void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank);
+
+/* API to reset the DLL */
+void zynqmp_dll_reset(u8 deviceid);
+#else
+inline void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank) {}
+inline void zynqmp_dll_reset(u8 deviceid) {}
+#endif
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
