From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 14 Nov 2009 21:15:54 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure
Message-ID: <m3pr7kyi9x.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Guess nobody uses indirect PCI MMIO on IXP4xx - since 2.6.29:
arch/arm/mach-ixp4xx/include/mach/io.h:70: error: 'VMALLOC_START' undeclared

(and so on)

That's a part of commit 4b78a9ffabbb03af4032ff704689912298e19070, dated
2008-11-29. Perhaps we should get rid of this hack (indirect MMIO) if
nobody uses it? 64 MB of MMIO PCI space should be more than enough for
everyone :-)

Since VMALLOC_START wants high_memory, I guess the correct patch is
(attached) and that's what I'm going to use if nobody comes with a
better idea.

--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -14,7 +14,7 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #include <linux/bitops.h>
-
+#include <linux/mm.h>
 #include <mach/hardware.h>
 
 #define IO_SPACE_LIMIT 0x0000ffff

-- 
Krzysztof Halasa
