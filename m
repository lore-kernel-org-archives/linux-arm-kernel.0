From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:52 -0700
Subject: [PATCH 5/9] ARM: BCM2836: Add io map initialization for bcm2836.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-bcm/board_bcm2835.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 70f2f39..69f5821 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -32,6 +32,7 @@
 #define PM_RSTS_HADWRH_SET		0x00000040
 
 #define BCM2835_PERIPH_PHYS	0x20000000
+#define BCM2836_PERIPH_PHYS	0x3f000000
 #define BCM2835_PERIPH_VIRT	0xf0000000
 #define BCM2835_PERIPH_SIZE	SZ_16M
 
@@ -93,16 +94,28 @@ static void bcm2835_power_off(void)
 	bcm2835_restart(REBOOT_HARD, "");
 }
 
-static struct map_desc io_map __initdata = {
+static struct map_desc bcm2835_io_map __initdata = {
 	.virtual = BCM2835_PERIPH_VIRT,
 	.pfn = __phys_to_pfn(BCM2835_PERIPH_PHYS),
 	.length = BCM2835_PERIPH_SIZE,
 	.type = MT_DEVICE
 };
 
+static struct map_desc bcm2836_io_map __initdata = {
+	.virtual = BCM2835_PERIPH_VIRT,
+	.pfn = __phys_to_pfn(BCM2836_PERIPH_PHYS),
+	.length = BCM2835_PERIPH_SIZE,
+	.type = MT_DEVICE
+};
+
 static void __init bcm2835_map_io(void)
 {
-	iotable_init(&io_map, 1);
+	iotable_init(&bcm2835_io_map, 1);
+}
+
+static void __init bcm2836_map_io(void)
+{
+	iotable_init(&bcm2836_io_map, 1);
 }
 
 static void __init bcm2835_init(void)
@@ -128,6 +141,11 @@ static const char * const bcm2835_compat[] = {
 	NULL
 };
 
+static const char * const bcm2836_compat[] = {
+	"brcm,bcm2836",
+	NULL
+};
+
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.map_io = bcm2835_map_io,
 	.init_irq = irqchip_init,
@@ -135,3 +153,11 @@ DT_MACHINE_START(BCM2835, "BCM2835")
 	.restart = bcm2835_restart,
 	.dt_compat = bcm2835_compat
 MACHINE_END
+
+DT_MACHINE_START(BCM2836, "BCM2836")
+	.map_io = bcm2836_map_io,
+	.init_irq = irqchip_init,
+	.init_machine = bcm2835_init,
+	.restart = bcm2835_restart,
+	.dt_compat = bcm2836_compat
+MACHINE_END
-- 
2.1.4
