From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:36:34 +0100
Subject: [PATCH 066/222] ARM: l2c: print a warning with L2C-310 caches if the
 cache size is modified
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeQk-0007HY-58@rmk-PC.arm.linux.org.uk>
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
index db3f18a968b2..48b826e759cb 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -732,6 +732,8 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
