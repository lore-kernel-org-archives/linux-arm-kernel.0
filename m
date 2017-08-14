From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Aug 2017 13:53:42 +0100
Subject: [PATCH 01/30] asm-generic: add .data.rel.ro sections to
 __ro_after_init
In-Reply-To: <20170814125411.22604-1-ard.biesheuvel@linaro.org>
References: <20170814125411.22604-1-ard.biesheuvel@linaro.org>
Message-ID: <20170814125411.22604-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running in PIC mode, the compiler will emit const structures
containing runtime relocatable quantities into .data.rel.ro.* sections,
so that the linker can be smart about placing them together in a segment
that is read-write initially, and is remapped read-only afterwards. This
is exactly what __ro_after_init aims to provide, so move these sections
together.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index da0be9a8d1de..d16537b0b102 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -261,7 +261,7 @@
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
 	VMLINUX_SYMBOL(__start_ro_after_init) = .;			\
-	*(.data..ro_after_init)						\
+	*(.data..ro_after_init .data.rel.ro.*)				\
 	VMLINUX_SYMBOL(__end_ro_after_init) = .;
 #endif
 
-- 
2.11.0
