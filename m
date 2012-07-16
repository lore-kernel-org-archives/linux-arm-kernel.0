From: robherring2@gmail.com (Rob Herring)
Date: Sun, 15 Jul 2012 22:53:55 -0500
Subject: [PATCH 2/3] ARM: use asm-generic version of kmap_types.h
In-Reply-To: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
Message-ID: <1342410836-6010-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

kmap_types.h is virtually unused now with the stack based kmap_atomic,
so we can just use the generic one. This does bump KM_TYPE_NR from 16
to 20, but there is still plenty of space left in the fixmap area.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/Kbuild       |    1 +
 arch/arm/include/asm/kmap_types.h |   33 ---------------------------------
 2 files changed, 1 insertion(+), 33 deletions(-)
 delete mode 100644 arch/arm/include/asm/kmap_types.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 8a7196c..c296c75 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += ioctl.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
+generic-y += kmap_types.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += msgbuf.h
diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
deleted file mode 100644
index e51b1e8..0000000
--- a/arch/arm/include/asm/kmap_types.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef __ARM_KMAP_TYPES_H
-#define __ARM_KMAP_TYPES_H
-
-/*
- * This is the "bare minimum".  AIO seems to require this.
- */
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_L1_CACHE,
-	KM_L2_CACHE,
-	KM_KDB,
-	KM_TYPE_NR
-};
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define KM_NMI		(-1)
-#define KM_NMI_PTE	(-1)
-#define KM_IRQ_PTE	(-1)
-#endif
-
-#endif
-- 
1.7.9.5
