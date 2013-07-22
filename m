From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:37:00 +0900
Subject: [PATCH 3/5] ARM: shmobile: Force ARM mode to compile reset vector for
 secondary CPUs
In-Reply-To: <cover.1374478336.git.horms+renesas@verge.net.au>
References: <cover.1374478336.git.horms+renesas@verge.net.au>
Message-ID: <c1d7e2e80079148626e6c411e56708d86311d31a.1374478336.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Instructions start from boot vector must be ARM mode.
This patch specify ARM mode explicitly and use 'bx' instruction to be
able to change to Thumb mode.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 559d1ce..afed58e 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -26,10 +26,13 @@ ENDPROC(shmobile_invalidate_start)
  * This will be mapped at address 0 by SBAR register.
  * We need _long_ jump to the physical address.
  */
+	.arm
 	.align  12
 ENTRY(shmobile_boot_vector)
 	ldr     r0, 2f
-	ldr     pc, 1f
+	ldr     r1, 1f
+	bx	r1
+
 ENDPROC(shmobile_boot_vector)
 
 	.globl	shmobile_boot_fn
-- 
1.8.2.1
