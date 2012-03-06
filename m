From: mgherzan@gmail.com (Mircea Gherzan)
Date: Tue,  6 Mar 2012 23:55:04 +0100
Subject: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Message-ID: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "uim" deamon requires sysfs entries that are filled in using
this platform data.

Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
 include/linux/ti_wilink_st.h           |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b1d74d6..339e781 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -27,6 +27,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
 
 #include <mach/hardware.h>
@@ -56,12 +57,21 @@
 #define HDMI_GPIO_HPD  63 /* Hotplug detect */
 
 /* wl127x BT, FM, GPS connectivity chip */
-static int wl1271_gpios[] = {46, -1, -1};
+static struct ti_st_plat_data wilink_platform_data = {
+	.nshutdown_gpio	= 46,
+	.dev_name	= "/dev/ttyO1",
+	.flow_cntrl	= 1,
+	.baud_rate	= 3000000,
+	.chip_enable	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+};
+
 static struct platform_device wl1271_device = {
 	.name	= "kim",
 	.id	= -1,
 	.dev	= {
-		.platform_data	= &wl1271_gpios,
+		.platform_data	= &wilink_platform_data,
 	},
 };
 
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 2ef4385..3ca0269 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -25,6 +25,8 @@
 #ifndef TI_WILINK_ST_H
 #define TI_WILINK_ST_H
 
+#include <linux/skbuff.h>
+
 /**
  * enum proto-type - The protocol on WiLink chips which share a
  *	common physical interface like UART.
-- 
1.7.9.1
