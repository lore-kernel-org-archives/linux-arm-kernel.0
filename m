From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 23 May 2014 09:23:32 +0900
Subject: [PATCH RESEND] ARM: trusted_foundations: fix compile error on non-SMP
Message-ID: <1400804612-11876-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The setup_max_cpus variable is only defined if CONFIG_SMP is set. Add
a preprocessor condition to avoid the following compilation error if
CONFIG_SMP is not set:

    arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
    arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Hi Stephen,

This patch has been originally submitted through Russell's patch tracker,
where it has stayed untouched for ~3 weeks now. Considering that this
fixes a compilation error and should thus be made available quickly, and
that Tegra is the only user of Trusted Foundations, would you agree to take
it into your tree?

 arch/arm/include/asm/trusted_foundations.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index b5f7705..624e1d4 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -54,7 +54,9 @@ static inline void register_trusted_foundations(
 	 */
 	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
 	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
+#if IS_ENABLED(CONFIG_SMP)
 	setup_max_cpus = 0;
+#endif
 	cpu_idle_poll_ctrl(true);
 }
 
-- 
1.9.2
