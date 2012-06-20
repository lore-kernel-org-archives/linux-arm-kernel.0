From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jun 2012 08:06:50 +0200
Subject: [PATCH] ARM: Orion5x - Restore parts of io.h
Message-ID: <1340172410-11229-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4d5fc58dbe34b78157c05b319669bb3e064ba8bd remove the orion5x
io.h. Unfortunetely, this is still needed for the definition of
IO_SPACE_LIMIT which overrides the default 64K. All Orion based
systems have 1Mbyte of IO space per PCI[e] bus, and try to
request_resource() this size.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-orion5x/include/mach/io.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm/mach-orion5x/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..8fb7e4a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -588,6 +588,7 @@ config ARCH_ORION5X
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
 	select PLAT_ORION
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
new file mode 100644
index 0000000..f017fe2
--- /dev/null
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-orion5x/include/mach/io.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_IO_H
+#define __ASM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT		0xffffffff
+#define __io(a)			__typesafe_io(a)
+#endif
-- 
1.7.10
