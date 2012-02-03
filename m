From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:57:35 +0000
Subject: [PATCH 09/20] ARM: sa11x0: badge4: move board specific ohci
 initialization to badge4.c
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPGJ-000446-VO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the handling of the 5v supply into badge4.c, removing this board
specific detail from the sa1111 ohci driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/badge4.c  |   15 +++++++++++++++
 drivers/usb/host/ohci-sa1111.c |   14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index b07a2c0..d8492499 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -51,8 +51,23 @@ static struct resource sa1111_resources[] = {
 	},
 };
 
+static int badge4_sa1111_enable(void *data, unsigned devid)
+{
+	if (devid == SA1111_DEVID_USB)
+		badge4_set_5V(BADGE4_5V_USB, 1);
+	return 0;
+}
+
+static void badge4_sa1111_disable(void *data, unsigned devid)
+{
+	if (devid == SA1111_DEVID_USB)
+		badge4_set_5V(BADGE4_5V_USB, 0);
+}
+
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
+	.enable		= badge4_sa1111_enable,
+	.disable	= badge4_sa1111_disable,
 };
 
 static u64 sa1111_dmamask = 0xffffffffUL;
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index f61f4f9..4830008 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -16,7 +16,6 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <mach/assabet.h>
-#include <mach/badge4.h>
 #include <asm/hardware/sa1111.h>
 
 #ifndef CONFIG_SA1111
@@ -35,12 +34,6 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
 	printk(KERN_DEBUG "%s: starting SA-1111 OHCI USB Controller\n",
 	       __FILE__);
 
-#ifdef CONFIG_SA1100_BADGE4
-	if (machine_is_badge4()) {
-		badge4_set_5V(BADGE4_5V_USB, 1);
-	}
-#endif
-
 	if (machine_is_xp860() ||
 	    machine_has_neponset() ||
 	    machine_is_pfs168() ||
@@ -84,13 +77,6 @@ static void sa1111_stop_hc(struct sa1111_dev *dev)
 	 * Stop the USB clock.
 	 */
 	sa1111_disable_device(dev);
-
-#ifdef CONFIG_SA1100_BADGE4
-	if (machine_is_badge4()) {
-		/* Disable power to the USB bus */
-		badge4_set_5V(BADGE4_5V_USB, 0);
-	}
-#endif
 }
 
 
-- 
1.7.4.4
