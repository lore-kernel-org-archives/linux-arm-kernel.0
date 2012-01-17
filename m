From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 16:47:54 +0000
Subject: [PATCH v3 1/3] ARM: vmlinux.lds.S: do not hardcode cacheline size as
 32 bytes
Message-ID: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linker script assumes a cacheline size of 32 bytes when aligning
the .data..cacheline_aligned and .data..percpu sections.

This patch updates the script to use L1_CACHE_BYTES, which should be set
to 64 on platforms that require it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index f76e755..1077e4f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -4,6 +4,7 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
@@ -181,7 +182,7 @@ SECTIONS
 	}
 #endif
 
-	PERCPU_SECTION(32)
+	PERCPU_SECTION(L1_CACHE_BYTES)
 
 #ifdef CONFIG_XIP_KERNEL
 	__data_loc = ALIGN(4);		/* location in binary */
@@ -212,8 +213,8 @@ SECTIONS
 #endif
 
 		NOSAVE_DATA
-		CACHELINE_ALIGNED_DATA(32)
-		READ_MOSTLY_DATA(32)
+		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
+		READ_MOSTLY_DATA(L1_CACHE_BYTES)
 
 		/*
 		 * The exception fixup table (might need resorting at runtime)
-- 
1.7.4.1
