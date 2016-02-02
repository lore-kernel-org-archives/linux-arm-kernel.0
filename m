From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  2 Feb 2016 18:56:41 +0100
Subject: [RFC PATCH 2/3] arm64: add the initrd region to the linear mapping
 explicitly
In-Reply-To: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454435802-7604-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of going out of our way to relocate the initrd if it turns out
to occupy memory that is not covered by the linear mapping, just add the
initrd to the linear mapping. This puts the burden on the bootloader to
pass initrd= and mem= options that are mutually consistent.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3b061e67bfe..5dd083161810 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -167,8 +167,20 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
+	if (initrd_start) {
+		u64 base = __virt_to_phys(initrd_start);
+		u64 size = initrd_end - initrd_start;
+
+		/*
+		 * The initrd needs to be accessible via the linear mapping. So
+		 * add the memory covered by the initrd explicitly, since it may
+		 * have been clipped or otherwise left out when we traversed the
+		 * DT memory nodes or the UEFI memory map.
+		 */
+		memblock_add(base, size);
+		memblock_clear_nomap(base, size);
+		memblock_reserve(base, size);
+	}
 #endif
 
 	early_init_fdt_scan_reserved_mem();
-- 
2.5.0
