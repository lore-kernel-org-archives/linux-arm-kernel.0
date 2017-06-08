From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  8 Jun 2017 16:11:23 +1200
Subject: [RFC PATCH 3/4] ARM: l2x0: add arm,ecc-enable property for aurora
In-Reply-To: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170608041124.4624-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora cache on the Marvell Armada-XP SoC supports ECC protection
for the L2 data arrays. Add a "arm,ecc-enable" device tree property
which can be used to enable this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
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
index 2cc2653b046f..4f0e6d9b151d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
 		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
 
+	if (of_property_read_bool(np, "arm,ecc-enable")) {
+		mask |= L2C_AUX_CTRL_EVTMON_ENABLE;
+		val |= L2C_AUX_CTRL_EVTMON_ENABLE;
+	} else if (of_property_read_bool(np, "arm,ecc-disable")) {
+		mask |= L2C_AUX_CTRL_EVTMON_ENABLE;
+	}
+
 	if (of_property_read_bool(np, "arm,parity-enable")) {
 		mask |= L2C_AUX_CTRL_PARITY_ENABLE;
 		val |= L2C_AUX_CTRL_PARITY_ENABLE;
-- 
2.13.0
