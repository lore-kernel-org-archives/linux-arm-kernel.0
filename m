From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Jun 2013 14:55:04 -0700
Subject: [PATCH] ARM: OMAP2+: Fix serial init for device tree based booting
Message-ID: <20130607215503.GK3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want to call omap_serial_early_init() for device
tree based booting as the ports are initialized based on
the .dts entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -176,6 +176,9 @@ static char *cmdline_find_option(char *str)
 
 static int __init omap_serial_early_init(void)
 {
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
