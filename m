From: semen.protsenko@linaro.org (Semen Protsenko)
Date: Thu, 14 Aug 2014 17:55:22 +0300
Subject: [PATCH] efi/arm64: store Runtime Services revision
Message-ID: <1408028122-1784-1-git-send-email-semen.protsenko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"efi" global data structure contains "runtime_version" field which must
be assigned in order to use it later in Runtime Services virtual calls
(virt_efi_* functions).

Before this patch "runtime_version" was unassigned (0), so each
Runtime Service virtual call that checks revision would fail.

Runtime Services revision being passed in UEFI system table from UEFI
to kernel (see efi_entry() function). In UEFI it's being stored at
MdePkg/Include/Uefi/UefiSpec.h as EFI_RUNTIME_SERVICES_REVISION.

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
