From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 17:38:23 +0000
Subject: [PATCH 1/3] ARM: at91/dt: sama5d3 fill in mmc1 and default disabled
In-Reply-To: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427391505-29129-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc1 channel is not populated on the SAM5D3 Xplained board, however
it is enabled and therefore the driver is attaching to it.

The node configuration for mmc1 is missing, so add an mmc1 node in the
device tree so add the basic node, set it to default it to disabled. Also
add the vmmc and also the necessary slot configuration if this node
where to be enabled to avoid the following warnings from the driver.

atmel_mci f8000000.mmc: No vmmc regulator found
atmel_mci f8000000.mmc: No vqmmc regulator found

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: linux-arm-kernel at lists.infradead.org
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
CC: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index fec1fca..652c4dd 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -43,6 +43,17 @@
 				};
 			};
 
+			mmc1: mmc at f8000000 {
+				vmmc-supply = <&vcc_3v3_reg>;
+				vqmmc-supply = <&vcc_3v3_reg>;
+				status = "disabled";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioE 1 GPIO_ACTIVE_LOW>;
+				};
+			};
+
 			spi0: spi at f0004000 {
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
 				status = "okay";
-- 
2.1.4
