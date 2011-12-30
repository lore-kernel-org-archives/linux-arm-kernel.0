From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Dec 2011 17:26:40 +0800
Subject: [PATCH] ARM: imx6: fix v7_invalidate_l1 by adding I-Cache invalidation
Message-ID: <1325237200-10610-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent suspend/resume and reset testing on imx6q discovers that
not only D-Cache but also I-Cache has random data and validity when
the core comes out of a power recycle.

This patch adds I-Cache invalidation into v7_invalidate_l1 to make
sure both D-Cache and I-Cache invalidated on power-up.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/head-v7.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index 6229efb..c844112 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -33,6 +33,7 @@
  */
 ENTRY(v7_invalidate_l1)
 	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
 	mcr	p15, 2, r0, c0, c0, 0
 	mrc	p15, 1, r0, c0, c0, 0
 
-- 
1.7.4.1
