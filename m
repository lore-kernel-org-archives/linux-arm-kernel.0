From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 11 Feb 2016 17:48:01 +0100
Subject: [PATCH v2 2/3] arm64: defer __va translation of initrd_start and
 initrd_end
In-Reply-To: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455209282-9596-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 66f51676a095 ("arm64: allow kernel Image to be loaded anywhere in
physical memory") defers the assignment of memstart_addr to the point where
all memory has been discovered and possibly clipped based on the size of
the linear region and the presence of a mem= command line parameter.

However, this results in __va() translations that have been performed up
to this point to have been carried out with a preliminary, incorrect value
of memstart_addr, and these values need to be fixed up. So wire up the
generic support to declare the initrd addresses, and implement it without
__va() translations, and perform the translation after memstart_addr has
been assigned.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3a9fc46cbf80..eff4751f8761 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,12 +61,18 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
+		initrd_start = start;
+		initrd_end = start + size;
 	}
 	return 0;
 }
 early_param("initrd", early_initrd);
+
+void __early_init_dt_declare_initrd(unsigned long start, unsigned long end)
+{
+	initrd_start = start;
+	initrd_end = end;
+}
 #endif
 
 /*
@@ -213,8 +219,13 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
+	if (initrd_start) {
+		memblock_reserve(initrd_start, initrd_end - initrd_start);
+
+		/* the generic initrd code expects virtual addresses */
+		initrd_start = __phys_to_virt(initrd_start);
+		initrd_end = __phys_to_virt(initrd_end);
+	}
 #endif
 
 	early_init_fdt_scan_reserved_mem();
-- 
2.5.0
