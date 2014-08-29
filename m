From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Aug 2014 17:05:57 +0200
Subject: [PATCH 2/2] efi/arm64: use UEFI for system reset
In-Reply-To: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1409324757-12607-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If UEFI Runtime Services are available, they are preferred over direct
PSCI calls or other methods to reset the system.

For the reset case, we need to hook into machine_restart(), as the
arm_pm_restart function pointer may be overwritten by modules.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/process.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1309d64aa926..335a93da5eeb 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -177,6 +177,13 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
+	/*
+	 * arm_pm_restart is exported to modules, so the only way to supersede
+	 * it with efi_reboot() is to call it here.
+	 */
+	if (IS_ENABLED(CONFIG_EFI) && efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_reboot(REBOOT_WARM, NULL);
+
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
-- 
1.8.3.2
