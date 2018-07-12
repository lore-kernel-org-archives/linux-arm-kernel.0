From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Jul 2018 00:04:48 +0800
Subject: [PATCH v3 1/5] dt-bindings: mfd: axp20x: Add "self-working" mode for
 AXP806
In-Reply-To: <20180712160452.5516-1-wens@csie.org>
References: <20180712160452.5516-1-wens@csie.org>
Message-ID: <20180712160452.5516-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP806 has three operation modes:

  - master mode: The PMIC is the first or only AXP PMIC in the system,
		 but is not in charge of power management, i.e. only
		 provides regulator functions.

  - slave mode: The PMIC is the second AXP PMIC in the system, chained
		to the first, or master, one.

  - self-working mode: The PMIC is the only AXP PMIC in the system, and
		       is in charge of power sequencing.

The functional differences between these modes can be found in the
"Control and Operation" chapter of the AXP806 (in Chinese) and AXP805
(in English) datasheets. These include how the PMIC responds to external
signals, whether it takes an external voltage reference or uses its own,
and whether the EN/PWRON pin functions as an enable switch or power button.

We already support both slave and master mode. This patch adds a property
for describing the self-working mode, and reworks the description for
the mode properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
Tested-by: Icenowy Zheng <icenowy@aosc.io>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index d1762f3b30af..eaaf79c01e1e 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -45,8 +45,11 @@ Optional properties:
 			  board is driving OTG VBus or not.
 			  (axp221 / axp223 / axp803/ axp813 only)
 
-- x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
-			wired for master mode. The default is slave mode.
+- x-powers,self-working-mode and
+  x-powers,master-mode: Boolean (axp806 only). Set either of these when the
+			PMIC is wired for self-working mode or master mode.
+			If neither is set then slave mode is assumed.
+			This corresponds to how the MODESET pin is wired.
 
 - <input>-supply: a phandle to the regulator supply node. May be omitted if
 		  inputs are unregulated, such as using the IPSOUT output
-- 
2.18.0
