From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 13:37:13 +0100
Subject: [PATCH] ARM: zynq: add smp_twd timer
Message-ID: <1364042233-16583-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq has a Cortex-A9 with the corresponding smp_twd timers. Use them.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 7 +++++++
 arch/arm/mach-zynq/common.c      | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 5914b56..0dd2dc7 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -162,5 +162,12 @@
 				interrupts = <0 39 4>;
 			};
 		};
+
+		timer: timer at f8f00600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xf8f00600 0x20>;
+			clocks = <&cpu_clk 1>;
+			interrupts = <1 13 0xf01>;
+		};
 	};
 };
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5c89832..920e20a 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
@@ -77,6 +78,7 @@ static void __init xilinx_zynq_timer_init(void)
 
 	xilinx_zynq_clocks_init(slcr);
 
+	twd_local_timer_of_register();
 	xttcps_timer_init();
 }
 
-- 
1.8.2.rc2
