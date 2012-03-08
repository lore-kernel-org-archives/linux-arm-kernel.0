From: stigge@antcom.de (Roland Stigge)
Date: Thu,  8 Mar 2012 23:09:34 +0100
Subject: [PATCH v4] USB: Support for LPC32xx SoC
Message-ID: <1331244574-32570-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds OHCI support to the LPC32xx ARM platform

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 Applies to v3.3-rc6

 Since v3, only the machine_is_*() dependencies have been pulled into
 the machine dependent functions.

 Thanks to Greg Kroah-Hartman for reviewing!

 drivers/usb/host/ohci-hcd.c     |    5 +
 drivers/usb/host/ohci-pnx4008.c |  119 +++++++++++++++++++++++++++++-----------
 2 files changed, 94 insertions(+), 30 deletions(-)

--- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
+++ linux-2.6/drivers/usb/host/ohci-hcd.c
@@ -1055,6 +1055,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
 #endif
 
+#ifdef CONFIG_ARCH_LPC32XX
+#include "ohci-pnx4008.c"
+#define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
+#endif
+
 #ifdef CONFIG_ARCH_DAVINCI_DA8XX
 #include "ohci-da8xx.c"
 #define PLATFORM_DRIVER		ohci_hcd_da8xx_driver
--- linux-2.6.orig/drivers/usb/host/ohci-pnx4008.c
+++ linux-2.6/drivers/usb/host/ohci-pnx4008.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 
 #include <mach/hardware.h>
+#include <asm/mach-types.h>
 #include <asm/io.h>
 
 #include <mach/platform.h>
@@ -143,7 +144,17 @@ static void i2c_write(u8 buf, u8 subaddr
 	i2c_master_send(isp1301_i2c_client, &tmpbuf[0], 2);
 }
 
-static void isp1301_configure(void)
+static u16 i2c_read16(u8 subaddr)
+{
+	u16 data;
+
+	i2c_master_send(isp1301_i2c_client, &subaddr, 1);
+	i2c_master_recv(isp1301_i2c_client, (u8 *) &data, 2);
+
+	return data;
+}
+
+static void isp1301_configure_pnx4008(void)
 {
 	/* PNX4008 only supports DAT_SE0 USB mode */
 	/* PNX4008 R2A requires setting the MAX603 to output 3.6V */
@@ -166,7 +177,51 @@ static void isp1301_configure(void)
 		  ISP1301_I2C_INTERRUPT_FALLING | ISP1301_I2C_REG_CLEAR_ADDR);
 	i2c_write(0xFF,
 		  ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR);
+}
 
+static void isp1301_configure_lpc32xx(void)
+{
+	/* LPC32XX only supports DAT_SE0 USB mode */
+	/* This sequence is important */
+
+	/* Disable transparent UART mode first */
+	i2c_write(MC1_UART_EN, (ISP1301_I2C_MODE_CONTROL_1 |
+		ISP1301_I2C_REG_CLEAR_ADDR));
+
+	i2c_write(~MC1_SPEED_REG, (ISP1301_I2C_MODE_CONTROL_1 |
+		ISP1301_I2C_REG_CLEAR_ADDR));
+	i2c_write(MC1_SPEED_REG, ISP1301_I2C_MODE_CONTROL_1);
+	i2c_write(~0,
+		(ISP1301_I2C_MODE_CONTROL_2 | ISP1301_I2C_REG_CLEAR_ADDR));
+	i2c_write((MC2_BI_DI | MC2_PSW_EN | MC2_SPD_SUSP_CTRL),
+		ISP1301_I2C_MODE_CONTROL_2);
+	i2c_write(~0, (ISP1301_I2C_OTG_CONTROL_1 | ISP1301_I2C_REG_CLEAR_ADDR));
+	i2c_write(MC1_DAT_SE0, ISP1301_I2C_MODE_CONTROL_1);
+	i2c_write((OTG1_DM_PULLDOWN | OTG1_DP_PULLDOWN),
+		ISP1301_I2C_OTG_CONTROL_1);
+	i2c_write((OTG1_DM_PULLUP | OTG1_DP_PULLUP),
+		(ISP1301_I2C_OTG_CONTROL_1 | ISP1301_I2C_REG_CLEAR_ADDR));
+	i2c_write(~0,
+		 ISP1301_I2C_INTERRUPT_LATCH | ISP1301_I2C_REG_CLEAR_ADDR);
+	i2c_write(~0,
+		ISP1301_I2C_INTERRUPT_FALLING | ISP1301_I2C_REG_CLEAR_ADDR);
+	i2c_write(~0,
+		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR);
+
+	/* Enable usb_need_clk clock after transceiver is initialized */
+	__raw_writel((__raw_readl(USB_CTRL) | (1 << 22)), USB_CTRL);
+
+	printk(KERN_INFO "ISP1301 Vendor ID  : 0x%04x\n", i2c_read16(0x00));
+	printk(KERN_INFO "ISP1301 Product ID : 0x%04x\n", i2c_read16(0x02));
+	printk(KERN_INFO "ISP1301 Version ID : 0x%04x\n", i2c_read16(0x14));
+}
+
+static void isp1301_configure(void)
+{
+	if (machine_is_pnx4008())
+		isp1301_configure_pnx4008();
+	else
+		isp1301_configure_lpc32xx();
 }
 
 static inline void isp1301_vbus_on(void)
@@ -257,39 +312,43 @@ static const struct hc_driver ohci_pnx40
 
 static void pnx4008_set_usb_bits(void)
 {
-	start_int_set_falling_edge(SE_USB_OTG_ATX_INT_N);
-	start_int_ack(SE_USB_OTG_ATX_INT_N);
-	start_int_umask(SE_USB_OTG_ATX_INT_N);
-
-	start_int_set_rising_edge(SE_USB_OTG_TIMER_INT);
-	start_int_ack(SE_USB_OTG_TIMER_INT);
-	start_int_umask(SE_USB_OTG_TIMER_INT);
-
-	start_int_set_rising_edge(SE_USB_I2C_INT);
-	start_int_ack(SE_USB_I2C_INT);
-	start_int_umask(SE_USB_I2C_INT);
-
-	start_int_set_rising_edge(SE_USB_INT);
-	start_int_ack(SE_USB_INT);
-	start_int_umask(SE_USB_INT);
-
-	start_int_set_rising_edge(SE_USB_NEED_CLK_INT);
-	start_int_ack(SE_USB_NEED_CLK_INT);
-	start_int_umask(SE_USB_NEED_CLK_INT);
-
-	start_int_set_rising_edge(SE_USB_AHB_NEED_CLK_INT);
-	start_int_ack(SE_USB_AHB_NEED_CLK_INT);
-	start_int_umask(SE_USB_AHB_NEED_CLK_INT);
+	if (machine_is_pnx4008()) {
+		start_int_set_falling_edge(SE_USB_OTG_ATX_INT_N);
+		start_int_ack(SE_USB_OTG_ATX_INT_N);
+		start_int_umask(SE_USB_OTG_ATX_INT_N);
+
+		start_int_set_rising_edge(SE_USB_OTG_TIMER_INT);
+		start_int_ack(SE_USB_OTG_TIMER_INT);
+		start_int_umask(SE_USB_OTG_TIMER_INT);
+
+		start_int_set_rising_edge(SE_USB_I2C_INT);
+		start_int_ack(SE_USB_I2C_INT);
+		start_int_umask(SE_USB_I2C_INT);
+
+		start_int_set_rising_edge(SE_USB_INT);
+		start_int_ack(SE_USB_INT);
+		start_int_umask(SE_USB_INT);
+
+		start_int_set_rising_edge(SE_USB_NEED_CLK_INT);
+		start_int_ack(SE_USB_NEED_CLK_INT);
+		start_int_umask(SE_USB_NEED_CLK_INT);
+
+		start_int_set_rising_edge(SE_USB_AHB_NEED_CLK_INT);
+		start_int_ack(SE_USB_AHB_NEED_CLK_INT);
+		start_int_umask(SE_USB_AHB_NEED_CLK_INT);
+	}
 }
 
 static void pnx4008_unset_usb_bits(void)
 {
-	start_int_mask(SE_USB_OTG_ATX_INT_N);
-	start_int_mask(SE_USB_OTG_TIMER_INT);
-	start_int_mask(SE_USB_I2C_INT);
-	start_int_mask(SE_USB_INT);
-	start_int_mask(SE_USB_NEED_CLK_INT);
-	start_int_mask(SE_USB_AHB_NEED_CLK_INT);
+	if (machine_is_pnx4008()) {
+		start_int_mask(SE_USB_OTG_ATX_INT_N);
+		start_int_mask(SE_USB_OTG_TIMER_INT);
+		start_int_mask(SE_USB_I2C_INT);
+		start_int_mask(SE_USB_INT);
+		start_int_mask(SE_USB_NEED_CLK_INT);
+		start_int_mask(SE_USB_AHB_NEED_CLK_INT);
+	}
 }
 
 static int __devinit usb_hcd_pnx4008_probe(struct platform_device *pdev)
