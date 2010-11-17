From: jiejing.zhang@freescale.com (Zhang Jiejing)
Date: Wed, 17 Nov 2010 09:57:20 +0800
Subject: [PATCH] ARM: imx: fix ehci-mxc build.
Message-ID: <1289959040-5056-1-git-send-email-jiejing.zhang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ehci-mxc.c is broken by commit:
65fd42724aee31018b0bb53f4cb04971423be664

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/serial/imx.o
  LD      drivers/serial/built-in.o
  CC      drivers/usb/host/ehci-hcd.o
In file included from drivers/usb/host/ehci-hcd.c:1165:
drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_probe':
drivers/usb/host/ehci-mxc.c:192: error: 'ehci' undeclared (first use in this function)
drivers/usb/host/ehci-mxc.c:192: error: (Each undeclared identifier is reported only once
drivers/usb/host/ehci-mxc.c:192: error: for each function it appears in.)
drivers/usb/host/ehci-mxc.c:117: warning: unused variable 'temp'
make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

This patch is fix this by reuse old code.

Cc: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Liu Hui <b29976@freescale.com>

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
---
 drivers/usb/host/ehci-mxc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index ac9c4d7..3e9ec19 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
  * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * Copyright (c) 2010 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -26,6 +27,7 @@
 #include <mach/mxc_ehci.h>
 
 #define ULPI_VIEWPORT_OFFSET	0x170
+#define PORTSC_OFFSET		0x184
 
 struct ehci_mxc_priv {
 	struct clk *usbclk, *ahbclk;
@@ -114,7 +116,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
 	struct usb_hcd *hcd;
 	struct resource *res;
-	int irq, ret, temp;
+	int irq, ret;
 	struct ehci_mxc_priv *priv;
 	struct device *dev = &pdev->dev;
 
@@ -189,7 +191,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* set up the PORTSCx register */
-	ehci_writel(ehci, pdata->portsc, &ehci->regs->port_status[0]);
+	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
 	mdelay(10);
 
 	/* setup specific usb hw */
-- 
1.6.3.3
