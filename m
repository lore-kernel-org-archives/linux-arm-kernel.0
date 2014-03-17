From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:42 +0000
Subject: [PATCH 14/44] ARM: l2c: move l2c save function to __l2c_init()
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCU-0002cm-Di@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no reason this functionality should be specific to DT, so move
it into the common initialisation function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 08f9cade028a..3b6213838054 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -357,6 +357,13 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
 	const char *type;
 
+	/*
+	 * It is strange to save the register state before initialisation,
+	 * but hey, this is what the DT implementations decided to do.
+	 */
+	if (data->save)
+		data->save(l2x0_base);
+
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	aux &= aux_mask;
@@ -1023,9 +1030,6 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 			aurora_broadcast_l2_commands();
 	}
 
-	if (data->save)
-		data->save(l2x0_base);
-
 	if (cache_id_part_number_from_dt)
 		cache_id = cache_id_part_number_from_dt;
 	else
-- 
1.8.3.1
