From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  9 Nov 2018 20:03:44 +1300
Subject: [PATCH v6 4/9] ARM: l2x0: support parity-enable/disable on aurora
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181109070349.20464-5-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora cache on the Marvell Armada-XP SoC supports the same tag
parity features as the other l2x0 cache implementations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu at pengutronix.de: use aurora specific define AURORA_ACR_PARITY_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/mm/cache-l2x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7d2d2a3c67d0..b70bee74750d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
 		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
 
+	if (of_property_read_bool(np, "arm,parity-enable")) {
+		mask |= AURORA_ACR_PARITY_EN;
+		val |= AURORA_ACR_PARITY_EN;
+	} else if (of_property_read_bool(np, "arm,parity-disable")) {
+		mask |= AURORA_ACR_PARITY_EN;
+	}
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
-- 
2.19.1
