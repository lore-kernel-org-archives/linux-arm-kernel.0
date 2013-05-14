From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 14 May 2013 11:39:30 +0900
Subject: [PATCH v2 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
References: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368499171-22427-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a build-time dependency on "sh_eth: add support for gpio reset".
This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".

v2
* As suggested by Laurent Pinchart
  - Do not manipilate sh_eth reset GPIO directly,
    rather, do so through newly proposed support for this in
    the sh_eth driver.
* A suggested by Sergei Shtylyov
  - Move DTS portion into a separate patch
---
 arch/arm/mach-shmobile/board-lager.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 6a1ba38..c06f0da 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
@@ -52,6 +53,17 @@ static struct gpio_led_platform_data lager_leds_pdata = {
 	.num_leds	= ARRAY_SIZE(lager_leds),
 };
 
+/* Ether */
+static struct sh_eth_plat_data ether_platdata = {
+	.phy			= 0x1,
+	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
+	.register_type		= SH_ETH_REG_FAST_RCAR,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
+	.ether_link_active_low	= 1,
+	.needs_gpio_reset	= 1,
+	.reset_gpio		= RCAR_GP_PIN(5, 31),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -59,6 +71,17 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
+				  "eth_link", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
+				  "eth_magic", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
+				  "eth_mdio", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
+				  "eth_rmii", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
+				  "intc_irq0", "intc"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -73,6 +96,8 @@ static void __init lager_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &lager_leds_pdata,
 				      sizeof(lager_leds_pdata));
+
+	r8a7790_add_ether_device(&ether_platdata);
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.2.1
