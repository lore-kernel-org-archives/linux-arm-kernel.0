From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 27 Feb 2012 14:27:19 -0700
Subject: [PATCH] ARM: tegra: uncompress.h: Don't depend on kernel headers
Message-ID: <1330378039-21030-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following compile error:

  CC      arch/arm/boot/compressed/misc.o
In file included from arch/arm/boot/compressed/misc.c:28:0:
arch/arm/mach-tegra/include/mach/uncompress.h: In function 'arch_decomp_setup':
arch/arm/mach-tegra/include/mach/uncompress.h:125:2: error: implicit declaration of function 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

This is due to use of the ARRAY_SIZE() macro. Typically, this would be
solved by including <linux/bug.h>, but the compressor code isn't part of
the kernel, and so should not include kernel headers. Instead, define
the few macros the code uses directly, and in a way that doesn't depend
on <linux/bug.h>.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/uncompress.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index b066ba0..5a440f3 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -25,13 +25,15 @@
 #ifndef __MACH_TEGRA_UNCOMPRESS_H
 #define __MACH_TEGRA_UNCOMPRESS_H
 
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 
 #include <mach/iomap.h>
 #include <mach/irammap.h>
 
+#define BIT(x) (1 << (x))
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 #define DEBUG_UART_SHIFT 2
 
 volatile u8 *uart;
-- 
1.7.0.4
