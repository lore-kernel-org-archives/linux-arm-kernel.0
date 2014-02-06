From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:46 +0100
Subject: [PATCH v2 01/12] ARM: EXYNOS: Do not resume l2x0 if not enabled before
 suspend
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to resume l2x0 if it was not enabled before suspend leads to
system crash. This patch prevents this by checking if l2x0_regs_phys is
a valid pointer to l2x0 context data saved on initialization.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/s5p-sleep.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index a030e73..20764bd 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -59,13 +59,15 @@ ENTRY(s3c_cpu_resume)
 	and	r0, r0, r1
 	ldr	r1, =CPU_CORTEX_A9
 	cmp	r0, r1
-	bne	resume_l2on
+	bne	skip_l2_resume
 	adr	r0, l2x0_regs_phys
 	ldr	r0, [r0]
+	cmp	r0, #0
+	beq	skip_l2_resume
 	ldr	r1, [r0, #L2X0_R_PHY_BASE]
 	ldr	r2, [r1, #L2X0_CTRL]
 	tst	r2, #0x1
-	bne	resume_l2on
+	bne	skip_l2_resume
 	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
 	str	r2, [r1, #L2X0_AUX_CTRL]
 	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
@@ -78,7 +80,7 @@ ENTRY(s3c_cpu_resume)
 	str	r2, [r1, #L2X0_POWER_CTRL]
 	mov	r2, #1
 	str	r2, [r1, #L2X0_CTRL]
-resume_l2on:
+skip_l2_resume:
 #endif
 	b	cpu_resume
 ENDPROC(s3c_cpu_resume)
-- 
1.8.5.2
