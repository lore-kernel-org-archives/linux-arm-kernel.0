From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 02:02:14 +0200
Subject: [PATCH 2/6] ARM: dove: Fix tauros2 device tree init
In-Reply-To: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1348531338-16624-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review process of dove DT patches, Tauros2 cache
init call was changed and DT support added. This patch fixes
the call to Tauros2 init and adds a DT node. Moreover, plat/irq.h
include was missing from mach-dove/common.c.
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi |    5 +++++
 arch/arm/mach-dove/common.c |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 96fb824..3f41f50 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -20,6 +20,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		l2: l2-cache {
+			compatible = "marvell,tauros2-cache";
+			marvell,tauros2-cache-features = <0>;
+		};
+
 		uart0: serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index b37bef1..343a4bc 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <plat/time.h>
 #include <linux/platform_data/usb-ehci-orion.h>
+#include <plat/irq.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
 #include "common.h"
@@ -399,7 +400,7 @@ static void __init dove_dt_init(void)
 		(dove_tclk + 499999) / 1000000);
 
 #ifdef CONFIG_CACHE_TAUROS2
-	tauros2_init();
+	tauros2_init(0);
 #endif
 	dove_setup_cpu_mbus();
 
-- 
1.7.10.4
