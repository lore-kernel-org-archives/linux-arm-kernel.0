From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  1 Jul 2016 17:01:30 +0200
Subject: [PATCH 1/2] efi: arm64: abort boot on pending SError
Message-ID: <1467385291-9880-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is the firmware's job to clear any pending SErrors before entering
the kernel. On UEFI, we can fail gracefully rather than panic during
early boot, so check for this condition in the stub.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index eae693eb3e91..c7e7396de876 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -20,7 +20,14 @@ extern bool __nokaslr;
 
 efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
 {
-	u64 tg;
+	u64 tg, isr;
+
+	/* check for a pending SError */
+	asm ("mrs %0, isr_el1" : "=r"(isr));
+	if (isr & BIT(8)) {
+		pr_efi_err(sys_table_arg, "Pending SError detected -- aborting\n");
+		return EFI_LOAD_ERROR;
+	}
 
 	/* UEFI mandates support for 4 KB granularity, no need to check */
 	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
-- 
2.7.4
