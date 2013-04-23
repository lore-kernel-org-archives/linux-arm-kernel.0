From: cb@sgoc.de (Christoph G. Baumann)
Date: Tue, 23 Apr 2013 14:11:25 +0200
Subject: [PATCH 2/2] Support fsl-dcp crypto coprocessor
In-Reply-To: <1366719085-12847-1-git-send-email-cb@sgoc.de>
References: <1366710460-11637-1-git-send-email-cb@sgoc.de>
 <1366719085-12847-1-git-send-email-cb@sgoc.de>
Message-ID: <1366719085-12847-3-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <c.baumann@ppc-ag.de>

Forgot some changed files in the first try...

The following patch is a port of the original driver from Freescale to
the current mainline. The patch was tested under 3.7.

Signed-off-by: "Christoph G. Baumann" <cb@sgoc.de>
---
 arch/arm/boot/dts/imx28.dtsi                 |    2 +-
 drivers/staging/Kconfig                      |    2 ++
 drivers/staging/Makefile                     |    1 +
 include/linux/fsl/fsl-dcp_bootstream_ioctl.h |   32 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/fsl/fsl-dcp_bootstream_ioctl.h

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..07c80cd 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -664,9 +664,9 @@
 			};
 
 			dcp at 80028000 {
+				compatible = "fsl,fsl-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
-				status = "disabled";
 			};
 
 			pxp at 8002a000 {
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 093f10c..b3cf08b 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -140,4 +140,6 @@ source "drivers/staging/zcache/Kconfig"
 
 source "drivers/staging/goldfish/Kconfig"
 
+source "drivers/staging/crypto/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fa41b04..6875e3e 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_SB105X)		+= sb105x/
 obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
 obj-$(CONFIG_ZCACHE)		+= zcache/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
+obj-$(CONFIG_CRYPTO_HW)		+= crypto/
diff --git a/include/linux/fsl/fsl-dcp_bootstream_ioctl.h b/include/linux/fsl/fsl-dcp_bootstream_ioctl.h
new file mode 100644
index 0000000..2859a8d
--- /dev/null
+++ b/include/linux/fsl/fsl-dcp_bootstream_ioctl.h
@@ -0,0 +1,32 @@
+/*
+ * Freescale DCP driver for bootstream update. Only handles the OTP KEY
+ * case and can only encrypt/decrypt.
+ *
+ * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
+ *
+ * Copyright (C) 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef DCP_BOOTSTREAM_IOCTL_H
+#define DCP_BOOTSTREAM_IOCTL_H
+
+/* remember to have included the proper _IO definition
+ * file before hand.
+ * For user space it's <sys/ioctl.h>
+ */
+
+#define DBS_IOCTL_BASE   'd'
+
+#define DBS_ENC _IOW(DBS_IOCTL_BASE, 0x00, uint8_t[16])
+#define DBS_DEC _IOW(DBS_IOCTL_BASE, 0x01, uint8_t[16])
+
+#endif
-- 
1.7.9.5
