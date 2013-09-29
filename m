From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 29 Sep 2013 23:41:43 +0200
Subject: [PATCH] ARM: mvebu: Add DT entry for ReadyNAS 102 to use
 gpio-poweroff driver
Message-ID: <8738onqp9k.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Without that fix, at the end of the shutdown process, the board is
still powered (led glowing, fan running, ...).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
HI Jason and Andrew,

This is not per se a fix for a real problem, as the NAS runs
as expected w/o it, it only solves a minor limitation of the
shutdown process so I guess it can be queued for 3.13 if it
is too late.

Additionally, I wonder if I should send another patch to either have
ARCH_MVEBU select POWER_SUPPLY, POWER_RESET and POWER_RESET_GPIO,
or have mvebu_defconfig modified to enable those, or keep things as
they are until there are more users on mvebu.

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 05e4485..5f7e7ec 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -57,6 +57,11 @@
 					marvell,pins = "mpp56";
 					marvell,function = "gpio";
 				};
+
+				poweroff: poweroff {
+					marvell,pins = "mpp8";
+					marvell,function = "gpio";
+				};
 			};
 
 			mdio {
@@ -176,4 +181,11 @@
 		};
 	};
 
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 8 1>;
+	};
+
 };
-- 
1.8.4.rc3
