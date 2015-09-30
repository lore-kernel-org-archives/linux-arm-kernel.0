From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 30 Sep 2015 14:39:45 +0800
Subject: [PATCH v2 1/3] mfd: axp20x: Drop AXP221 DC1SW and DC5LDO regulator
 supplies from bindings
In-Reply-To: <1443595188-1283-1-git-send-email-wens@csie.org>
References: <1443595188-1283-1-git-send-email-wens@csie.org>
Message-ID: <1443595188-1283-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DC1SW and DC5LDO regulators in the AXP221 are internally chained
to DCDC1 and DCDC5, hence the names. The original bindings used the
parent regulator names for the supply regulator property. This causes
some confusion when we actually use it in the dts:

	axp221 {
		/* self supplying? */
		dcdc1-supply = <&dcdc1>;
		dcdc5-supply = <&dcdc5>;

		dcdc1: dcdc1 {
			...
		};

		dcdc5: dcdc5 {
			...
		};
	};

Since they are internally connected within the PMIC, their relationships
should not be visible in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 41811223e5be..a474359dd206 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -60,8 +60,8 @@ DCDC2		: DC-DC buck	: vin2-supply
 DCDC3		: DC-DC	buck	: vin3-supply
 DCDC4		: DC-DC	buck	: vin4-supply
 DCDC5		: DC-DC	buck	: vin5-supply
-DC1SW		: On/Off Switch	: dcdc1-supply		: DCDC1 secondary output
-DC5LDO		: LDO		: dcdc5-supply		: input from DCDC5
+DC1SW		: On/Off Switch	:			: DCDC1 secondary output
+DC5LDO		: LDO		:			: input from DCDC5
 ALDO1		: LDO		: aldoin-supply		: shared supply
 ALDO2		: LDO		: aldoin-supply		: shared supply
 ALDO3		: LDO		: aldoin-supply		: shared supply
-- 
2.5.3
