From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 16 Sep 2014 09:44:15 +0800
Subject: [PATCH v2] arm:extend __init_end to a page align address
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB49160B@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch change the __init_end address to a
page align address, so that free_initmem() can
free the whole .init section, because if the end
address is not page aligned, it will round down to
a page align address, then the tail unligned page
will not be freed.

Signed-off-by: wang <yalin.wang2010@gmail.com>
---
 arch/arm/kernel/vmlinux.lds.S     | 2 +-
 arch/arm64/kernel/vmlinux.lds.S   | 2 +-
 include/asm-generic/vmlinux.lds.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 6f57cb9..8e95aa4 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -219,8 +219,8 @@ SECTIONS
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #else
-	__init_end = .;
 	. = ALIGN(THREAD_SIZE);
+	__init_end = .;
 	__data_loc = .;
 #endif
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 97f0c04..edf8715 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -97,9 +97,9 @@ SECTIONS
 
 	PERCPU_SECTION(64)
 
+	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 
-	. = ALIGN(PAGE_SIZE);
 	_data = .;
 	_sdata = .;
 	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5ba0360..aa70cbd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -40,6 +40,8 @@
  * }
  *
  * [__init_begin, __init_end] is the init section that may be freed after init
+ * 	// __init_begin and __init_end should be page aligned, so that we can
+ *	// free the whole .init memory
  * [_stext, _etext] is the text section
  * [_sdata, _edata] is the data section
  *
-- 
2.1.0
