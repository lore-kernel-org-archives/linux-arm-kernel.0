From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:59 +0900
Subject: [PATCH 128/130] ARM: shmobile: bockw: add pinctrl support
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-129-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SCIF0 support as 1st step

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 38e5e50..dac4365 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
@@ -37,6 +38,14 @@ static struct resource smsc911x_resources[] = {
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
 
+static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* SCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_data_a", "scif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_ctrl", "scif0"),
+};
+
 #define IRQ0MR	0x30
 static void __init bockw_init(void)
 {
@@ -46,6 +55,10 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 
+	pinctrl_register_mappings(bockw_pinctrl_map,
+				  ARRAY_SIZE(bockw_pinctrl_map));
+	r8a7778_pinmux_init();
+
 	fpga = ioremap_nocache(0x18200000, SZ_1M);
 	if (fpga) {
 		/*
-- 
1.8.2.1
