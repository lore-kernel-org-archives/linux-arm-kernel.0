From: dhowells@redhat.com (David Howells)
Date: Thu, 15 Mar 2012 21:33:45 +0000
Subject: [PATCH] Fixes after disintegration of asm/system.h for ARM [ver #2]
Message-ID: <20120315213345.31434.26037.stgit@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Russell King <linux@arm.linux.org.uk>
cc: linux-arm-kernel at lists.infradead.org
---

 arch/arm/include/asm/barrier.h               |    6 ++++++
 arch/arm/include/asm/domain.h                |    2 ++
 arch/arm/include/asm/io.h                    |    1 +
 arch/arm/include/asm/processor.h             |    1 -
 arch/arm/include/asm/system_misc.h           |    5 -----
 arch/arm/kernel/kprobes-common.c             |    1 +
 arch/arm/kernel/machine_kexec.c              |    1 +
 arch/arm/kernel/tcm.c                        |    1 +
 arch/arm/kernel/thumbee.c                    |    1 +
 arch/arm/mach-at91/at91cap9.c                |    2 ++
 arch/arm/mach-at91/at91rm9200.c              |    1 +
 arch/arm/mach-at91/at91sam9260.c             |    1 +
 arch/arm/mach-at91/at91sam9261.c             |    1 +
 arch/arm/mach-at91/at91sam9263.c             |    1 +
 arch/arm/mach-at91/at91sam9g45.c             |    1 +
 arch/arm/mach-at91/at91sam9rl.c              |    1 +
 arch/arm/mach-at91/include/mach/system_rev.h |    2 ++
 arch/arm/mach-clps711x/common.c              |    1 +
 arch/arm/mach-davinci/board-da850-evm.c      |    1 +
 arch/arm/mach-ebsa110/core.c                 |    1 +
 arch/arm/mach-footbridge/common.c            |    1 +
 arch/arm/mach-footbridge/dc21285-timer.c     |    1 +
 arch/arm/mach-footbridge/netwinder-hw.c      |    1 +
 arch/arm/mach-imx/mach-imx6q.c               |    1 +
 arch/arm/mach-imx/mach-mx51_efikamx.c        |    1 +
 arch/arm/mach-imx/mach-mx51_efikasb.c        |    1 +
 arch/arm/mach-ks8695/time.c                  |    1 +
 arch/arm/mach-mmp/common.c                   |    1 +
 arch/arm/mach-mmp/pxa168.c                   |    1 +
 arch/arm/mach-mxs/system.c                   |    1 +
 arch/arm/mach-omap1/id.c                     |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c   |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 arch/arm/mach-omap2/pm24xx.c                 |    1 +
 arch/arm/mach-omap2/pm34xx.c                 |    1 +
 arch/arm/mach-omap2/pm44xx.c                 |    1 +
 arch/arm/mach-orion5x/common.c               |    1 +
 arch/arm/mach-orion5x/dns323-setup.c         |    1 +
 arch/arm/mach-pnx4008/core.c                 |    1 +
 arch/arm/mach-pxa/cm-x300.c                  |    1 +
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    1 +
 arch/arm/mach-pxa/magician.c                 |    1 +
 arch/arm/mach-pxa/reset.c                    |    1 +
 arch/arm/mach-pxa/viper.c                    |    1 +
 arch/arm/mach-pxa/zeus.c                     |    1 +
 arch/arm/mach-rpc/riscpc.c                   |    1 +
 arch/arm/mach-s3c2410/s3c2410.c              |    1 +
 arch/arm/mach-s3c2412/s3c2412.c              |    1 +
 arch/arm/mach-s3c2416/s3c2416.c              |    1 +
 arch/arm/mach-s3c2440/s3c244x.c              |    1 +
 arch/arm/mach-s3c2443/s3c2443.c              |    1 +
 arch/arm/mach-s3c64xx/common.c               |    1 +
 arch/arm/mach-s5p64x0/common.c               |    1 +
 arch/arm/mach-s5pc100/common.c               |    1 +
 arch/arm/mach-sa1100/generic.c               |    1 +
 arch/arm/mach-shmobile/include/mach/system.h |    2 ++
 arch/arm/mach-shmobile/suspend.c             |    1 +
 arch/arm/mach-w90x900/cpu.c                  |    1 +
 arch/arm/mm/alignment.c                      |    1 +
 arch/arm/mm/fault.c                          |    2 ++
 arch/arm/mm/mmu.c                            |    1 +
 arch/arm/plat-iop/restart.c                  |    1 +
 arch/arm/plat-mxc/system.c                   |    1 +
 arch/arm/plat-s3c24xx/cpu.c                  |    1 +
 arch/arm/plat-spear/restart.c                |    1 +
 arch/arm/vfp/vfpmodule.c                     |    1 +
 drivers/cpuidle/cpuidle.c                    |    1 +
 drivers/net/ethernet/8390/etherh.c           |    1 +
 drivers/tty/serial/21285.c                   |    1 +
 drivers/watchdog/wdt285.c                    |    1 +
 70 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 81b24b6..408e392 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -1,6 +1,11 @@
 #ifndef __ASM_BARRIER_H
 #define __ASM_BARRIER_H
 
+#ifdef __ASSEMBLY__
+#error do not include asm/barrier.h from assembly
+#endif
+
+#define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 #if __LINUX_ARM_ARCH__ >= 7 ||		\
 	(__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
@@ -36,6 +41,7 @@
 #ifdef CONFIG_ARCH_HAS_BARRIERS
 #include <mach/barriers.h>
 #elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
+#include <asm/outercache.h>
 #define mb()		do { dsb(); outer_sync(); } while (0)
 #define rmb()		dsb()
 #define wmb()		mb()
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 489f160..3d22204 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -10,7 +10,9 @@
 #ifndef __ASM_PROC_DOMAIN_H
 #define __ASM_PROC_DOMAIN_H
 
+#ifndef __ASSEMBLY__
 #include <asm/barrier.h>
+#endif
 
 /*
  * Domain numbers
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 0a34bf7..bae7eb6 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -98,6 +98,7 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 
 /* IO barriers */
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
+#include <asm/barrier.h>
 #define __iormb()		rmb()
 #define __iowmb()		wmb()
 #else
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index cb8d638..ce280b8 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -22,7 +22,6 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
-#include <asm/system.h>
 
 #ifdef __KERNEL__
 #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \
diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index f5cf1e8..ccda6c2 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -7,9 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 
-#include <asm/outercache.h>
-
-extern int __pure cpu_architecture(void);
 extern void cpu_init(void);
 
 void soft_restart(unsigned long);
@@ -23,8 +20,6 @@ extern void (*arm_pm_restart)(char str, const char *cmd);
 
 extern unsigned int user_debug;
 
-#define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
-
 extern void disable_hlt(void);
 extern void enable_hlt(void);
 
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index a5394fb4..18a7628 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <asm/system_info.h>
 
 #include "kprobes.h"
 
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index e097865..5699598 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-types.h>
+#include <asm/system_misc.h>
 
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 01ec453..30ae6bb 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -16,6 +16,7 @@
 #include <asm/cputype.h>
 #include <asm/mach/map.h>
 #include <asm/memory.h>
+#include <asm/system_info.h>
 #include "tcm.h"
 
 static struct gen_pool *tcm_pool;
diff --git a/arch/arm/kernel/thumbee.c b/arch/arm/kernel/thumbee.c
index 9cb7aac..37bc322 100644
--- a/arch/arm/kernel/thumbee.c
+++ b/arch/arm/kernel/thumbee.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 
 #include <asm/thread_notify.h>
+#include <asm/system_info.h>
 
 /*
  * Access to the ThumbEE Handler Base register
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index a42edc2..fc460e9 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -17,6 +17,8 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_info.h>
+#include <asm/system_misc.h>
 
 #include <mach/cpu.h>
 #include <mach/at91cap9.h>
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 99c3174..413c027 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/at91rm9200.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d4036ba..79f5718 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 023c2ff..62818b9 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91_pmc.h>
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 75e876c..722ee08 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 1cb6a96..47e8fdb 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -16,6 +16,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d2c91a8..7ae4993 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -14,6 +14,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
diff --git a/arch/arm/mach-at91/include/mach/system_rev.h b/arch/arm/mach-at91/include/mach/system_rev.h
index ec164a4..ef79a9a 100644
--- a/arch/arm/mach-at91/include/mach/system_rev.h
+++ b/arch/arm/mach-at91/include/mach/system_rev.h
@@ -7,6 +7,8 @@
 #ifndef __ARCH_SYSTEM_REV_H__
 #define __ARCH_SYSTEM_REV_H__
 
+#include <asm/system_info.h>
+
 /*
  * board revision encoding
  * mach specific
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index ab1711b..ac84f92 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -37,6 +37,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/clps7111.h>
+#include <asm/system_misc.h>
 
 /*
  * This maps the generic CLPS711x registers
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index d508890..5d9afd8 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/wl12xx.h>
 
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index e43dcc0..0c40e59 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -22,6 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/system_misc.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 41978ee..3e6aaa6 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -21,6 +21,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
+#include <asm/system_misc.h>
 #include <asm/hardware/dec21285.h>
 
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 121ad1d..3b54196 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -14,6 +14,7 @@
 
 #include <asm/hardware/dec21285.h>
 #include <asm/mach/time.h>
+#include <asm/system_info.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 80a1c5c..cac9f67 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -17,6 +17,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
+#include <asm/system_misc.h>
 
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index c257281..527b697 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <asm/system_misc.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-imx/mach-mx51_efikamx.c b/arch/arm/mach-imx/mach-mx51_efikamx.c
index 3a5ed2d..586e9f8 100644
--- a/arch/arm/mach-imx/mach-mx51_efikamx.c
+++ b/arch/arm/mach-imx/mach-mx51_efikamx.c
@@ -33,6 +33,7 @@
 #include <mach/iomux-mx51.h>
 
 #include <asm/setup.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-imx/mach-mx51_efikasb.c b/arch/arm/mach-imx/mach-mx51_efikasb.c
index ea5f65b..24aded9 100644
--- a/arch/arm/mach-imx/mach-mx51_efikasb.c
+++ b/arch/arm/mach-imx/mach-mx51_efikasb.c
@@ -36,6 +36,7 @@
 #include <mach/iomux-mx51.h>
 
 #include <asm/setup.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index 37dfcd5..ec783a3 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/time.h>
+#include <asm/system_misc.h>
 
 #include <mach/regs-timer.h>
 #include <mach/regs-irq.h>
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 062b5b9..c868a6c 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 
 #include <asm/page.h>
+#include <asm/system_misc.h>
 #include <asm/mach/map.h>
 #include <mach/addr-map.h>
 #include <mach/cputype.h>
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index ada1213..d5c9a2e 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 
+#include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/cputype.h>
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
index 32fe638..30042e2 100644
--- a/arch/arm/mach-mxs/system.c
+++ b/arch/arm/mach-mxs/system.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 
 #include <asm/proc-fns.h>
+#include <asm/system_misc.h>
 
 #include <mach/mxs.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..b3f3363 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <asm/system_info.h>
 #include <plat/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index a0b851a..c524c9d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -38,6 +38,7 @@
 #include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index acb4e77..2bf84fd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -25,6 +25,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
 #include <linux/power/isp1704_charger.h>
+#include <asm/system_info.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 23de98d..730bb00 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -34,6 +34,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
+#include <asm/system_misc.h>
 
 #include <mach/irqs.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..64d95e6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -31,6 +31,7 @@
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
+#include <asm/system_misc.h>
 
 #include <plat/sram.h>
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c264ef7..a73e325 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <asm/system_misc.h>
 
 #include "common.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 5dad38e..2448166 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -21,6 +21,7 @@
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
+#include <asm/system_misc.h>
 #include <asm/timex.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 91b0f47..f4f6ad2d 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -29,6 +29,7 @@
 #include <linux/ata_platform.h>
 #include <linux/phy.h>
 #include <linux/marvell_phy.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index 977538f..be4c928 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/system_misc.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 4b981b8..125ae08 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -55,6 +55,7 @@
 #include <mach/pxa3xx-u2d.h>
 
 #include <asm/mach/map.h>
+#include <asm/system_info.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 2b8ca0d..2075a69 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -20,6 +20,7 @@
 #include <asm/sizes.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
+#include <asm/system_info.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/mfp-pxa300.h>
 #include <mach/colibri.h>
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 3d6baf9..264cd89 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/pxa-i2c.h>
 
 #include <mach/hardware.h>
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index c8497b0..b452889 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -9,6 +9,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <asm/proc-fns.h>
+#include <asm/system_misc.h>
 
 #include <mach/regs-ost.h>
 #include <mach/reset.h>
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 023d6ca..7a3d342 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -57,6 +57,7 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/sizes.h>
+#include <asm/system_info.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index a4dd1c3..4c5ae58 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -34,6 +34,7 @@
 #include <asm/suspend.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_info.h>
 
 #include <mach/pxa27x.h>
 #include <mach/regs-uart.h>
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index 3d44a59..e958597 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -28,6 +28,7 @@
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
+#include <asm/system_misc.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
index 061b6bb..a3c5cb0 100644
--- a/arch/arm/mach-s3c2410/s3c2410.c
+++ b/arch/arm/mach-s3c2410/s3c2410.c
@@ -30,6 +30,7 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include <plat/cpu-freq.h>
 
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index aff6e85..100ef1c 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -31,6 +31,7 @@
 #include <mach/hardware.h>
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/idle.h>
 
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 5287d28..ed67ec9 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -43,6 +43,7 @@
 #include <mach/hardware.h>
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/idle.h>
 #include <mach/regs-s3c2443-clock.h>
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index d15852f..6f74118 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index b9deaeb..9318847 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -29,6 +29,7 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/regs-s3c2443-clock.h>
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index bee7dcd..b313380 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/vic.h>
+#include <asm/system_misc.h>
 
 #include <mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 52b89a3..a9d1ad4 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -30,6 +30,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index c909573..dff11c3 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -30,6 +30,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 17caece..9ad9469 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
index 956ac18..9204270 100644
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ b/arch/arm/mach-shmobile/include/mach/system.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
+#include <asm/system_misc.h>
+
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
diff --git a/arch/arm/mach-shmobile/suspend.c b/arch/arm/mach-shmobile/suspend.c
index 12d760c..4d1b86a 100644
--- a/arch/arm/mach-shmobile/suspend.c
+++ b/arch/arm/mach-shmobile/suspend.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <asm/io.h>
+#include <asm/system_misc.h>
 
 static int shmobile_suspend_default_enter(suspend_state_t suspend_state)
 {
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 9a06619..9e4dd8b 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -28,6 +28,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/irq.h>
+#include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-serial.h>
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9107231..8b05694 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -25,6 +25,7 @@
 #include <asm/cp15.h>
 #include <asm/system_info.h>
 #include <asm/unaligned.h>
+#include <asm/system_info.h>
 
 #include "fault.h"
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5bdff5c..5a0a0b7 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -25,6 +25,8 @@
 #include <asm/system_misc.h>
 #include <asm/system_info.h>
 #include <asm/tlbflush.h>
+#include <asm/system_misc.h>
+#include <asm/system_info.h>
 
 #include "fault.h"
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cd439c1..a27555a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -28,6 +28,7 @@
 #include <asm/highmem.h>
 #include <asm/system_info.h>
 #include <asm/traps.h>
+#include <asm/system_info.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/plat-iop/restart.c b/arch/arm/plat-iop/restart.c
index 6a85a0c..33fa699 100644
--- a/arch/arm/plat-iop/restart.c
+++ b/arch/arm/plat-iop/restart.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 #include <asm/hardware/iop3xx.h>
+#include <asm/system_misc.h>
 #include <mach/hardware.h>
 
 void iop3xx_restart(char mode, const char *cmd)
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 8f12074..c195d6d 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -25,6 +25,7 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
+#include <asm/system_misc.h>
 #include <asm/proc-fns.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 21f1fda..ded6431 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -34,6 +34,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
+#include <asm/system_info.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/plat-spear/restart.c
index 2b4e3d8..16f203e 100644
--- a/arch/arm/plat-spear/restart.c
+++ b/arch/arm/plat-spear/restart.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 #include <linux/io.h>
+#include <asm/system_misc.h>
 #include <asm/hardware/sp810.h>
 #include <mach/hardware.h>
 #include <mach/generic.h>
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index d89068f..9f50997 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
+#include <asm/system_info.h>
 
 #include "vfpinstr.h"
 #include "vfp.h"
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 59f4261..654076e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -19,6 +19,7 @@
 #include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <trace/events/power.h>
+#include <asm/system_misc.h>
 
 #include "cpuidle.h"
 
diff --git a/drivers/net/ethernet/8390/etherh.c b/drivers/net/ethernet/8390/etherh.c
index 48c4948..a45b0d8 100644
--- a/drivers/net/ethernet/8390/etherh.c
+++ b/drivers/net/ethernet/8390/etherh.c
@@ -48,6 +48,7 @@
 #include <asm/system.h>
 #include <asm/ecard.h>
 #include <asm/io.h>
+#include <asm/system_info.h>
 
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 1b37626..6d0ddbc 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -16,6 +16,7 @@
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
 #include <asm/hardware/dec21285.h>
 #include <mach/hardware.h>
 
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index f551356..658a36d 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -32,6 +32,7 @@
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
 #include <asm/hardware/dec21285.h>
 
 /*
