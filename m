From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  8 Nov 2011 10:28:39 +0000
Subject: [PATCH] at91: fix compile breakage with VMALLOC_END
Message-ID: <1320748119-16270-1-git-send-email-jamie.iles@mathembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jamie Iles <jamie@jamieiles.com>

VMALLOC_END is defined in terms of AT91_VIRT_BASE but this needs
mach/hardware.h for it's definition.

In file included from arch/arm/mach-at91/board-usb-a926x.c:26:0:
include/linux/mm.h: In function 'is_vmalloc_addr':
include/linux/mm.h:305:41: error: 'AT91_VIRT_BASE' undeclared (first use in this function)
include/linux/mm.h:305:41: note: each undeclared identifier is reported only once for each function it appears in

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

This is a bit more heavyweight than most of the other platforms,
but it's the simplest fix.

 arch/arm/mach-at91/include/mach/vmalloc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/vmalloc.h b/arch/arm/mach-at91/include/mach/vmalloc.h
index 8eb459f..8e4a1bd 100644
--- a/arch/arm/mach-at91/include/mach/vmalloc.h
+++ b/arch/arm/mach-at91/include/mach/vmalloc.h
@@ -21,6 +21,8 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
+#include <mach/hardware.h>
+
 #define VMALLOC_END		(AT91_VIRT_BASE & PGDIR_MASK)
 
 #endif
-- 
1.7.4.1
