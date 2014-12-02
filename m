From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 3 Dec 2014 02:49:24 +0900
Subject: [PATCH v2] arm64: Implement support for read-mostly sections
Message-ID: <3CC03DFB-6364-4AD9-8981-BB483DBFA85B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As putting data which is read mostly together, we can avoid
unnecessary cache line bouncing.

Other architectures, such as ARM and x86, adopted the same idea.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---

Changes since v1:
- move __read_mostly macro below #ifndef __ASSEMBLY__

 arch/arm64/include/asm/cache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 88cc05b..bde4499 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -32,6 +32,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+
 static inline int cache_line_size(void)
 {
 	u32 cwg = cache_type_cwg();
-- 
1.9.1
