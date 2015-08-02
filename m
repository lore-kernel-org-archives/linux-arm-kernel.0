From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Aug 2015 23:56:33 +0200
Subject: [PATCH 3/4] ARM: nomadik: move l2x0 setup to device tree
Message-ID: <1438552593-4578-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cache setup magic value in the Nomadik machine is plain wrong,
the correct settings can be done using device tree in accordance
with the settings from ST's own port.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 7 +++++++
 arch/arm/mach-nomadik/cpu-8815.c           | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 0edab6d23211..defabe053114 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -21,6 +21,13 @@
 		interrupts = <30>;
 		cache-unified;
 		cache-level = <2>;
+		cache-size = <131072>;
+		cache-sets = <512>;
+		cache-line-size = <32>;
+		/* At full speed latency must be >=2 */
+		arm,tag-latency = <2>;
+		arm,data-latency = <2 2>;
+		arm,dirty-latency = <2>;
 	};
 
 	mtu0: mtu at 101e2000 {
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 82831dc6122f..009754055f09 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -114,9 +114,8 @@ static const char * cpu8815_board_compat[] = {
 };
 
 DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
-	/* At full speed latency must be >=2, so 0x249 in low bits */
-	.l2c_aux_val	= 0x00700249,
-	.l2c_aux_mask	= 0xfe0fefff,
+	.l2c_aux_val	= 0x0,
+	.l2c_aux_mask	= ~0x0UL,
 	.map_io		= cpu8815_map_io,
 	.restart	= cpu8815_restart,
 	.dt_compat      = cpu8815_board_compat,
-- 
2.4.3
