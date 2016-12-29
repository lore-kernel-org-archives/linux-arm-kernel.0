From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Dec 2016 16:01:37 -0800
Subject: [PATCH 2/2] ARM: orion5x: Utilize micon MFD driver
In-Reply-To: <20161229000137.5553-1-f.fainelli@gmail.com>
References: <20161229000137.5553-1-f.fainelli@gmail.com>
Message-ID: <20161229000137.5553-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Kurobox Pro and Terastation Pro II/Live machines to utilize
the MFD_MICON driver which currently provides reboot support, but will
later be extended to support LEDs, buttons, FAN control and temperature.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-orion5x/Kconfig                  |   4 +
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 149 +++----------------------
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 149 +++----------------------
 3 files changed, 40 insertions(+), 262 deletions(-)

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 633442ad4e4c..1146181280d0 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -51,6 +51,8 @@ config MACH_RD88F5182_DT
 config MACH_KUROBOX_PRO
 	bool "KuroBox Pro"
 	select I2C_BOARDINFO if I2C
+	select MFD_CORE
+	select MFD_MICON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  KuroBox Pro platform.
@@ -71,6 +73,8 @@ config MACH_TS209
 	  QNAP TS-109/TS-209 platform.
 
 config MACH_TERASTATION_PRO2
+	select MFD_CORE
+	select MFD_MICON
 	bool "Buffalo Terastation Pro II/Live"
 	help
 	  Say 'Y' here if you want your kernel to support the
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 9dc3f59bed9c..b1c27c93b4c5 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <linux/platform_data/mtd-orion_nand.h>
+#include <linux/platform_data/micon.h>
 #include "common.h"
 #include "mpp.h"
 #include "orion5x.h"
@@ -180,136 +181,23 @@ static struct mv_sata_platform_data kurobox_pro_sata_data = {
 /*****************************************************************************
  * Kurobox Pro specific power off method via UART1-attached microcontroller
  ****************************************************************************/
+struct resource kurobox_pro_micon_res = {
+	.start	= UART1_PHYS_BASE,
+	.end	= UART1_PHYS_BASE + 0x100,
+	.flags	= IORESOURCE_MEM,
+};
 
-#define UART1_REG(x)	(UART1_VIRT_BASE + ((UART_##x) << 2))
-
-static int kurobox_pro_miconread(unsigned char *buf, int count)
-{
-	int i;
-	int timeout;
-
-	for (i = 0; i < count; i++) {
-		timeout = 10;
-
-		while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
-			if (--timeout == 0)
-				break;
-			udelay(1000);
-		}
-
-		if (timeout == 0)
-			break;
-		buf[i] = readl(UART1_REG(RX));
-	}
-
-	/* return read bytes */
-	return i;
-}
-
-static int kurobox_pro_miconwrite(const unsigned char *buf, int count)
-{
-	int i = 0;
-
-	while (count--) {
-		while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
-			barrier();
-		writel(buf[i++], UART1_REG(TX));
-	}
-
-	return 0;
-}
-
-static int kurobox_pro_miconsend(const unsigned char *data, int count)
-{
-	int i;
-	unsigned char checksum = 0;
-	unsigned char recv_buf[40];
-	unsigned char send_buf[40];
-	unsigned char correct_ack[3];
-	int retry = 2;
-
-	/* Generate checksum */
-	for (i = 0; i < count; i++)
-		checksum -=  data[i];
-
-	do {
-		/* Send data */
-		kurobox_pro_miconwrite(data, count);
-
-		/* send checksum */
-		kurobox_pro_miconwrite(&checksum, 1);
-
-		if (kurobox_pro_miconread(recv_buf, sizeof(recv_buf)) <= 3) {
-			printk(KERN_ERR ">%s: receive failed.\n", __func__);
-
-			/* send preamble to clear the receive buffer */
-			memset(&send_buf, 0xff, sizeof(send_buf));
-			kurobox_pro_miconwrite(send_buf, sizeof(send_buf));
-
-			/* make dummy reads */
-			mdelay(100);
-			kurobox_pro_miconread(recv_buf, sizeof(recv_buf));
-		} else {
-			/* Generate expected ack */
-			correct_ack[0] = 0x01;
-			correct_ack[1] = data[1];
-			correct_ack[2] = 0x00;
-
-			/* checksum Check */
-			if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
-			     recv_buf[3]) & 0xFF) {
-				printk(KERN_ERR ">%s: Checksum Error : "
-					"Received data[%02x, %02x, %02x, %02x]"
-					"\n", __func__, recv_buf[0],
-					recv_buf[1], recv_buf[2], recv_buf[3]);
-			} else {
-				/* Check Received Data */
-				if (correct_ack[0] == recv_buf[0] &&
-				    correct_ack[1] == recv_buf[1] &&
-				    correct_ack[2] == recv_buf[2]) {
-					/* Interval for next command */
-					mdelay(10);
-
-					/* Receive ACK */
-					return 0;
-				}
-			}
-			/* Received NAK or illegal Data */
-			printk(KERN_ERR ">%s: Error : NAK or Illegal Data "
-					"Received\n", __func__);
-		}
-	} while (retry--);
-
-	/* Interval for next command */
-	mdelay(10);
+static struct micon_platform_data kurobox_pro_micon_pdata;
 
-	return -1;
-}
-
-static void kurobox_pro_power_off(void)
-{
-	const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
-	const unsigned char shutdownwait[]	= {0x00, 0x0c};
-	const unsigned char poweroff[]		= {0x00, 0x06};
-	/* 38400 baud divisor */
-	const unsigned divisor = ((orion5x_tclk + (8 * 38400)) / (16 * 38400));
-
-	pr_info("%s: triggering power-off...\n", __func__);
-
-	/* hijack uart1 and reset into sane state (38400,8n1,even parity) */
-	writel(0x83, UART1_REG(LCR));
-	writel(divisor & 0xff, UART1_REG(DLL));
-	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
-	writel(0x1b, UART1_REG(LCR));
-	writel(0x00, UART1_REG(IER));
-	writel(0x07, UART1_REG(FCR));
-	writel(0x00, UART1_REG(MCR));
-
-	/* Send the commands to shutdown the Kurobox Pro */
-	kurobox_pro_miconsend(watchdogkill, sizeof(watchdogkill)) ;
-	kurobox_pro_miconsend(shutdownwait, sizeof(shutdownwait)) ;
-	kurobox_pro_miconsend(poweroff, sizeof(poweroff));
-}
+static struct platform_device kurobox_pro_micon = {
+	.name		= MICON_NAME,
+	.id		= -1,
+	.dev		= {
+		.platform_data = &kurobox_pro_micon_pdata,
+	},
+	.resource 	= &kurobox_pro_micon_res,
+	.num_resources	= 1,
+};
 
 /*****************************************************************************
  * General Setup
@@ -364,6 +252,8 @@ static void __init kurobox_pro_init(void)
 				    KUROBOX_PRO_NOR_BOOT_BASE,
 				    KUROBOX_PRO_NOR_BOOT_SIZE);
 	platform_device_register(&kurobox_pro_nor_flash);
+	kurobox_pro_micon_pdata.tclk = orion5x_tclk;
+	platform_device_register(&kurobox_pro_micon);
 
 	if (machine_is_kurobox_pro()) {
 		mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(0),
@@ -374,9 +264,6 @@ static void __init kurobox_pro_init(void)
 	}
 
 	i2c_register_board_info(0, &kurobox_pro_i2c_rtc, 1);
-
-	/* register Kurobox Pro specific power-off method */
-	pm_power_off = kurobox_pro_power_off;
 }
 
 #ifdef CONFIG_MACH_KUROBOX_PRO
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index deb5e29ac669..7493f64388d6 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -19,6 +19,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
+#include <linux/platform_data/micon.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
@@ -159,136 +160,23 @@ static struct i2c_board_info __initdata tsp2_i2c_rtc = {
  * Terastation Pro II specific power off method via UART1-attached
  * microcontroller
  ****************************************************************************/
+struct resource tsp2_micon_res = {
+	.start	= UART1_PHYS_BASE,
+	.end	= UART1_PHYS_BASE + 0x100,
+	.flags	= IORESOURCE_MEM,
+};
 
-#define UART1_REG(x)	(UART1_VIRT_BASE + ((UART_##x) << 2))
-
-static int tsp2_miconread(unsigned char *buf, int count)
-{
-	int i;
-	int timeout;
-
-	for (i = 0; i < count; i++) {
-		timeout = 10;
-
-		while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
-			if (--timeout == 0)
-				break;
-			udelay(1000);
-		}
-
-		if (timeout == 0)
-			break;
-		buf[i] = readl(UART1_REG(RX));
-	}
-
-	/* return read bytes */
-	return i;
-}
-
-static int tsp2_miconwrite(const unsigned char *buf, int count)
-{
-	int i = 0;
-
-	while (count--) {
-		while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
-			barrier();
-		writel(buf[i++], UART1_REG(TX));
-	}
-
-	return 0;
-}
-
-static int tsp2_miconsend(const unsigned char *data, int count)
-{
-	int i;
-	unsigned char checksum = 0;
-	unsigned char recv_buf[40];
-	unsigned char send_buf[40];
-	unsigned char correct_ack[3];
-	int retry = 2;
-
-	/* Generate checksum */
-	for (i = 0; i < count; i++)
-		checksum -=  data[i];
-
-	do {
-		/* Send data */
-		tsp2_miconwrite(data, count);
-
-		/* send checksum */
-		tsp2_miconwrite(&checksum, 1);
-
-		if (tsp2_miconread(recv_buf, sizeof(recv_buf)) <= 3) {
-			printk(KERN_ERR ">%s: receive failed.\n", __func__);
-
-			/* send preamble to clear the receive buffer */
-			memset(&send_buf, 0xff, sizeof(send_buf));
-			tsp2_miconwrite(send_buf, sizeof(send_buf));
-
-			/* make dummy reads */
-			mdelay(100);
-			tsp2_miconread(recv_buf, sizeof(recv_buf));
-		} else {
-			/* Generate expected ack */
-			correct_ack[0] = 0x01;
-			correct_ack[1] = data[1];
-			correct_ack[2] = 0x00;
-
-			/* checksum Check */
-			if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
-			     recv_buf[3]) & 0xFF) {
-				printk(KERN_ERR ">%s: Checksum Error : "
-					"Received data[%02x, %02x, %02x, %02x]"
-					"\n", __func__, recv_buf[0],
-					recv_buf[1], recv_buf[2], recv_buf[3]);
-			} else {
-				/* Check Received Data */
-				if (correct_ack[0] == recv_buf[0] &&
-				    correct_ack[1] == recv_buf[1] &&
-				    correct_ack[2] == recv_buf[2]) {
-					/* Interval for next command */
-					mdelay(10);
-
-					/* Receive ACK */
-					return 0;
-				}
-			}
-			/* Received NAK or illegal Data */
-			printk(KERN_ERR ">%s: Error : NAK or Illegal Data "
-					"Received\n", __func__);
-		}
-	} while (retry--);
-
-	/* Interval for next command */
-	mdelay(10);
+static struct micon_platform_data tsp2_micon_pdata;
 
-	return -1;
-}
-
-static void tsp2_power_off(void)
-{
-	const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
-	const unsigned char shutdownwait[]	= {0x00, 0x0c};
-	const unsigned char poweroff[]		= {0x00, 0x06};
-	/* 38400 baud divisor */
-	const unsigned divisor = ((orion5x_tclk + (8 * 38400)) / (16 * 38400));
-
-	pr_info("%s: triggering power-off...\n", __func__);
-
-	/* hijack uart1 and reset into sane state (38400,8n1,even parity) */
-	writel(0x83, UART1_REG(LCR));
-	writel(divisor & 0xff, UART1_REG(DLL));
-	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
-	writel(0x1b, UART1_REG(LCR));
-	writel(0x00, UART1_REG(IER));
-	writel(0x07, UART1_REG(FCR));
-	writel(0x00, UART1_REG(MCR));
-
-	/* Send the commands to shutdown the Terastation Pro II */
-	tsp2_miconsend(watchdogkill, sizeof(watchdogkill)) ;
-	tsp2_miconsend(shutdownwait, sizeof(shutdownwait)) ;
-	tsp2_miconsend(poweroff, sizeof(poweroff));
-}
+static struct platform_device tsp2_micon = {
+	.name		= MICON_NAME,
+	.id		= -1,
+	.dev = {
+		.platform_data = &tsp2_micon_pdata,
+	},
+	.resource	= &tsp2_micon_res,
+	.num_resources	= 1,
+};
 
 /*****************************************************************************
  * General Setup
@@ -334,6 +222,8 @@ static void __init tsp2_init(void)
 				    TSP2_NOR_BOOT_BASE,
 				    TSP2_NOR_BOOT_SIZE);
 	platform_device_register(&tsp2_nor_flash);
+	tsp2_micon_pdata.tclk = orion5x_tclk;
+	platform_device_register(&tsp2_micon);
 
 	orion5x_ehci0_init();
 	orion5x_eth_init(&tsp2_eth_data);
@@ -351,9 +241,6 @@ static void __init tsp2_init(void)
 	if (tsp2_i2c_rtc.irq == 0)
 		pr_warn("tsp2_init: failed to get RTC IRQ\n");
 	i2c_register_board_info(0, &tsp2_i2c_rtc, 1);
-
-	/* register Terastation Pro II specific power-off method */
-	pm_power_off = tsp2_power_off;
 }
 
 MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
-- 
2.9.3
