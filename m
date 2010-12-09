From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 9 Dec 2010 23:12:48 +0800
Subject: [PATCH v3 13/15] ARM: mxs: Add initial mx23evk support
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291907569-8925-13-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial mx23evk support with duart.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v3:
 - Remove inclusion of hardware.h
 - Add __initconst for mx23evk_pads[]

Changes for v2:
 - Remove boot_params

 arch/arm/mach-mxs/mach-mx23evk.c |   57 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c

diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
new file mode 100644
index 0000000..c34b840
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/iomux-mx23.h>
+
+#include "devices-mx23.h"
+
+static const iomux_cfg_t mx23evk_pads[] __initconst = {
+	/* duart */
+	MX23_PAD_PWM0__DUART_RX,
+	MX23_PAD_PWM1__DUART_TX,
+};
+
+static void __init mx23evk_init(void)
+{
+	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
+
+	mx23_add_duart();
+}
+
+static void __init mx23evk_timer_init(void)
+{
+	mx23_clocks_init();
+}
+
+static struct sys_timer mx23evk_timer = {
+	.init	= mx23evk_timer_init,
+};
+
+MACHINE_START(MX23EVK, "Freescale MX23 EVK")
+	/* Maintainer: Freescale Semiconductor, Inc. */
+	.map_io         = mx23_map_io,
+	.init_irq       = mx23_init_irq,
+	.init_machine   = mx23evk_init,
+	.timer          = &mx23evk_timer,
+MACHINE_END
-- 
1.7.1
