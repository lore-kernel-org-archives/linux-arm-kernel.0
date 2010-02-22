From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Mon, 22 Feb 2010 19:37:56 +0100
Subject: [PATCH 1/1] MX35: Add CUPID i2c1 rtc and at24 support.
Message-ID: <D99582E5322435468A77E74BB0039E7B176E1F3BC8@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carsten Behling <carsten.behling@garz-fricke.com>
---
 This patch adds i2-1 devices at24 eeprom and rtc to the Garz & Fricke CUPID bsp.
 This patch depends on the basic CUPID bsp patch.

 arch/arm/mach-mx3/mach-guf_cupid.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-guf_cupid.c b/arch/arm/mach-mx3/mach-guf_cupid.c
index e8300f8..417b911 100644
--- a/arch/arm/mach-mx3/mach-guf_cupid.c
+++ b/arch/arm/mach-mx3/mach-guf_cupid.c
@@ -25,7 +25,8 @@
 #include <linux/memory.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -33,6 +34,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
+#include <mach/i2c.h>
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
@@ -76,6 +78,27 @@ static struct imxuart_platform_data cupid_uart_pdata = {
        .flags = IMXUART_HAVE_RTSCTS,
 };

+#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
+static struct imxi2c_platform_data cupid_i2c_1_pdata = {
+       .bitrate = 50000,
+};
+
+static struct at24_platform_data cupid_eeprom_pdata = {
+       .byte_len = 4096,
+       .page_size = 32,
+       .flags = AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info cupid_i2c_devices[] = {
+       {
+               I2C_BOARD_INFO("at24", 0x50), /* E0=0, E1=0, E2=0 */
+               .platform_data = &cupid_eeprom_pdata,
+       }, {
+               I2C_BOARD_INFO("pcf8563", 0x51),
+       }
+};
+#endif
+
 static struct platform_device *devices[] __initdata = {
        &mxc_fec_device,
 };
@@ -110,6 +133,9 @@ static struct pad_desc cupid_pads[] = {
        MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
        MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
        MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
+       /* I2C1 */
+       MX35_PAD_I2C1_CLK__I2C1_SCL,
+       MX35_PAD_I2C1_DAT__I2C1_SDA,
        /* Display */
        MX35_PAD_LD0__IPU_DISPB_DAT_0,
        MX35_PAD_LD1__IPU_DISPB_DAT_1,
@@ -156,6 +182,12 @@ static void __init cupid_board_init(void)
        mxc_register_device(&mxc_nand_device, &cupid_nand_pdata);
        mxc_register_device(&mx3_ipu, &cupid_ipu_pdata);
        mxc_register_device(&mx3_fb, &cupid_mx3fb_pdata);
+#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
+       i2c_register_board_info(0, cupid_i2c_devices,
+                       ARRAY_SIZE(cupid_i2c_devices));
+
+       mxc_register_device(&mxc_i2c_device0, &cupid_i2c_1_pdata);
+#endif
 }

 static void __init cupid_timer_init(void)
--
1.6.0.2
