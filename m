From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Fri,  1 Apr 2016 14:41:47 +0200
Subject: [PATCH 1/2] ARM: dts: imx6: Fix PCIe reset gpio polarity on Toradex
 Apalis Ixora
In-Reply-To: <1459514508-8557-1-git-send-email-ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
Message-ID: <1459514508-8557-2-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding reset-gpio-active-high boolean DT binding property, which we need
to make PCIe working on Apalis SoMs and not break old DTBs. While at it,
I've fixed comment and GPIO polarity.

On Apalis SoMs the GPIO1_IO28 used to PCIe reset is not connected
directly to PERST# PCIe signal, but it's ORed with RESETBMCU coming off
the PMIC, and thus is inverted, active-high.

Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 2cba82d..4b533cb 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -174,8 +174,9 @@
 };
 
 &pcie {
-	/* active-low meaning opposite of regular PERST# active-low polarity */
-	reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	/* active-high meaning opposite of regular PERST# active-low polarity */
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	reset-gpio-active-high;
 	status = "okay";
 };
 
-- 
1.9.1
