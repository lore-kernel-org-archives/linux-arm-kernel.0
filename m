From: semen.protsenko@linaro.org (Semen Protsenko)
Date: Fri, 15 Aug 2014 16:22:44 +0300
Subject: [PATCH v2] efi/arm64: store Runtime Services revision
Message-ID: <1408108964-28650-1-git-send-email-semen.protsenko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"efi" global data structure contains "runtime_version" field which must
be assigned in order to use it later in Runtime Services virtual calls
(virt_efi_* functions).

Before this patch "runtime_version" was unassigned (0), so each
Runtime Service virtual call that checks revision would fail.

Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/kernel/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e72f310..5dbb7bd 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -463,6 +463,8 @@ static int __init arm64_enter_virtual_mode(void)
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 
+	efi.runtime_version = efi.systab->hdr.revision;
+
 	return 0;
 
 err_unmap:
-- 
2.0.1
