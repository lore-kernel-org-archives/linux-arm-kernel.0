From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 15 Feb 2011 16:48:03 +0530
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
Message-ID: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
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
 arch/arm/Kconfig         |   15 +++++++++++++++
 arch/arm/mm/cache-l2x0.c |    8 ++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d5eb308..f1946e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1186,6 +1186,21 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption of the
 	  processor.
 
+config ARM_ERRATA_753970
+	bool "ARM errata: cache sync operation may be faulty"
+	depends on CACHE_PL310
+	help
+	  This option enables the workaround for the 753970 PL310 erratum.
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
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..998d521 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -49,8 +49,16 @@ static inline void cache_wait(void __iomem *reg, unsigned long mask)
 static inline void cache_sync(void)
 {
 	void __iomem *base = l2x0_base;
+
+#ifdef ARM_ERRATA_753970
+#define L2X0_DUMMY_REG  0x740
+	/* write to an unmmapped register */
+	writel_relaxed(0, base + L2X0_DUMMY_REG);
+	cache_wait(base + L2X0_CACHE_SYNC, 1);
+#else
 	writel_relaxed(0, base + L2X0_CACHE_SYNC);
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
+#endif
 }
 
 static inline void l2x0_clean_line(unsigned long addr)
-- 
1.7.0.4
