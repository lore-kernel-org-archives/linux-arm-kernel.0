From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Mar 2013 17:00:12 +0900
Subject: [PATCH 02/03 v2] ARM: shmobile: APE6EVM PFC support
In-Reply-To: <20130329075952.15748.6290.sendpatchset@w520>
References: <20130329075952.15748.6290.sendpatchset@w520>
Message-ID: <20130329080012.15748.74546.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Start using the r8a73a4 PFC on the APE6EVM board
and configure the SCIFA0 console signals in the
PFC via PINCTRL.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 -  Use PINCTRL instead of function GPIOs

 arch/arm/mach-shmobile/board-ape6evm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0012/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-03-26 18:56:46.000000000 +0900
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
 
