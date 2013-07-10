From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 10 Jul 2013 10:56:36 +0900
Subject: [PATCH 2/3] ARM: shmobile: Force ARM mode to compile reset vector for
 secondary CPUs
In-Reply-To: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
Message-ID: <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instructions start from boot vector must be ARM mode.
This patch specify ARM mode explicitly and use 'bx' instruction to be
able to change to Thumb mode.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/headsmp.S |    5 ++++-
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
1.7.9.5
