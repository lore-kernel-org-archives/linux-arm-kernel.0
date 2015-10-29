From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 14:40:57 +0100
Subject: [PATCH 1/3] arm64/efi: set EFI_MEMMAP bit only after mapping the
 memory map
In-Reply-To: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1446126059-25336-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an upcoming patch, we will wire up page_is_ram() to the UEFI memory
map, so make sure the EFI_MEMMAP bit accurately reflects whether the
UEFI memory map is available via its permanent mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 852eb927ea85..11b59e9a5954 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -191,8 +191,6 @@ static __init void reserve_regions(void)
 		if (efi_enabled(EFI_DBG))
 			pr_cont("\n");
 	}
-
-	set_bit(EFI_MEMMAP, &efi.flags);
 }
 
 void __init efi_init(void)
@@ -291,13 +289,6 @@ static int __init arm64_enable_runtime_services(void)
 		return -1;
 	}
 
-	if (efi_runtime_disabled()) {
-		pr_info("EFI runtime services will be disabled.\n");
-		return -1;
-	}
-
-	pr_info("Remapping and enabling EFI services.\n");
-
 	mapsize = memmap.map_end - memmap.map;
 	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
 						   mapsize);
@@ -307,6 +298,14 @@ static int __init arm64_enable_runtime_services(void)
 	}
 	memmap.map_end = memmap.map + mapsize;
 	efi.memmap = &memmap;
+	set_bit(EFI_MEMMAP, &efi.flags);
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return -1;
+	}
+
+	pr_info("Remapping and enabling EFI services.\n");
 
 	efi.systab = (__force void *)ioremap_cache(efi_system_table,
 						   sizeof(efi_system_table_t));
-- 
2.1.4
