From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 18 Jun 2013 10:11:05 +0200
Subject: [PATCH v2] ARM: mm: cpu_fa526_do_idle: remove WFI
Message-ID: <1371543065-5843-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it was already suggested by Russell King and Arnd Bergmann:

https://lkml.org/lkml/2013/5/16/133

moxart and gemini seem to be the only platforms using CPU_FA526,
and instead of pointing arm_pm_idle to an empty function from
platform code, it makes sense to remove WFI code from the processor
specific idle function.

Applies to arm-soc/for-next.

Changes since v1:

1. remove WFI but make sure cpu_fa526_do_idle do not fall through
   to cpu_fa526_dcache_clean_area

Note: moxart boots and prints to UART without this patch, but input is broken.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---
 arch/arm/mm/proc-fa526.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index d217e97..aaeb6c1 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -81,7 +81,6 @@ ENDPROC(cpu_fa526_reset)
  */
 	.align	4
 ENTRY(cpu_fa526_do_idle)
-	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
 	mov	pc, lr
 
 
-- 
1.7.2.5
