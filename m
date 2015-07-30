From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Jul 2015 13:43:40 +0530
Subject: [PATCH 7/7] ARM: dts: dra72-evm: Fix spurious card insert/removal
 interrupt
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Message-ID: <1438244020-4244-8-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ldo1_reg in addition to being connected to the io lines is also
connected to the card detect line. On card removal, omap_hsmmc
driver does a regulator_disable causing card detect line to be
pulled down. This raises a card insertion interrupt and once the
MMC core detects there is no card inserted, it does a
regulator disable which again raises a card insertion interrupt.
This happens in a loop causing infinite MMC interrupts.

Fix it by making ldo1_reg as always_on.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index c5d8e7d..45f11a0 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -295,6 +295,7 @@
 					regulator-name = "ldo1";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
 					regulator-boot-on;
 				};
 
-- 
1.7.9.5
