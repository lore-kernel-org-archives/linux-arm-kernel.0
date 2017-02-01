From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  1 Feb 2017 21:46:25 +0900
Subject: [PATCH v31 06/12] arm64: hibernate: preserve kdump image around
 hibernation
In-Reply-To: <20170201124218.5823-1-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
Message-ID: <20170201124630.6016-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since arch_kexec_protect_crashkres() removes a mapping for crash dump
kernel memory, the loaded contents won't be preserved around hibernation.

In this patch, arch_kexec_(un)protect_crashkres() are additionally called
before/after hibernation so that the relevant region will be mapped again
and restored just as the other memory regions are.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/hibernate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index fe301cbcb442..111a849333ee 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -16,6 +16,7 @@
  */
 #define pr_fmt(x) "hibernate: " x
 #include <linux/cpu.h>
+#include <linux/kexec.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
@@ -289,6 +290,12 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region mapped */
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+#endif
+
 		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
@@ -300,6 +307,12 @@ int swsusp_arch_suspend(void)
 		if (el2_reset_needed())
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region unmapped */
+		if (kexec_crash_image)
+			arch_kexec_protect_crashkres();
+#endif
+
 		/*
 		 * Tell the hibernation core that we've just restored
 		 * the memory
-- 
2.11.0
