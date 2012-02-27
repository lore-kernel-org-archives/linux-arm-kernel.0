From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 27 Feb 2012 12:52:30 -0700
Subject: [PATCH] ARM: boot/compressed/misc.s: Include <linux/bug.h> to fix
 build break
Message-ID: <1330372350-6432-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commmit cf86c17 "kernel.h: doesn't explicitly use bug.h, so don't include
it." caused the following build failure on ARM:

  CC      arch/arm/boot/compressed/misc.o
In file included from arch/arm/boot/compressed/misc.c:28:0:
arch/arm/mach-tegra/include/mach/uncompress.h: In function 'arch_decomp_setup':
arch/arm/mach-tegra/include/mach/uncompress.h:125:2: error: implicit declaration of function 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

Include <linux/bug.h> to fix that.

This should probably be squashed into commit a3a3a1a "bug.h: add include
of it to various implicit C users".

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/compressed/misc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 8e2a8fc..30055be 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -18,6 +18,7 @@
 
 unsigned int __machine_arch_type;
 
+#include <linux/bug.h>
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
-- 
1.7.0.4
