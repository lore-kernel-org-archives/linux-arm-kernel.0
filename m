From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 16:21:49 +0200
Subject: [PATCH 06/10] arm64/efi: use UEFI memory map unconditionally if
 available
In-Reply-To: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413987713-30528-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems that boot via UEFI, all memory nodes are deleted from the
device tree, and instead, the size and location of system RAM is derived
from the UEFI memory map. This is handled by reserve_regions, which not only
reserves parts of memory that UEFI declares as reserved, but also installs
the memblocks that cover the remaining usable memory.

Currently, reserve_regions() is only called if uefi_init() succeeds.
However, it does not actually depend on anything that uefi_init() does,
and not calling reserve_regions() results in a broken boot, so it is
better to just call it unconditionally.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 51522ab0c6da..4cec21b1ecdd 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -313,8 +313,7 @@ void __init efi_init(void)
 	memmap.desc_size = params.desc_size;
 	memmap.desc_version = params.desc_ver;
 
-	if (uefi_init() < 0)
-		return;
+	WARN_ON(uefi_init() < 0);
 
 	reserve_regions();
 }
@@ -374,15 +373,13 @@ static int __init arm64_enter_virtual_mode(void)
 	int count = 0;
 	unsigned long flags;
 
-	if (!efi_enabled(EFI_BOOT)) {
-		pr_info("EFI services will not be available.\n");
-		return -1;
-	}
+	if (!efi_enabled(EFI_MEMMAP))
+		return 0;
 
 	mapsize = memmap.map_end - memmap.map;
 	early_memunmap(memmap.map, mapsize);
 
-	if (efi_runtime_disabled()) {
+	if (!efi_enabled(EFI_BOOT) || efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return -1;
 	}
-- 
1.8.3.2
