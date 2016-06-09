From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 10:51:49 +0100
Subject: [PATCH] ARM: mach-imx: fix undeclared symbols in mach-imx/devices
Message-ID: <1465465909-21371-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of variables that are not matched with their
respective definitions as the files that declare them are not
being included.

Since including either of ./devices-imx27.h or ../devices-imx21.h
includes devices-common.h we can safely replace the definition.
However, this does cause warnings if both includes are used as
devices-common.h is not safe for dual inclusion. Fix this by adding
an appropriate barrier in devices-common.h

This fixes the following warnings:

arch/arm/mach-imx/devices/platform-fec.c:23:27: warning: symbol 'imx27_fec_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c:22:36: warning: symbol 'imx27_fsl_usb2_udc_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx27-coda.c:14:34: warning: symbol 'imx27_coda_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx2-wdt.c:24:32: warning: symbol 'imx21_imx2_wdt_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx2-wdt.c:29:32: warning: symbol 'imx27_imx2_wdt_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-fb.c:28:30: warning: symbol 'imx21_imx_fb_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-fb.c:33:30: warning: symbol 'imx27_imx_fb_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-i2c.c:30:31: warning: symbol 'imx21_imx_i2c_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-i2c.c:35:31: warning: symbol 'imx27_imx_i2c_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-keypad.c:20:34: warning: symbol 'imx21_imx_keypad_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-keypad.c:25:34: warning: symbol 'imx27_imx_keypad_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-ssi.c:25:31: warning: symbol 'imx21_imx_ssi_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-ssi.c:34:31: warning: symbol 'imx27_imx_ssi_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-uart.c:40:37: warning: symbol 'imx21_imx_uart_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-imx-uart.c:51:37: warning: symbol 'imx27_imx_uart_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mx2-camera.c:31:34: warning: symbol 'imx27_mx2_camera_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc-ehci.c:22:32: warning: symbol 'imx27_mxc_ehci_otg_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc-ehci.c:24:32: warning: symbol 'imx27_mxc_ehci_hs_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc-mmc.c:27:31: warning: symbol 'imx21_mxc_mmc_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc-mmc.c:36:31: warning: symbol 'imx27_mxc_mmc_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc_nand.c:33:32: warning: symbol 'imx21_mxc_nand_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc_nand.c:38:32: warning: symbol 'imx27_mxc_nand_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc_w1.c:18:30: warning: symbol 'imx21_mxc_w1_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-mxc_w1.c:23:30: warning: symbol 'imx27_mxc_w1_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-spi_imx.c:34:31: warning: symbol 'imx21_cspi_data' was not declared. Should it be static?
arch/arm/mach-imx/devices/platform-spi_imx.c:43:31: warning: symbol 'imx27_cspi_data' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/devices/devices-common.h        | 7 +++++++
 arch/arm/mach-imx/devices/platform-fec.c          | 2 +-
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c | 2 +-
 arch/arm/mach-imx/devices/platform-imx-fb.c       | 3 ++-
 arch/arm/mach-imx/devices/platform-imx-i2c.c      | 3 ++-
 arch/arm/mach-imx/devices/platform-imx-keypad.c   | 3 ++-
 arch/arm/mach-imx/devices/platform-imx-ssi.c      | 3 ++-
 arch/arm/mach-imx/devices/platform-imx-uart.c     | 3 ++-
 arch/arm/mach-imx/devices/platform-imx2-wdt.c     | 3 ++-
 arch/arm/mach-imx/devices/platform-imx27-coda.c   | 2 +-
 arch/arm/mach-imx/devices/platform-mx2-camera.c   | 3 ++-
 arch/arm/mach-imx/devices/platform-mx2-emma.c     | 3 ++-
 arch/arm/mach-imx/devices/platform-mxc-ehci.c     | 3 ++-
 arch/arm/mach-imx/devices/platform-mxc-mmc.c      | 3 ++-
 arch/arm/mach-imx/devices/platform-mxc_nand.c     | 3 ++-
 arch/arm/mach-imx/devices/platform-mxc_w1.c       | 3 ++-
 arch/arm/mach-imx/devices/platform-spi_imx.c      | 3 ++-
 17 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 09cebd8..b7779fc 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -6,6 +6,10 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
+
+#ifndef __IMX_DEVICES_COMMON_H
+#define __IMX_DEVICES_COMMON_H
+
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
@@ -307,3 +311,6 @@ struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
 					int irq, int irq_err);
 struct platform_device *imx_add_imx_sdma(char *name,
 	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
+
+#endif /* __IMX_DEVICES_COMMON_H */
+
diff --git a/arch/arm/mach-imx/devices/platform-fec.c b/arch/arm/mach-imx/devices/platform-fec.c
index b403a4f..015661f 100644
--- a/arch/arm/mach-imx/devices/platform-fec.c
+++ b/arch/arm/mach-imx/devices/platform-fec.c
@@ -10,7 +10,7 @@
 #include <asm/sizes.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx27.h"
 
 #define imx_fec_data_entry_single(soc, _devid)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
index 25e1de6..ae793e6 100644
--- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
@@ -9,7 +9,7 @@
 #include <linux/dma-mapping.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx27.h"
 
 #define imx_fsl_usb2_udc_data_entry_single(soc, _devid)			\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index 7df6328..3b3f6ca 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -9,7 +9,8 @@
 #include <linux/dma-mapping.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx_fb_data_entry_single(soc, _devid, _size)		\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
index ae97915..fa0e822 100644
--- a/arch/arm/mach-imx/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx_i2c_data_entry_single(soc, _devid, _id, _hwid, _size)	\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-imx-keypad.c b/arch/arm/mach-imx/devices/platform-imx-keypad.c
index 479e4d7..ffab3ca 100644
--- a/arch/arm/mach-imx/devices/platform-imx-keypad.c
+++ b/arch/arm/mach-imx/devices/platform-imx-keypad.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx_keypad_data_entry_single(soc, _size)			\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-imx-ssi.c b/arch/arm/mach-imx/devices/platform-imx-ssi.c
index 6f0e94e..f09871e 100644
--- a/arch/arm/mach-imx/devices/platform-imx-ssi.c
+++ b/arch/arm/mach-imx/devices/platform-imx-ssi.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx_ssi_data_entry(soc, _id, _hwid, _size)			\
 	[_id] = {							\
diff --git a/arch/arm/mach-imx/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
index 6962cff..3186126 100644
--- a/arch/arm/mach-imx/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx_uart_3irq_data_entry(soc, _id, _hwid, _size)		\
 	[_id] = {							\
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 8c134c8..c37441e 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -9,7 +9,8 @@
 #include <asm/sizes.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-imx27-coda.c b/arch/arm/mach-imx/devices/platform-imx27-coda.c
index 25bebc2..52c6d33 100644
--- a/arch/arm/mach-imx/devices/platform-imx27-coda.c
+++ b/arch/arm/mach-imx/devices/platform-imx27-coda.c
@@ -8,7 +8,7 @@
  */
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx27.h"
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx27_coda_data imx27_coda_data __initconst = {
diff --git a/arch/arm/mach-imx/devices/platform-mx2-camera.c b/arch/arm/mach-imx/devices/platform-mx2-camera.c
index 4c377c3..78efb7b 100644
--- a/arch/arm/mach-imx/devices/platform-mx2-camera.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-camera.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mx2_camera_data_entry_single(soc, _devid)			\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-mx2-emma.c b/arch/arm/mach-imx/devices/platform-mx2-emma.c
index 0dc0651..64e26dd 100644
--- a/arch/arm/mach-imx/devices/platform-mx2-emma.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-emma.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mx2_emmaprp_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-mxc-ehci.c b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
index 4537abd..868caf2 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-ehci.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
@@ -9,7 +9,8 @@
 #include <linux/dma-mapping.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mxc_ehci_data_entry_single(soc, _id, hs)			\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-mxc-mmc.c b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
index b8203c7..a6d0dc8 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-mmc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
@@ -9,7 +9,8 @@
 #include <linux/dma-mapping.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mxc_mmc_data_entry_single(soc, _devid, _id, _hwid, _size)	\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index 676df49..4887cf4 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -9,7 +9,8 @@
 #include <asm/sizes.h>
 
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mxc_nand_data_entry_single(soc, _devid, _size)		\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_w1.c b/arch/arm/mach-imx/devices/platform-mxc_w1.c
index 88c18b7..c6846a6 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_w1.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_w1.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_mxc_w1_data_entry_single(soc)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index 5e9707b..1c41cd6 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -7,7 +7,8 @@
  * Free Software Foundation.
  */
 #include "../hardware.h"
-#include "devices-common.h"
+#include "../devices-imx21.h"
+#include "../devices-imx27.h"
 
 #define imx_spi_imx_data_entry_single(soc, type, _devid, _id, hwid, _size) \
 	{								\
-- 
2.8.1
