From: robherring2@gmail.com (Rob Herring)
Date: Tue,  3 Apr 2012 22:11:52 -0500
Subject: [PATCH] ARM: fix __io macro for PCMCIA
Message-ID: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
broken as PCMCIA depends on __io() being just a cast. This needs a better
fix with a fixed i/o address mapping, but for now we just restore things
to the previous behavior.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
---
 arch/arm/include/asm/io.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index df0ac0b..00262a4 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -118,6 +118,8 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
  */
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
+#elif defined(CONFIG_PCCARD)
+#define __io(a)		__typesafe_io(a)
 #else
 #define __io(a)		({ (void)(a); __typesafe_io(0); })
 #endif
@@ -134,9 +136,9 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
  * readb() et.al. on such platforms.
  */
 #ifndef IO_SPACE_LIMIT
-#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
+#if defined(CONFIG_PCCARD)
 #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
-#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
+#elif defined(CONFIG_PCI) || defined(CONFIG_ISA)
 #define IO_SPACE_LIMIT ((resource_size_t)0xffff)
 #else
 #define IO_SPACE_LIMIT ((resource_size_t)0)
-- 
1.7.5.4
