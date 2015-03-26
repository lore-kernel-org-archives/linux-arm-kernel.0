From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:28:51 +0900
Subject: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting a crash
 dump kernel
In-Reply-To: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike normal kexec case, we don't have a chance to reset EL2 context in
a generic way because bad exceptions may directly invoke crash_kexec().
(See die().)
Kvm is not useful on crash dump kernel anyway, and so we let it
un-initialized across rebooting.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/process.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d894d3e..9859f5c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/fpsimd.h>
+#include <asm/kexec.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
@@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
 	setup_mm_for_reboot();
 
 	cpu_soft_restart(virt_to_phys(cpu_reset),
-		is_hyp_mode_available(), addr);
+#ifdef CONFIG_KEXEC
+		!in_crash_kexec &&
+#endif
+		is_hyp_mode_available(),
+		addr);
 
 	/* Should never get here */
 	BUG();
-- 
1.7.9.5
