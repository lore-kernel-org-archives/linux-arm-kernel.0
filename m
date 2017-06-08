From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  8 Jun 2017 16:11:22 +1200
Subject: [RFC PATCH 2/4] ARM: l2x0: support parity-enable/disable on aurora
In-Reply-To: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170608041124.4624-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora cache on the Marvell Armada-XP SoC supports the same tag
parity features as the other l2x0 cache implementations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mm/cache-l2x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 808efbb89b88..2cc2653b046f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
 		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
 
+	if (of_property_read_bool(np, "arm,parity-enable")) {
+		mask |= L2C_AUX_CTRL_PARITY_ENABLE;
+		val |= L2C_AUX_CTRL_PARITY_ENABLE;
+	} else if (of_property_read_bool(np, "arm,parity-disable")) {
+		mask |= L2C_AUX_CTRL_PARITY_ENABLE;
+	}
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
-- 
2.13.0
