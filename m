From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Mar 2016 11:18:49 +0200
Subject: [PATCH v4 1/4] ARM: reintroduce ioremap_cached() for creating cached
 I/O mappings
In-Reply-To: <1459415932-17852-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459415932-17852-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459415932-17852-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original ARM-only ioremap flavor 'ioremap_cached' has been renamed
to 'ioremap_cache' to align with other architectures, and subsequently
abused in generic code to map things like firmware tables in memory.
For that reason, there is currently an effort underway to deprecate
ioremap_cache, whose semantics are poorly defined, and which is typed
with an __iomem annotation that is inappropriate for mappings of ordinary
memory.

However, original users of ioremap_cached() used it in a context where
the I/O connotation is appropriate, and replacing those instances with
memremap() does not make sense. So let's revive ioremap_cached(), so
that we can change back those original users before we drop ioremap_cache
entirely in favor of memremap.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/io.h | 6 ++++++
 arch/arm/mm/ioremap.c     | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 485982084fe9..fb94de290edd 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -395,6 +395,12 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size);
 void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size);
 #define ioremap_cache ioremap_cache
 
+/*
+ * Do not use ioremap_cached in new code. Provided for the benefit of
+ * the pxa2xx-flash MTD driver only.
+ */
+void __iomem *ioremap_cached(resource_size_t res_cookie, size_t size);
+
 void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 #define ioremap_wc ioremap_wc
 #define ioremap_wt ioremap_wc
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 66a978d05958..d5350f6af089 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -380,11 +380,15 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size)
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size)
+	__alias(ioremap_cached);
+
+void __iomem *ioremap_cached(resource_size_t res_cookie, size_t size)
 {
 	return arch_ioremap_caller(res_cookie, size, MT_DEVICE_CACHED,
 				   __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_cache);
+EXPORT_SYMBOL(ioremap_cached);
 
 void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 {
-- 
2.5.0
