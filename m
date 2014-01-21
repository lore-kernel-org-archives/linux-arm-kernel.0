From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 21 Jan 2014 19:10:13 +0900
Subject: [PATCH 2/5] ARM: trusted_foundations: fallback when TF support is
 missing
In-Reply-To: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1390299016-14105-3-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Trusted Foundations is detected as present on the system, but
Trusted Foundations support is not built into the kernel, the kernel
used to issue a panic very early during boot, leaving little clue to the
user as to what is going wrong.

It turns out that even without TF support built-in, the kernel can boot
on a TF-enabled system provided that SMP and cpuidle are disabled. This
patch does this and continue booting on one CPU, leaving the user with a
usable (however degraded) system.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/include/asm/trusted_foundations.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 997862fd5d77..b5f7705abcb0 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -30,6 +30,8 @@
 #include <linux/printk.h>
 #include <linux/bug.h>
 #include <linux/of.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
 
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
@@ -47,10 +49,13 @@ static inline void register_trusted_foundations(
 				   struct trusted_foundations_platform_data *pd)
 {
 	/*
-	 * If we try to register TF, this means the system needs it to continue.
-	 * Its absence if thus a fatal error.
+	 * If the system requires TF and we cannot provide it, continue booting
+	 * but disable features that cannot be provided.
 	 */
-	panic("No support for Trusted Foundations, stopping...\n");
+	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
+	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
+	setup_max_cpus = 0;
+	cpu_idle_poll_ctrl(true);
 }
 
 static inline void of_register_trusted_foundations(void)
-- 
1.8.5.3
