From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:19 +0800
Subject: [PATCH 04/13] [ARM] Introduce ARCH_USES_DEFAULT_IO_H to use default
	asm/io.h
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-5-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For those machines that can just use the default definitions in asm/io.h,
there is no need to have a machine specific mach/io.h. Introduce an config
option for them.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig          |    3 +++
 arch/arm/include/asm/io.h |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 926e3fa..70221ef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,9 @@ config ARCH_USES_GETTIMEOFFSET
 	bool
 	default n
 
+config ARCH_USES_DEFAULT_IO_H
+	def_bool n
+
 config GENERIC_CLOCKEVENTS
 	bool
 
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c980156..c59bb28 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -97,7 +97,13 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /*
  * Now, pick up the machine-defined IO definitions
  */
+#ifndef CONFIG_ARCH_USES_DEFAULT_IO_H
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
