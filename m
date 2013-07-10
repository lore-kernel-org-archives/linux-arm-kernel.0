From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 10 Jul 2013 10:56:35 +0900
Subject: [PATCH 1/3] ARM: shmobile: fix compile error when
 CONFIG_THUMB2_KERNEL=y
In-Reply-To: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
Message-ID: <1373421397-1786-2-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On KZM-A9-GT board (SMP), when CONFIG_THUMB2_KERNEL=y it fails to compile
 
  AS      arch/arm/mach-shmobile/headsmp-scu.o
/proj/koba/kernel/arm-soc/arch/arm/mach-shmobile/headsmp-scu.S: Assembler messages:
/proj/koba/kernel/arm-soc/arch/arm/mach-shmobile/headsmp-scu.S:41: Error: shift must be constant -- `bic r2,r2,r3,lsl r1'
make[2]: *** [arch/arm/mach-shmobile/headsmp-scu.o] Error 1
make[1]: *** [arch/arm/mach-shmobile] Error 2
make: *** [sub-make] Error 2

Instruction `bic r2,r2,r3,lsl r1' is not supported in thumb mode. This patch split it into 2 instructions.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/headsmp-scu.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 6f98654..5ce416c 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -38,7 +38,8 @@ ENTRY(shmobile_boot_scu)
 	lsl	r1, r1, #3		@ we will shift by cpu_id * 8 bits
 	ldr	r2, [r0, #8]		@ SCU Power Status Register
 	mov	r3, #3
-	bic	r2, r2, r3, lsl r1	@ Clear bits of our CPU (Run Mode)
+	lsl	r3, r3, r1
+	bic	r2, r2, r3		@ Clear bits of our CPU (Run Mode)
 	str	r2, [r0, #8]		@ write back
 
 	b	shmobile_invalidate_start
-- 
1.7.9.5
