From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:17 +0900
Subject: [PATCH 25/43] ARM: shmobile: Fix base address readout in headsmp-scu.S
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-26-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the early SCU setup code in headsmp-scu.S to read
the base address in the same way as we use to fetch the
address of the invalidation function.

Reported-by: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-scu.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 0b93170..7d113f8 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -39,7 +39,7 @@ ENTRY(shmobile_secondary_vector_scu)
 	mrc     p15, 0, r0, c0, c0, 5	@ read MIPDR
 	and	r0, r0, #3		@ mask out cpu ID
 	lsl	r0, r0, #3		@ we will shift by cpu_id * 8 bits
-	ldr	r1, =shmobile_scu_base
+	ldr	r1, 2f
 	ldr	r1, [r1]		@ SCU base address
 	ldr	r2, [r1, #8]		@ SCU Power Status Register
 	mov	r3, #3
@@ -48,6 +48,7 @@ ENTRY(shmobile_secondary_vector_scu)
 
 	ldr	pc, 1f
 1:	.long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
+2:	.long shmobile_scu_base - PAGE_OFFSET + PLAT_PHYS_OFFSET
 ENDPROC(shmobile_secondary_vector_scu)
 
 	.text
-- 
1.7.10.4
