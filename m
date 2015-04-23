From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:10:01 -0700
Subject: [PATCH v2 8/9] ARM: vfp: Add vfp_disable for problematic platforms
In-Reply-To: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
References: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830602-10988-9-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms might not be able to fully utilize VFP when e.g: one CPU
out of two in a SMP complex lacks a VFP unit. Adding code to migrate
task to the CPU which has a VFP unit would be cumbersome and not
performant, instead, just add the ability to disable VFP.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/vfp.h |  4 ++++
 arch/arm/vfp/vfpmodule.c   | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index 03f9ca3cdfa4..22e414056a8c 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -91,4 +91,8 @@
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
 
+#ifndef __ASSEMBLY__
+void vfp_disable(void);
+#endif
+
 #endif /* __ASM_VFP_H */
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f6e4d56eda00..2a61e4b04600 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -445,6 +445,19 @@ static void vfp_enable(void *unused)
 	set_copro_access(access | CPACC_FULL(10) | CPACC_FULL(11));
 }
 
+/* Called by platforms on which we want to disable VFP because it may not be
+ * present on all CPUs within a SMP complex. Needs to be called prior to
+ * vfp_init().
+ */
+void vfp_disable(void)
+{
+	if (VFP_arch) {
+		pr_debug("%s: should be called prior to vfp_init\n", __func__);
+		return;
+	}
+	VFP_arch = 1;
+}
+
 #ifdef CONFIG_CPU_PM
 static int vfp_pm_suspend(void)
 {
-- 
2.1.0
