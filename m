From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 16 Mar 2012 17:18:00 -0400
Subject: ARM: fix build failure on ux500 in linux-next
Message-ID: <20120316211759.GA18829@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I 1st saw this build failure, I thought it was me, because of the
BUG() stuff.  But git bisect claims it comes from the arm-soc tree?

In any case, the fix is trivial and self evident, regardless of where
it came from.  I can carry it in my bug-3.4 cleanup tree if need be.
Let me know if you want me to do that.

Thanks,
Paul.
---

git bisect start
# good: [fde7d9049e55ab85a390be7f415d74c9f62dd0f9] Linux 3.3-rc7
git bisect good fde7d9049e55ab85a390be7f415d74c9f62dd0f9
# bad: [e9ae4cb7dce90c006b25783f431100c1aebe8249] Add linux-next specific files for 20120316
git bisect bad e9ae4cb7dce90c006b25783f431100c1aebe8249
# good: [04e2934e35128af6772c6e7582a2a70e9bfa6e39] Merge remote-tracking branch 'sound/for-next'
git bisect good 04e2934e35128af6772c6e7582a2a70e9bfa6e39
# good: [83e256edcb2f8886786b1bba59992c90391e162a] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 83e256edcb2f8886786b1bba59992c90391e162a
# good: [e047bb4623cb69a162fe3b6dffb6b6719e5ed36b] Merge remote-tracking branch 'tmem/linux-next'
git bisect good e047bb4623cb69a162fe3b6dffb6b6719e5ed36b
# good: [4d879eaf577c4f1a84a9cad4445e388f3fa3751b] Merge branch 'next/timer' into for-next
git bisect good 4d879eaf577c4f1a84a9cad4445e388f3fa3751b
# bad: [11f98c49d6bbedf80ebd3b477cf9283c6a3e9b1a] xtensa: use set_current_blocked() and block_sigmask()
git bisect bad 11f98c49d6bbedf80ebd3b477cf9283c6a3e9b1a
# good: [50cfadc1b7ae56c5062401018df8fe16114de29a] Merge remote-tracking branch 'gpio/gpio/next'
git bisect good 50cfadc1b7ae56c5062401018df8fe16114de29a
# bad: [befe1aab92393bd4106d78f5610958dc37dce074] Merge remote-tracking branch 'dma-mapping/dma-mapping-next'
git bisect bad befe1aab92393bd4106d78f5610958dc37dce074
# good: [7ae1cd4e9625311fbada74513a69044f66b5eff9] Merge branch 'next/boards' into for-next
git bisect good 7ae1cd4e9625311fbada74513a69044f66b5eff9
# good: [268b190b02965250cb5080beb755f25a2631cceb] Merge branch 'next/drivers' into for-next
git bisect good 268b190b02965250cb5080beb755f25a2631cceb
# good: [b908eddffb98f4106068e132b6a05888cea59fd0] Hexagon: adapt for dma_map_ops changes
git bisect good b908eddffb98f4106068e132b6a05888cea59fd0
# good: [62d02641854bc02534c32e2c20f0d403cde32f24] Merge branch 'next/soc2' into for-next
git bisect good 62d02641854bc02534c32e2c20f0d403cde32f24
# good: [c4715f1e814e05beb5f99ec18ddb0e2e934a8b3d] common: DMA-mapping: add WRITE_COMBINE attribute
git bisect good c4715f1e814e05beb5f99ec18ddb0e2e934a8b3d
# good: [6cc2bf1ab405a7085c92fefbad610b35ec60d3e0] common: DMA-mapping: add NON-CONSISTENT attribute
git bisect good 6cc2bf1ab405a7085c92fefbad610b35ec60d3e0
# bad: [c4aa47a2a1665e8d5ea62dcbfba9a54a86003190] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad c4aa47a2a1665e8d5ea62dcbfba9a54a86003190

---

>From 79a97eb612706ee3428ae7909503079c6fd3cf68 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 16 Mar 2012 16:45:32 -0400
Subject: [PATCH] ARM: fix trivial build failures on ux500

Seen in linux-next builds:

arch/arm/mach-ux500/timer.c: In function 'ux500_twd_init':
arch/arm/mach-ux500/timer.c:35: error: implicit declaration of function 'pr_err'
arch/arm/mach-ux500/timer.c: In function 'ux500_timer_init':
arch/arm/mach-ux500/timer.c:53: error: implicit declaration of function 'BUG'

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index e9d5807..90cf3f0 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -5,6 +5,8 @@
  * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
  */
 #include <linux/io.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 
-- 
1.7.9.1
