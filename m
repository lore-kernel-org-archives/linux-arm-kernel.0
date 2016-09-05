From: james.morse@arm.com (James Morse)
Date: Mon,  5 Sep 2016 09:43:04 +0100
Subject: [PATCH] arm64: Drop generic xlate_dev_mem_{k,}ptr()
In-Reply-To: <1473064984-9494-1-git-send-email-james.morse@arm.com>
References: <1473064984-9494-1-git-send-email-james.morse@arm.com>
Message-ID: <1473064984-9494-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code that provides /dev/mem uses xlate_dev_mem_{k,}ptr() to
avoid making a cachable mapping of a non-cachable area on ia64.
On arm64 we do this via phys_mem_access_prot() instead, but provide
dummy versions of xlate_dev_mem_{k,}ptr().

These are the same as those in asm-generic/io.h, which we include from
asm/io.h

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/io.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9b6e408cfa51..ce20741b2cb5 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -184,17 +184,6 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
 #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #include <asm-generic/io.h>
 
 /*
-- 
2.8.0.rc3
