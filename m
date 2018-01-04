From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  4 Jan 2018 17:53:12 +0100
Subject: [PATCH] ARM: dts: kirkwood: fix pin-muxing of MPP7
Message-ID: <20180104165312.14052-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPP7 is currently muxed as "gpio", but this function doesn't exist for
MPP7, only "gpo" is available. This causes the following error:

kirkwood-pinctrl f1010000.pin-controller: unsupported function gpio on pin mpp7
pinctrl core: failed to register map default (6): invalid type given
kirkwood-pinctrl f1010000.pin-controller: error claiming hogs: -22
kirkwood-pinctrl f1010000.pin-controller: could not claim hogs: -22
kirkwood-pinctrl f1010000.pin-controller: unable to register pinctrl driver
kirkwood-pinctrl: probe of f1010000.pin-controller failed with error -22

So the pinctrl driver is not probed, all device drivers (including the
UART driver) do a -EPROBE_DEFER, and therefore the system doesn't
really boot (well, it boots, but with no UART, and no devices that
require pin-muxing).

Back when the Device Tree file for this board was introduced, the
definition was already wrong. The pinctrl driver also always described
as "gpo" this function for MPP7. However, between Linux 4.10 and 4.11,
a hog pin failing to be muxed was turned from a simple warning to a
hard error that caused the entire pinctrl driver probe to bail
out. This is probably the result of commit 6118714275f0a ("pinctrl:
core: Fix pinctrl_register_and_init() with pinctrl_enable()").

This commit fixes the Device Tree to use the proper "gpo" function for
MPP7, which fixes the boot of OpenBlocks A7, which was broken since
Linux 4.11.

Fixes: f24b56cbcd9d ("ARM: kirkwood: add support for OpenBlocks A7 platform")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index cf2f5240e176..27cc913ca0f5 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -53,7 +53,8 @@
 		};
 
 		pinctrl: pin-controller at 10000 {
-			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
+			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header
+				     &pmx_gpio_header_gpo>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -85,11 +86,16 @@
 			 * ground.
 			 */
 			pmx_gpio_header: pmx-gpio-header {
-				marvell,pins = "mpp17", "mpp7", "mpp29", "mpp28",
+				marvell,pins = "mpp17", "mpp29", "mpp28",
 					       "mpp35", "mpp34", "mpp40";
 				marvell,function = "gpio";
 			};
 
+			pmx_gpio_header_gpo: pxm-gpio-header-gpo {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+
 			pmx_gpio_init: pmx-init {
 				marvell,pins = "mpp38";
 				marvell,function = "gpio";
-- 
2.14.3
