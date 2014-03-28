From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:03 +0000
Subject: [PATCH 66/75] ARM: l2c: print a warning with L2C-310 caches if the
 cache size is modified
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZf-0007HJ-Vk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have now removed all instances of the L2C-310 having its cache
size "modified" via platform/SoC code, discourage new cases showing
up by printing a warning.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 8af157031056..462675847cb7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -734,6 +734,8 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
+		if ((aux_val | ~aux_mask) & (L2C_AUX_CTRL_WAY_SIZE_MASK | L310_AUX_CTRL_ASSOCIATIVITY_16))
+			pr_warn("L2C: DT/platform tries to modify or specify cache size\n");
 		if (aux & (1 << 16))
 			ways = 16;
 		else
-- 
1.8.3.1
