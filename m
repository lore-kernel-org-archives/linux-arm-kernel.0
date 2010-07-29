From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 29 Jul 2010 13:45:35 +0800
Subject: [RFC] dove: fix __io() definition to use bus based offset
Message-ID: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] dove: fix __io() definition to use bus based offset

    __io() should be based on DOVE_PCIE0_IO_BUS_BASE instead of _PHYS_BASE,
    and use __typesafe_io() for consistency.

    Cc: Nicolas Pitre <nico@fluxnic.net>
    Cc: Lennert Buijtenhek <buytenh@wantstofly.org>
    Cc: Saeed Bishara <saeed@marvell.com>
    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/mach-dove/include/mach/io.h
b/arch/arm/mach-dove/include/mach/io.h
index 3b3e472..067435e 100644
--- a/arch/arm/mach-dove/include/mach/io.h
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -11,10 +11,9 @@

 #include "dove.h"

-#define IO_SPACE_LIMIT		0xffffffff
-
-#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
-				   DOVE_PCIE0_IO_VIRT_BASE))
-#define __mem_pci(a)		(a)
+#define IO_SPACE_LIMIT	0xffffffff
+#define __io(a)		__typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
+					    DOVE_PCIE0_IO_VIRT_BASE)
+#define __mem_pci(a)	(a)

 #endif
