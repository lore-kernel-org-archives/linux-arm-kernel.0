From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Feb 2012 11:20:10 -0800
Subject: [PATCH] ARM: need to include asm/system.h in asm/processor.h
Message-ID: <1329333610-4474-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For files that include asm/processor.h but not asm/system.h:

arch/arm/mach-msm/include/mach/uncompress.h: In function 'putc':
arch/arm/mach-msm/include/mach/uncompress.h:48:3: error: implicit declaration of function 'smp_mb' [-Werror=implicit-function-declaration]

In this case, smp_mb() is from the cpu_relax() call in the msm putc().

It likely went uncaught when the uncompress.h change went in since the
defconfig didn't enable that code path, but later changes (e76f4750f4:
ARM: debug: arrange Kconfig options more logically) resulted in the
option being on for msm_defconfig and thus exposed it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/include/asm/processor.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index d7038fa..d27b071 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -22,6 +22,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
+#include <asm/system.h>
 
 #ifdef __KERNEL__
 #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \
-- 
1.7.9.209.gb6b3b
