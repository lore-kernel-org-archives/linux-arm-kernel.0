From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 09 Jul 2011 17:44:46 +0100
Subject: [PATCH 4/3] ARM: vfp: ensure that thread flushing works if preempted
In-Reply-To: <20110709163207.GN4812@n2100.arm.linux.org.uk>
References: <20110709163207.GN4812@n2100.arm.linux.org.uk>
Message-ID: <E1Qfae6-0006RC-2M@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent a preemption event causing the initialized VFP state being
overwritten by ensuring that the VFP hardware access is disabled
prior to starting initialization.  We can then do this in safety
while still allowing preemption to occur.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
And one last hole plugged to stop the beer barrel from emptying
prematurely.

 arch/arm/vfp/vfpmodule.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 08ff93f..0a96f71 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -89,24 +89,27 @@ static void vfp_thread_flush(struct thread_info *thread)
 	union vfp_state *vfp = &thread->vfpstate;
 	unsigned int cpu;
 
-	memset(vfp, 0, sizeof(union vfp_state));
-
-	vfp->hard.fpexc = FPEXC_EN;
-	vfp->hard.fpscr = FPSCR_ROUND_NEAREST;
-#ifdef CONFIG_SMP
-	vfp->hard.cpu = NR_CPUS;
-#endif
-
 	/*
 	 * Disable VFP to ensure we initialize it first.  We must ensure
-	 * that the modification of vfp_current_hw_state[] and hardware disable
-	 * are done for the same CPU and without preemption.
+	 * that the modification of vfp_current_hw_state[] and hardware
+	 * disable are done for the same CPU and without preemption.
+	 *
+	 * Do this first to ensure that preemption won't overwrite our
+	 * state saving should access to the VFP be enabled at this point.
 	 */
 	cpu = get_cpu();
 	if (vfp_current_hw_state[cpu] == vfp)
 		vfp_current_hw_state[cpu] = NULL;
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
 	put_cpu();
+
+	memset(vfp, 0, sizeof(union vfp_state));
+
+	vfp->hard.fpexc = FPEXC_EN;
+	vfp->hard.fpscr = FPSCR_ROUND_NEAREST;
+#ifdef CONFIG_SMP
+	vfp->hard.cpu = NR_CPUS;
+#endif
 }
 
 static void vfp_thread_exit(struct thread_info *thread)
-- 
1.7.4.4
