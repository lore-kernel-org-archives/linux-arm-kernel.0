From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Aug 2014 17:05:56 +0200
Subject: [PATCH 1/2] efi/arm64: use UEFI for system poweroff
Message-ID: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If UEFI Runtime Services are available, they are preferred over direct
PSCI calls or other methods to power down the system.

Enable the existing efi_reboot() code by supplying a definition of
efi_poweroff_required() that returns true.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e72f3100958f..78c85c4252bc 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -475,3 +475,11 @@ err_unmap:
 	return -1;
 }
 early_initcall(arm64_enter_virtual_mode);
+
+/*
+ * Override the weak definition in drivers/firmware/efi/reboot.c
+ */
+bool efi_poweroff_required(void)
+{
+	return true;
+}
-- 
1.8.3.2
