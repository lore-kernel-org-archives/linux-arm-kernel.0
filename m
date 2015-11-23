From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Nov 2015 08:43:23 +0100
Subject: [PATCH 1/2] arm64/efi: deal with NULL return value of early_memremap()
In-Reply-To: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1448264604-19411-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NULL return value checks to two invocations of early_memremap()
in the UEFI init code. For the UEFI configuration tables, we just
warn since we have a better chance of being able to report the issue
in a way that can actually be noticed by a human operator if we don't
abort right away. For the UEFI memory map, however, all we can do is
panic() since we cannot proceed without a description of memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fc5508e0df57..186b9e119d4a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -127,7 +127,11 @@ static int __init uefi_init(void)
 	table_size = sizeof(efi_config_table_64_t) * efi.systab->nr_tables;
 	config_tables = early_memremap(efi_to_phys(efi.systab->tables),
 				       table_size);
-
+	if (config_tables == NULL) {
+		pr_warn("Unable to map EFI config table array.\n");
+		retval = -ENOMEM;
+		goto out;
+	}
 	retval = efi_config_parse_tables(config_tables, efi.systab->nr_tables,
 					 sizeof(efi_config_table_64_t), NULL);
 
@@ -209,6 +213,14 @@ void __init efi_init(void)
 			 PAGE_ALIGN(params.mmap_size + (params.mmap & ~PAGE_MASK)));
 	memmap.phys_map = params.mmap;
 	memmap.map = early_memremap(params.mmap, params.mmap_size);
+	if (memmap.map == NULL) {
+		/*
+		* If we are booting via UEFI, the UEFI memory map is the only
+		* description of memory we have, so there is little point in
+		* proceeding if we cannot access it.
+		*/
+		panic("Unable to map EFI memory map.\n");
+	}
 	memmap.map_end = memmap.map + params.mmap_size;
 	memmap.desc_size = params.desc_size;
 	memmap.desc_version = params.desc_ver;
-- 
1.9.1
