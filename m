From: Russ.Dill@ti.com (Russ Dill)
Date: Tue, 17 Sep 2013 05:43:27 -0700
Subject: [RFC PATCH 01/11] asm-generic: io: Add exec versions of ioremap
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <1379421817-15759-2-git-send-email-Russ.Dill@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If code is to be copied into and area (such as SRAM) and run,
it needs to be marked as exec. Currently only an ARM version
of this exists.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/include/asm/io.h   | 2 ++
 include/asm-generic/iomap.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d070741..212d095 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -329,6 +329,8 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define ioremap_nocache(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE_WC)
+#define ioremap_exec(cookie,size)	__arm_ioremap_exec((cookie), (size), true)
+#define ioremap_exec_nocache(cookie,size) __arm_ioremap_exec((cookie), (size), false)
 #define iounmap				__arm_iounmap
 
 /*
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 6afd7d6..e72c451 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -66,6 +66,11 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wc ioremap_nocache
 #endif
 
+#ifndef ARCH_HAS_IOREMAP_EXEC
+#define ioremap_exec ioremap
+#define ioremap_exec_nocache ioremap_nocache
+#endif
+
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-- 
1.8.3.2
