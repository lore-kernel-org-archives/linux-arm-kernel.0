From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:21:59 +0900
Subject: [PATCH 01/11] ARM: shmobile: ape6evm: MP clock parent become EXTAL2
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The orignal commit 3263e09d287fbaa8a9424b5e69396599a3bbd518
(ARM: shmobile: Initial r8a73a4 SoC support V3)
put MP clock parent as EXTAL2, but its code was removed
on DIV6 clock support commit.
This patch makes it consistent.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 55b8c9f..5eb0caa 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -65,7 +66,21 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 
 static void __init ape6evm_add_standard_devices(void)
 {
+
+	struct clk *parent;
+	struct clk *mp;
+
 	r8a73a4_clock_init();
+
+	/* MP clock parent = extal2 */
+	parent      = clk_get(NULL, "extal2");
+	mp          = clk_get(NULL, "mp");
+	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
+
+	clk_set_parent(mp, parent);
+	clk_put(parent);
+	clk_put(mp);
+
 	pinctrl_register_mappings(ape6evm_pinctrl_map,
 				  ARRAY_SIZE(ape6evm_pinctrl_map));
 	r8a73a4_pinmux_init();
-- 
1.8.2.1
