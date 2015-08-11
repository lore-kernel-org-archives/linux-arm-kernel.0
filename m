From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 11 Aug 2015 09:16:43 -0700
Subject: [PATCH stable/3.14] ARM: sunxi: fix build for THUMB2_KERNEL
Message-ID: <1439309803-20163-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Building an SMP kernel for the sunxi platform with THUMB2 instructions
fails with this error at the moment:

headsmp.S:7: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'

Since the generic secondary_startup function already does
the same thing in a safe way, we can just drop the private
sunxi implementation and jump straight to secondary_startup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.14
(cherry picked from commit 1146b600044de64af0ef775025731eeef1fa2189)
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/include/asm/smp.h    | 1 +
 arch/arm/mach-sunxi/Makefile  | 2 +-
 arch/arm/mach-sunxi/headsmp.S | 9 ---------
 arch/arm/mach-sunxi/platsmp.c | 2 +-
 4 files changed, 3 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/headsmp.S

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 22a3b9b5d4a1..4157aec4e307 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -74,6 +74,7 @@ struct secondary_data {
 };
 extern struct secondary_data secondary_data;
 extern volatile int pen_release;
+extern void secondary_startup(void);
 
 extern int __cpu_disable(void);
 
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index d9397202d6ec..27b168f121a1 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
-obj-$(CONFIG_SMP) += platsmp.o headsmp.o
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
deleted file mode 100644
index a10d494fb37b..000000000000
--- a/arch/arm/mach-sunxi/headsmp.S
+++ /dev/null
@@ -1,9 +0,0 @@
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-        .section ".text.head", "ax"
-
-ENTRY(sun6i_secondary_startup)
-	msr	cpsr_fsxc, #0xd3
-	b	secondary_startup
-ENDPROC(sun6i_secondary_startup)
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 7b141d8342a1..0c7dbce033cc 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -82,7 +82,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 	spin_lock(&cpu_lock);
 
 	/* Set CPU boot address */
-	writel(virt_to_phys(sun6i_secondary_startup),
+	writel(virt_to_phys(secondary_startup),
 	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
 
 	/* Assert the CPU core in reset */
-- 
2.4.5
