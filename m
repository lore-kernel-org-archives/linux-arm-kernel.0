From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 25 Jun 2010 15:44:30 +0800
Subject: [PATCH 3/4] [ARM] Introduce USE_DEFAULT_IO_H to use default
	definitions in asm/io.h
In-Reply-To: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
References: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277451871-15319-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

For those machines that can just use the default definitions in asm/io.h,
there is no need to have a machine specific mach/io.h. Introduce an config
option for them.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig          |    3 +++
 arch/arm/include/asm/io.h |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..46c00a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -189,6 +189,9 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config USE_DEFAULT_IO_H
+	def_bool n
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c980156..179d317 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -97,7 +97,13 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /*
  * Now, pick up the machine-defined IO definitions
  */
+#ifndef CONFIG_USE_DEFAULT_IO_H
 #include <mach/io.h>
+#else
+#define IO_SPACE_LIMIT	0xffffffff
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+#endif
 
 /*
  *  IO port access primitives
-- 
1.7.1
