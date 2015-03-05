From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  5 Mar 2015 13:51:11 +0100
Subject: [PATCH] arm64/efi: use UEFI ResetSystem() Runtime Service for system
 reset
Message-ID: <1425559871-3433-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If UEFI Runtime Services are available, the ResetSystem() service should
be preferred over direct PSCI calls or other methods to reset the system.
The reason is that the UpdateCapsule() UEFI Runtime Service, which is used
to perform firmware updates, relies on this.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
I sent roughly the same patch ~6 months ago, but at the time, we were still
waiting for the restart notifier call chain patches to land. Since that code
got rejected, I am proposing this again. Note that efi_enabled(x) always
evaluates to 'false' on !CONFIG_EFI.

This fixes reboot on my Seattle [although it doesn't make it any faster :-)]

 arch/arm64/kernel/process.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fde9923af859..a52bc0c316a8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -21,6 +21,7 @@
 #include <stdarg.h>
 
 #include <linux/compat.h>
+#include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -150,6 +151,14 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
+	/*
+	 * Prefer reboot via EFI if available, so that capsule updates [which
+	 * rely on UEFI's ResetSystem() being called with the return value of
+	 * UpdateCapsule()] have a chance of working as expected.
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_reboot(reboot_mode, NULL);
+
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
-- 
1.8.3.2
