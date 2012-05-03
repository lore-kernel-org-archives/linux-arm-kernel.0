From: ylmao@marvell.com (Yilu Mao)
Date: Thu,  3 May 2012 20:07:37 +0800
Subject: [PATCH v5] ARM: cache-l2x0.c: save the final aux ctrl value for
 resuming
Message-ID: <1336046857-24133-1-git-send-email-ylmao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a bug if l2x0 controller has been enabled when calling
l2x0_init, the aux ctrl register will not be saved in l2x0_saved_regs.
Therefore we will use uninitialized l2x0_saved_regs.aux_ctrl for
resuming later.

In this patch, the aux ctrl value is read and saved after it is
initialized. So we have the real value being set for resuming.

Signed-off-by: Yilu Mao <ylmao@marvell.com>
---
 arch/arm/mm/cache-l2x0.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a53fd2a..670ad48 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -364,14 +364,18 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		/* l2x0 controller is disabled */
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
 
-		l2x0_saved_regs.aux_ctrl = aux;
-
 		l2x0_inv_all();
 
 		/* enable L2X0 */
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
 
+	/* Re-read it in case some bits are reserved. */
+	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+
+	/* Save the value for resuming. */
+	l2x0_saved_regs.aux_ctrl = aux;
+
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
-- 
1.7.5.4
