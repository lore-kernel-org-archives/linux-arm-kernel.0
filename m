From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Wed, 27 Feb 2013 16:06:03 +0530
Subject: [PATCH v3] arm: plat-samsung: check processor type before cache
 restoration in resume
Message-ID: <1361961363-28412-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only cortex-a9 based samsung platforms have l2x0 cache controller. Hence check
the same before restoring the cache in resume.

This is needed for single kernel image.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
---
changes in v2:
        - check processor midr instead of checking all soc ids as
        suggested by Kukjin

changes in v3:
	- simplify by reading midr in assembly as per Russell

 arch/arm/plat-samsung/s5p-sleep.S |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index bdf6dad..6e15993 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -25,6 +25,9 @@
 #include <asm/asm-offsets.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define CPU_MASK	0xff0ffff0
+#define CPU_CORTEX_A9	0x410fc090
+
 /*
  *	 The following code is located into the .data section. This is to
  *	 allow l2x0_regs_phys to be accessed with a relative load while we
@@ -51,6 +54,12 @@
 
 ENTRY(s3c_cpu_resume)
 #ifdef CONFIG_CACHE_L2X0
+	mrc     p15, 0, r0, c0, c0, 0
+	ldr	r1, =CPU_MASK
+	and	r0, r0, r1
+	ldr	r1, =CPU_CORTEX_A9
+	cmp	r0, r1
+	bne	resume_l2on
 	adr	r0, l2x0_regs_phys
 	ldr	r0, [r0]
 	ldr	r1, [r0, #L2X0_R_PHY_BASE]
-- 
1.7.9.5
