From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:14 -0600
Subject: [PATCH v3 02/30] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

We have compile time over-ride of ioremap and iounmap, but an run-time
override is needed for multi-platform builds.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/io.h |    8 ++++++--
 arch/arm/mm/ioremap.c     |    6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 9275828..9bf9d00 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -264,9 +264,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * Documentation/io-mapping.txt.
  *
  */
+
+extern void __iomem * (*arch_ioremap)(unsigned long, size_t, unsigned int);
+extern void (*arch_iounmap)(volatile void __iomem *);
+
 #ifndef __arch_ioremap
-#define __arch_ioremap			__arm_ioremap
-#define __arch_iounmap			__iounmap
+#define __arch_ioremap			arch_ioremap
+#define __arch_iounmap			arch_iounmap
 #endif
 
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 80632e8..d164dea 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -314,6 +314,9 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
+void __iomem * (*arch_ioremap)(unsigned long , size_t , unsigned int ) = __arm_ioremap;
+EXPORT_SYMBOL(arch_ioremap);
+
 /*
  * Remap an arbitrary physical address space into the kernel virtual
  * address space as memory. Needed when the kernel wants to execute
@@ -370,3 +373,6 @@ void __iounmap(volatile void __iomem *io_addr)
 	vunmap(addr);
 }
 EXPORT_SYMBOL(__iounmap);
+
+void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
+EXPORT_SYMBOL(arch_iounmap);
-- 
1.7.5.4
