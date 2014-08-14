From: dyoung@redhat.com (Dave Young)
Date: Thu, 14 Aug 2014 17:15:30 +0800
Subject: [PATCH 5/7] arm64/efi: do not enter virtual mode in case booting with
 efi=noruntime or noefi
In-Reply-To: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
Message-ID: <1408007731-15081-5-git-send-email-dyoung@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case efi runtime disabled via noefi kernel cmdline arm64_enter_virtual_mode
should error out.

At the same time move early_memunmap(memmap.map, mapsize) to the beginning of
the function or it will leak early mem.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/arm64/kernel/efi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 6ed0362..309fab1 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -392,11 +392,16 @@ static int __init arm64_enter_virtual_mode(void)
 		return -1;
 	}
 
+	mapsize = memmap.map_end - memmap.map;
+	if (efi_runtime_disabled()) {
+		early_memunmap(memmap.map, mapsize);
+		pr_info("EFI runtime services will be disabled.\n");
+		return -1;
+	}
+
 	pr_info("Remapping and enabling EFI services.\n");
 
 	/* replace early memmap mapping with permanent mapping */
-	mapsize = memmap.map_end - memmap.map;
-	early_memunmap(memmap.map, mapsize);
 	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
 						   mapsize);
 	memmap.map_end = memmap.map + mapsize;
-- 
1.8.3.1
