From: dyoung@redhat.com (Dave Young)
Date: Mon, 18 Aug 2014 09:30:07 +0800
Subject: [PATCH 5/7 update] arm64/efi: do not enter virtual mode in case
 booting with efi=noruntime or noefi
In-Reply-To: <20140815150952.GY27466@arm.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007731-15081-5-git-send-email-dyoung@redhat.com>
 <20140815150952.GY27466@arm.com>
Message-ID: <20140818013007.GB3379@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In case efi runtime disabled via noefi kernel cmdline arm64_enter_virtual_mode
should error out.

At the same time move early_memunmap(memmap.map, mapsize) to the beginning of
the function or it will leak early mem.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/arm64/kernel/efi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 6ed0362..8f5db4a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -392,11 +392,16 @@ static int __init arm64_enter_virtual_mode(void)
 		return -1;
 	}
 
-	pr_info("Remapping and enabling EFI services.\n");
-
-	/* replace early memmap mapping with permanent mapping */
 	mapsize = memmap.map_end - memmap.map;
 	early_memunmap(memmap.map, mapsize);
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return -1;
+	}
+
+	pr_info("Remapping and enabling EFI services.\n");
+	/* replace early memmap mapping with permanent mapping */
 	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
 						   mapsize);
 	memmap.map_end = memmap.map + mapsize;
-- 
1.8.3.1
