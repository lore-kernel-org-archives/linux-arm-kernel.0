From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 16:11:05 -0700
Subject: [PATCH] TTY: msm_smd_tty: Remove unused driver
Message-ID: <1428707466-24526-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is no longer used now that mach-msm has been removed.
Delete it.

Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/Kconfig       |   8 --
 drivers/tty/serial/Makefile      |   1 -
 drivers/tty/serial/msm_smd_tty.c | 232 ---------------------------------------
 3 files changed, 241 deletions(-)
 delete mode 100644 drivers/tty/serial/msm_smd_tty.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1bde14..3a2bfca6f4b0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1378,14 +1378,6 @@ config SERIAL_PCH_UART_CONSOLE
 	  (the system  console is the device which receives all kernel messages and
 	  warnings and which allows logins in single user mode).
 
-config SERIAL_MSM_SMD
-	bool "Enable tty device interface for some SMD ports"
-	default n
-	depends on MSM_SMD
-	help
-	  Enables userspace clients to read and write to some streaming SMD
-	  ports via tty device interface for MSM chipset.
-
 config SERIAL_MXS_AUART
 	depends on ARCH_MXS
 	tristate "MXS AUART support"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index c3ac3d930b33..432cb6465227 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -79,7 +79,6 @@ obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
 obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o
 obj-$(CONFIG_SERIAL_IFX6X60)  	+= ifx6x60.o
 obj-$(CONFIG_SERIAL_PCH_UART)	+= pch_uart.o
-obj-$(CONFIG_SERIAL_MSM_SMD)	+= msm_smd_tty.o
 obj-$(CONFIG_SERIAL_MXS_AUART) += mxs-auart.o
 obj-$(CONFIG_SERIAL_LANTIQ)	+= lantiq.o
 obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
diff --git a/drivers/tty/serial/msm_smd_tty.c b/drivers/tty/serial/msm_smd_tty.c
deleted file mode 100644
index 1238ac370bff..000000000000
--- a/drivers/tty/serial/msm_smd_tty.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
- * Author: Brian Swetland <swetland@google.com>
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
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/cdev.h>
-#include <linux/device.h>
-#include <linux/wait.h>
-
-#include <linux/tty.h>
-#include <linux/tty_driver.h>
-#include <linux/tty_flip.h>
-
-#include <mach/msm_smd.h>
-
-#define MAX_SMD_TTYS 32
-
-struct smd_tty_info {
-	struct tty_port port;
-	smd_channel_t *ch;
-};
-
-struct smd_tty_channel_desc {
-	int id;
-	const char *name;
-};
-
-static struct smd_tty_info smd_tty[MAX_SMD_TTYS];
-
-static const struct smd_tty_channel_desc smd_default_tty_channels[] = {
-	{ .id = 0, .name = "SMD_DS" },
-	{ .id = 27, .name = "SMD_GPSNMEA" },
-};
-
-static const struct smd_tty_channel_desc *smd_tty_channels =
-		smd_default_tty_channels;
-static int smd_tty_channels_len = ARRAY_SIZE(smd_default_tty_channels);
-
-static void smd_tty_notify(void *priv, unsigned event)
-{
-	unsigned char *ptr;
-	int avail;
-	struct smd_tty_info *info = priv;
-	struct tty_struct *tty;
-
-	if (event != SMD_EVENT_DATA)
-		return;
-
-	tty = tty_port_tty_get(&info->port);
-	if (!tty)
-		return;
-
-	for (;;) {
-		if (test_bit(TTY_THROTTLED, &tty->flags))
-			break;
-		avail = smd_read_avail(info->ch);
-		if (avail == 0)
-			break;
-
-		avail = tty_prepare_flip_string(&info->port, &ptr, avail);
-
-		if (smd_read(info->ch, ptr, avail) != avail) {
-			/* shouldn't be possible since we're in interrupt
-			** context here and nobody else could 'steal' our
-			** characters.
-			*/
-			pr_err("OOPS - smd_tty_buffer mismatch?!");
-		}
-
-		tty_flip_buffer_push(&info->port);
-	}
-
-	/* XXX only when writable and necessary */
-	tty_wakeup(tty);
-	tty_kref_put(tty);
-}
-
-static int smd_tty_port_activate(struct tty_port *tport, struct tty_struct *tty)
-{
-	struct smd_tty_info *info = container_of(tport, struct smd_tty_info,
-			port);
-	int i, res = 0;
-	const char *name = NULL;
-
-	for (i = 0; i < smd_tty_channels_len; i++) {
-		if (smd_tty_channels[i].id == tty->index) {
-			name = smd_tty_channels[i].name;
-			break;
-		}
-	}
-	if (!name)
-		return -ENODEV;
-
-	if (info->ch)
-		smd_kick(info->ch);
-	else
-		res = smd_open(name, &info->ch, info, smd_tty_notify);
-
-	if (!res)
-		tty->driver_data = info;
-
-	return res;
-}
-
-static void smd_tty_port_shutdown(struct tty_port *tport)
-{
-	struct smd_tty_info *info = container_of(tport, struct smd_tty_info,
-			port);
-
-	if (info->ch) {
-		smd_close(info->ch);
-		info->ch = 0;
-	}
-}
-
-static int smd_tty_open(struct tty_struct *tty, struct file *f)
-{
-	struct smd_tty_info *info = smd_tty + tty->index;
-
-	return tty_port_open(&info->port, tty, f);
-}
-
-static void smd_tty_close(struct tty_struct *tty, struct file *f)
-{
-	struct smd_tty_info *info = tty->driver_data;
-
-	tty_port_close(&info->port, tty, f);
-}
-
-static int smd_tty_write(struct tty_struct *tty,
-			 const unsigned char *buf, int len)
-{
-	struct smd_tty_info *info = tty->driver_data;
-	int avail;
-
-	/* if we're writing to a packet channel we will
-	** never be able to write more data than there
-	** is currently space for
-	*/
-	avail = smd_write_avail(info->ch);
-	if (len > avail)
-		len = avail;
-
-	return smd_write(info->ch, buf, len);
-}
-
-static int smd_tty_write_room(struct tty_struct *tty)
-{
-	struct smd_tty_info *info = tty->driver_data;
-	return smd_write_avail(info->ch);
-}
-
-static int smd_tty_chars_in_buffer(struct tty_struct *tty)
-{
-	struct smd_tty_info *info = tty->driver_data;
-	return smd_read_avail(info->ch);
-}
-
-static void smd_tty_unthrottle(struct tty_struct *tty)
-{
-	struct smd_tty_info *info = tty->driver_data;
-	smd_kick(info->ch);
-}
-
-static const struct tty_port_operations smd_tty_port_ops = {
-	.shutdown = smd_tty_port_shutdown,
-	.activate = smd_tty_port_activate,
-};
-
-static const struct tty_operations smd_tty_ops = {
-	.open = smd_tty_open,
-	.close = smd_tty_close,
-	.write = smd_tty_write,
-	.write_room = smd_tty_write_room,
-	.chars_in_buffer = smd_tty_chars_in_buffer,
-	.unthrottle = smd_tty_unthrottle,
-};
-
-static struct tty_driver *smd_tty_driver;
-
-static int __init smd_tty_init(void)
-{
-	int ret, i;
-
-	smd_tty_driver = alloc_tty_driver(MAX_SMD_TTYS);
-	if (smd_tty_driver == 0)
-		return -ENOMEM;
-
-	smd_tty_driver->driver_name = "smd_tty_driver";
-	smd_tty_driver->name = "smd";
-	smd_tty_driver->major = 0;
-	smd_tty_driver->minor_start = 0;
-	smd_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	smd_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	smd_tty_driver->init_termios = tty_std_termios;
-	smd_tty_driver->init_termios.c_iflag = 0;
-	smd_tty_driver->init_termios.c_oflag = 0;
-	smd_tty_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
-	smd_tty_driver->init_termios.c_lflag = 0;
-	smd_tty_driver->flags = TTY_DRIVER_RESET_TERMIOS |
-		TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
-	tty_set_operations(smd_tty_driver, &smd_tty_ops);
-
-	ret = tty_register_driver(smd_tty_driver);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < smd_tty_channels_len; i++) {
-		struct tty_port *port = &smd_tty[smd_tty_channels[i].id].port;
-		tty_port_init(port);
-		port->ops = &smd_tty_port_ops;
-		tty_port_register_device(port, smd_tty_driver,
-				smd_tty_channels[i].id, NULL);
-	}
-
-	return 0;
-}
-
-module_init(smd_tty_init);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
