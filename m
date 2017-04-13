From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 13 Apr 2017 06:32:37 -0700
Subject: [PATCH 3/8] ARM: dts: imx7s: Adjust anatop-enable-bit for 'reg_1p0d'
In-Reply-To: <20170413133242.5068-1-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
Message-ID: <20170413133242.5068-4-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In PMU_REG_1P0Dn ENABLE_LINREG is bit 0. Bit 31 is called OVERRIDE and
it serves the function of granting permission to GPC IP block to alter
various bit-fields of the register. The reason why this property, that
trickeld here from Freescale BSP, is set to 31 is because in the code
it came from it is used in conjunction with a notifier handler for
REGULATOR_EVENT_PRE_DO_ENABLE and REGULATOR_EVENT_PRE_DO_DISABLE
events (not found in upstream kernel) that triggers GPC to start
manipulating aforementioned other bitfields.

Since:
	a) none of the aforementioned machinery is implemented by
	   upstream
	b) using 'anatop-enable-bit' in that capacity is a bit of a
	   semantic stretch

simplify the situation by setting the value of 'anatop-enable-bit' to
point to ENABLE_LINREG (same as i.MX6).

Cc: yurovsky at gmail.com
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 22c9788..8fee299 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -516,7 +516,7 @@
 					anatop-min-bit-val = <8>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1200000>;
-					anatop-enable-bit = <31>;
+					anatop-enable-bit = <0>;
 				};
 			};
 
-- 
2.9.3
