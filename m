From: hari.vyas@broadcom.com (Hari Vyas)
Date: Tue,  7 Aug 2018 16:33:48 +0530
Subject: [PATCH] arm64: fix for bad_mode() handler to always result in panic
Message-ID: <1533639828-19039-1-git-send-email-hari.vyas@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bad_mode() handler is called for invalid or undefined
instruction in el1 level or when irq,fiq,sync or error
situation happen in el1 or el0 level.

As per latest code, above abnormal situation may not result in
panic always due to die() call if user mode is determined at
that moment. That will just result in kill of current process
and panic will be avoided which it must not.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200637
Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 arch/arm64/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d45..716ee73 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -621,7 +621,6 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 		handler[reason], smp_processor_id(), esr,
 		esr_get_class_string(esr));
 
-	die("Oops - bad mode", regs, 0);
 	local_daif_mask();
 	panic("bad mode");
 }
-- 
1.9.1
