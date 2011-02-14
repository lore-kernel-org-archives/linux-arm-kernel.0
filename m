From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 14 Feb 2011 17:07:06 +0530
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
Message-ID: <mailman.146.1297859673.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The effect of cache sync operation is to drain the store
buffer and wait for all internal buffers to be empty. In
normal conditions, store buffer is able to merge the
normal memory writes within its 32-byte data buffers.
Due to this erratum present in r3p0, the effect of cache
sync operation on the store buffer still remains when
the operation completes. This means that the store buffer
is always asked to drain and this prevents it from merging
any further writes.

This can severely affect performance on the write traffic
esp. on Normal memory NC one.

The proposed workaround is to replace the normal offset of
cache sync operation(0x730) by another offset targeting an
unmapped PL310 register 0x740.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/Kconfig                           |   15 +++++++++++++++
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/mm/cache-l2x0.c                   |    6 ++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d5eb308..0b67a9f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1186,6 +1186,21 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption of the
 	  processor.
 
+config ARM_ERRATA_753970
+	bool "ARM errata: cache sync operation may be faulty"
+	depends on CACHE_PL310
+	help
+	  This option enables the workaround for the 753970 PL310 (r3p0) erratum.
+
+	  Under some condition the effect of cache sync operation on
+	  the store buffer still remains when the operation completes.
+	  This means that the store buffer is always asked to drain and
+	  this prevents it from merging any further writes. The workaround
+	  is to replace the normal offset of cache sync operation (0x730)
+	  by another offset targeting an unmapped PL310 register 0x740.
+	  This has the same effect as the cache sync operation: store buffer
+	  drain and waiting for all buffers empty.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 5aeec1e..16bd480 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -36,6 +36,7 @@
 #define L2X0_RAW_INTR_STAT		0x21C
 #define L2X0_INTR_CLEAR			0x220
 #define L2X0_CACHE_SYNC			0x730
+#define L2X0_DUMMY_REG			0x740
 #define L2X0_INV_LINE_PA		0x770
 #define L2X0_INV_WAY			0x77C
 #define L2X0_CLEAN_LINE_PA		0x7B0
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..f2ce38e 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -49,7 +49,13 @@ static inline void cache_wait(void __iomem *reg, unsigned long mask)
 static inline void cache_sync(void)
 {
 	void __iomem *base = l2x0_base;
+
+#ifdef CONFIG_ARM_ERRATA_753970
+	/* write to an unmmapped register */
+	writel_relaxed(0, base + L2X0_DUMMY_REG);
+#else
 	writel_relaxed(0, base + L2X0_CACHE_SYNC);
+#endif
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
-- 
1.7.0.4
