From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:44 +0900
Subject: [PATCH 6/7] ARM: EXYNOS4: Add save/restore for more ARM registers
In-Reply-To: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1308732405-16664-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch adds save/restore for Power Control Register and
Diagnostic Register.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/sleep.S |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index d55d38c..4fe13fc 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -42,6 +42,15 @@
 ENTRY(s3c_cpu_save)
 
 	stmfd	sp!, { r3 - r12, lr }
+
+	adr	r0, sleep_save_misc
+
+	mrc	p15, 0, r2, c15, c0, 0	@ read power control register
+	str	r2, [r0], #4
+
+	mrc	p15, 0, r2, c15, c0, 1	@ read diagnostic register
+	str	r2, [r0], #4
+
 	ldr	r3, =resume_with_mmu
 	bl	cpu_suspend
 
@@ -56,6 +65,14 @@ ENTRY(s3c_cpu_save)
 	b	early_wakeup
 
 resume_with_mmu:
+	adr	r0, sleep_save_misc
+
+	ldr	r1, [r0], #4
+	mcr	p15, 0, r1, c15, c0, 0	@ write power control register
+
+	ldr	r1, [r0], #4
+	mcr	p15, 0, r1, c15, c0, 1	@ write diagnostic register
+
 	mov	r0, #1
 
 early_wakeup:
@@ -71,6 +88,11 @@ early_wakeup:
 
 	.word	0x2bedf00d
 
+	 /* To save more cpu register */
+sleep_save_misc:
+	.long	0
+	.long	0
+
 	/*
 	 * s3c_cpu_resume
 	 *
-- 
1.7.1
