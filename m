From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:53:36 +0100
Subject: [PATCH 07/10] ARM: io: add a default IO_SPACE_LIMIT definition
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1QtawS-0007N5-Rz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a default IO_SPACE_LIMIT definition.  Explain the chosen value and
suggest why platforms would want to make it larger.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/io.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..ffb089d 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -110,6 +110,27 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #include <mach/io.h>
 
 /*
+ * This is the limit of PC card/PCI/ISA IO space, which is by default
+ * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
+ * zero to prevent ISA/PCI drivers claiming IO space (and potentially
+ * oopsing.)
+ *
+ * Only set this larger if you really need inb() et.al. to operate over
+ * a larger address space.  Note that SOC_COMMON ioremaps each sockets
+ * IO space area, and so inb() et.al. must be defined to operate as per
+ * readb() et.al. on such platforms.
+ */
+#ifndef IO_SPACE_LIMIT
+#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
+#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
+#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
+#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
+#else
+#define IO_SPACE_LIMIT ((resource_size_t)0)
+#endif
+#endif
+
+/*
  *  IO port access primitives
  *  -------------------------
  *
-- 
1.7.4.4
