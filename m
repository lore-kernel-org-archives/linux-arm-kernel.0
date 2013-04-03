From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:19 +0900
Subject: [PATCH 04/11] ARM: shmobile: APE6EVM PFC support
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Start using the r8a73a4 PFC on the APE6EVM board
and configure the SCIFA0 console signals in the
PFC via PINCTRL.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 9234d4f..33a8a62 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -21,15 +21,25 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static const struct pinctrl_map ape6evm_pinctrl_map[] = {
+	/* SCIFA0 console */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
+				  "scifa0_data", "scifa0"),
+};
+
 static void __init ape6evm_add_standard_devices(void)
 {
 	r8a73a4_clock_init();
+	pinctrl_register_mappings(ape6evm_pinctrl_map,
+				  ARRAY_SIZE(ape6evm_pinctrl_map));
+	r8a73a4_pinmux_init();
 	r8a73a4_add_standard_devices();
 }
 
-- 
1.7.10.4
