From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 16:58:26 +0900
Subject: [PATCH 1/2] fixup! arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1445327907-23274-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, crash dump kernel won't be able to boot if a kvm
guest is running at crash. This is because we don't have any chance
to reset EL2 mode at crash and so "switch to EL2" in cpu_reset fails.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0edb7ee..d14dd05 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -271,7 +271,7 @@ static void soft_restart(unsigned long addr)
 {
 	setup_mm_for_reboot();
 	cpu_soft_restart(virt_to_phys(cpu_reset), addr,
-		is_hyp_mode_available());
+		(in_crash_kexec ? 0 : is_hyp_mode_available()));
 
 	BUG(); /* Should never get here. */
 }
-- 
1.7.9.5
