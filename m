From: kwangwoo.lee@sk.com (Kwangwoo Lee)
Date: Fri, 15 Jul 2016 11:46:21 +0900
Subject: [PATCH v3 2/3] arm64: mm: add mmio_flush_range() to support pmem
In-Reply-To: <1468550782-14454-1-git-send-email-kwangwoo.lee@sk.com>
References: <1468550782-14454-1-git-send-email-kwangwoo.lee@sk.com>
Message-ID: <1468550782-14454-3-git-send-email-kwangwoo.lee@sk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable pmem in arm64, mmio_flush_range() is required to build
successfully. If NVDIMM is used as blk mode, not pmem , it is called in
acpi_nfit_blk_single_io() via nd_blk_make_request() on read with
NFIT_BLK_READ_FLUSH flag.

The function cleans and invalidates the cache lines using the argument -
addr and size. Thus, it can be mapped with __flush_dcache_area().

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
 arch/arm64/Kconfig                  | 1 +
 arch/arm64/include/asm/cacheflush.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..12546ce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -15,6 +15,7 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_MMIO_FLUSH
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 903a94f..fba18e4 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -134,6 +134,8 @@ static inline void __flush_icache_all(void)
  */
 #define flush_icache_page(vma,page)	do { } while (0)
 
+#define mmio_flush_range(addr, size)	__flush_dcache_area(addr, size)
+
 /*
  * Not required on AArch64 (PIPT or VIPT non-aliasing D-cache).
  */
-- 
2.5.0
