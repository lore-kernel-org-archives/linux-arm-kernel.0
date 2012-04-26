From: ylmao@marvell.com (Yilu Mao)
Date: Thu, 26 Apr 2012 13:08:57 +0800
Subject: [PATCH v3] ARM: cache-l2x0.c: save aux ctrl for resume in case that
 l2x0 is enabled before init
Message-ID: <1335416937-24724-1-git-send-email-ylmao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If l2x0 controller has been enabled when calling l2x0_init, the aux ctrl
register will not be saved in l2x0_saved_regs. Therefore we can not use
l2x0_saved_regs.aux_ctrl for resume later. This patch fixed the problem
by saving aux ctrl in l2x0_saved_regs just after it's being read from
the register.

Signed-off-by: Yilu Mao <ylmao@marvell.com>
---
 arch/arm/mm/cache-l2x0.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a53fd2a..f273c7e 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -320,6 +320,13 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
+	/*
+	 * In case l2x controller is enabled, the aux ctrl register
+	 * can't be set. So the original value should be stored in
+	 * the l2x0_saved_regs for restoring when resume.
+	 */
+	l2x0_saved_regs.aux_ctrl = aux;
+
 	aux &= aux_mask;
 	aux |= aux_val;
 
-- 
1.7.5.4
