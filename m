From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri, 30 Jun 2017 16:51:02 +0200
Subject: [PATCH 4/8] ARM: l2x0: add arm,ecc-enable property for aurora
In-Reply-To: <20170630145106.29820-1-jlu@pengutronix.de>
References: <20170630145106.29820-1-jlu@pengutronix.de>
Message-ID: <20170630145106.29820-5-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

The aurora cache on the Marvell Armada-XP SoC supports ECC protection
for the L2 data arrays. Add a "arm,ecc-enable" device tree property
which can be used to enable this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu at pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
 arch/arm/mm/cache-l2x0.c                         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index d9650c1788f4..6316e673307a 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -76,6 +76,8 @@ Optional properties:
   specified to indicate that such transforms are precluded.
 - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
 - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
+- arm,ecc-enable : enable ECC protection on the L2 cache
+- arm,ecc-disable : disable ECC protection on the L2 cache
 - arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
   Some core tiles, especially ARM PB11MPCore have a faulty L220 cache that
   will randomly hang unless outer sync operations are disabled.
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b70bee74750d..ea2a3dcc75a9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
 		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
 
+	if (of_property_read_bool(np, "arm,ecc-enable")) {
+		mask |= AURORA_ACR_ECC_EN;
+		val |= AURORA_ACR_ECC_EN;
+	} else if (of_property_read_bool(np, "arm,ecc-disable")) {
+		mask |= AURORA_ACR_ECC_EN;
+	}
+
 	if (of_property_read_bool(np, "arm,parity-enable")) {
 		mask |= AURORA_ACR_PARITY_EN;
 		val |= AURORA_ACR_PARITY_EN;
-- 
2.11.0
