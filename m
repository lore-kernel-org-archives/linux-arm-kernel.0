From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  6 Aug 2013 16:50:10 +0900
Subject: [PATCH v7 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
References: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375775411-4545-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".

v7
* Do not add spurious blank line

v6
* Correct first argument of PIN_MAP_MUX_GROUP_DEFAULT()
  to use "r8a7790-ether" instead of "sh-eth".
* Remove bogus "IRQ0" comment in ether_resources[]

v5
* As suggested by Laurent Pinchart
  - Do not use eth_magic pinmux group, that pin is not used on Lager
* As suggested by Morimoto-san and Magnus Damm
  - Refactor moving all setup code into boards-lager.c

v4
* Remove needs_gpio_reset and reset_gpio from ether_platdata
  as the patch that adds that feature and those fields has
  been dropped.
* Annotate ether_platdata as __initdata

v3
* Use newly added "r8a7790-ether" instead of "sh-eth"

v2
* Do not add MSTP812, EtherAVB. It is not used.
* As suggested by Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
  - Move Ethernet element of MSTP enum to a separate line
  - Move declaration of r8a7790_add_ether_device() to immediately
    after that of r8a7790_add_standard_devices()
  - Add __initdata annotation to ether_resource.
* As suggested by Laurent Pinchart
  - Do not manipilate sh_eth reset GPIO directly,
    rather, do so through newly proposed support for this in
    the sh_eth driver.
* A suggested by Sergei Shtylyov
  - Move DTS portion into a separate patch
---
 arch/arm/mach-shmobile/board-lager.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index aa8be24..4872939 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/sh_eth.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
@@ -91,6 +92,20 @@ static struct resource mmcif1_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
 
+/* Ether */
+static struct sh_eth_plat_data ether_pdata __initdata = {
+	.phy			= 0x1,
+	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
+	.register_type		= SH_ETH_REG_FAST_RCAR,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
+	.ether_link_active_low	= 1,
+};
+
+static struct resource ether_resources[] __initdata = {
+	DEFINE_RES_MEM(0xee700000, 0x400),
+	DEFINE_RES_IRQ(gic_spi(162)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -103,6 +118,15 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "mmc1_data8", "mmc1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
 				  "mmc1_ctrl", "mmc1"),
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
+				  "eth_link", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
+				  "eth_mdio", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
+				  "eth_rmii", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
+				  "intc_irq0", "intc"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -125,6 +149,11 @@ static void __init lager_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "sh_mmcif", 1,
 					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
 					  &mmcif1_pdata, sizeof(mmcif1_pdata));
+
+	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_pdata, sizeof(ether_pdata));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.3.2
