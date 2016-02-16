From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Feb 2016 13:52:41 +0100
Subject: [PATCH v6sub1 10/11] arm64: defer __va translation of initrd_start
 and initrd_end
In-Reply-To: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455627162-31600-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before deferring the assignment of memstart_addr in a subsequent patch, to
the moment where all memory has been discovered and possibly clipped based
on the size of the linear region and the presence of a mem= command line
parameter, we need to ensure that memstart_addr is not used to perform __va
translations before it is assigned.

One such use is in the generic early DT discovery of the initrd location,
which is recorded as a virtual address in the globals initrd_start and
initrd_end. So wire up the generic support to declare the initrd addresses,
and implement it without __va() translations, and perform the translation
after memstart_addr has been assigned.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h |  8 ++++++++
 arch/arm64/mm/init.c            | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 4388651d1f0d..18b7e77c7495 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -121,6 +121,14 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
 #ifndef __ASSEMBLY__
 
 extern phys_addr_t		memstart_addr;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1d627cd8121c..52d1fc465885 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -59,8 +59,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
+		initrd_start = start;
+		initrd_end = start + size;
 	}
 	return 0;
 }
@@ -168,8 +168,13 @@ void __init arm64_memblock_init(void)
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
