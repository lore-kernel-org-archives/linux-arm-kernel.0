From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:53:51 +0000
Subject: [PATCH 41/41] ARM: restart: remove the now empty arch_reset()
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the now empty arch_reset() from all the mach/system.h includes,
and remove its callsite.  Remove arm_machine_restart() as this function
no longer does anything useful.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/system.h                  |    1 -
 arch/arm/kernel/process.c                      |   10 ++--------
 arch/arm/mach-at91/include/mach/system.h       |    4 ----
 arch/arm/mach-clps711x/include/mach/system.h   |    4 ----
 arch/arm/mach-cns3xxx/include/mach/system.h    |    4 ----
 arch/arm/mach-dove/include/mach/system.h       |    5 -----
 arch/arm/mach-ebsa110/include/mach/system.h    |    4 ----
 arch/arm/mach-ep93xx/include/mach/system.h     |    4 ----
 arch/arm/mach-footbridge/include/mach/system.h |    4 ----
 arch/arm/mach-h720x/include/mach/system.h      |    4 ----
 arch/arm/mach-highbank/include/mach/system.h   |    4 ----
 arch/arm/mach-integrator/include/mach/system.h |    4 ----
 arch/arm/mach-iop13xx/include/mach/system.h    |    4 ----
 arch/arm/mach-iop32x/include/mach/system.h     |    4 ----
 arch/arm/mach-iop33x/include/mach/system.h     |    4 ----
 arch/arm/mach-ixp2000/include/mach/system.h    |    4 ----
 arch/arm/mach-ixp23xx/include/mach/system.h    |    4 ----
 arch/arm/mach-ixp4xx/include/mach/system.h     |    4 ----
 arch/arm/mach-kirkwood/include/mach/system.h   |    4 ----
 arch/arm/mach-lpc32xx/include/mach/system.h    |    4 ----
 arch/arm/mach-mmp/include/mach/system.h        |    4 ----
 arch/arm/mach-msm/include/mach/system.h        |    4 ----
 arch/arm/mach-mv78xx0/include/mach/system.h    |    5 -----
 arch/arm/mach-mxs/include/mach/system.h        |    4 ----
 arch/arm/mach-orion5x/include/mach/system.h    |    4 ----
 arch/arm/mach-picoxcell/include/mach/system.h  |    4 ----
 arch/arm/mach-pnx4008/include/mach/system.h    |    4 ----
 arch/arm/mach-prima2/include/mach/system.h     |    4 ----
 arch/arm/mach-pxa/include/mach/system.h        |    4 ----
 arch/arm/mach-realview/include/mach/system.h   |    4 ----
 arch/arm/mach-rpc/include/mach/system.h        |    4 ----
 arch/arm/mach-sa1100/include/mach/system.h     |    4 ----
 arch/arm/mach-shark/include/mach/system.h      |    4 ----
 arch/arm/mach-tegra/include/mach/system.h      |    4 ----
 arch/arm/mach-u300/include/mach/system.h       |    4 ----
 arch/arm/mach-ux500/include/mach/system.h      |    4 ----
 arch/arm/mach-versatile/include/mach/system.h  |    4 ----
 arch/arm/mach-vexpress/include/mach/system.h   |    4 ----
 arch/arm/mach-w90x900/include/mach/system.h    |    5 -----
 arch/arm/mach-zynq/include/mach/system.h       |    4 ----
 arch/arm/plat-mxc/include/mach/system.h        |    4 ----
 arch/arm/plat-spear/include/plat/system.h      |    4 ----
 42 files changed, 2 insertions(+), 172 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index fe7de75..03775b1 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -100,7 +100,6 @@ extern void __show_regs(struct pt_regs *);
 extern int __pure cpu_architecture(void);
 extern void cpu_init(void);
 
-void arm_machine_restart(char mode, const char *cmd);
 void soft_restart(unsigned long);
 extern void (*arm_pm_restart)(char str, const char *cmd);
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 52b4306..72e119f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -117,14 +117,8 @@ void soft_restart(unsigned long addr)
 	cpu_reset(addr);
 }
 
-void arm_machine_restart(char mode, const char *cmd)
+static void null_restart(char mode, const char *cmd)
 {
-	/* Disable interrupts first */
-	local_irq_disable();
-	local_fiq_disable();
-
-	/* Call the architecture specific reboot code. */
-	arch_reset(mode, cmd);
 }
 
 /*
@@ -133,7 +127,7 @@ void arm_machine_restart(char mode, const char *cmd)
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
+void (*arm_pm_restart)(char str, const char *cmd) = null_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 static void do_nothing(void *unused)
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 079eb12..cbd64f3 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -47,8 +47,4 @@ static inline void arch_idle(void)
 #endif
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index 9982deb..23d6ef8 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -32,8 +32,4 @@ static inline void arch_idle(void)
 	mov	r0, r0");
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
index f92540d..9e56b7d 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -22,8 +22,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
index 25a3a65..3027954 100644
--- a/arch/arm/mach-dove/include/mach/system.h
+++ b/arch/arm/mach-dove/include/mach/system.h
@@ -14,9 +14,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
-
 #endif
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
index 574e633..2e4af65 100644
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ b/arch/arm/mach-ebsa110/include/mach/system.h
@@ -34,8 +34,4 @@ static inline void arch_idle(void)
 	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index b27a654..b5bec7c 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -5,7 +5,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
index 794a02c..a174a58 100644
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ b/arch/arm/mach-footbridge/include/mach/system.h
@@ -11,7 +11,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index b04f08d..16ac46e 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -24,8 +24,4 @@ static void arch_idle(void)
 	nop();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-highbank/include/mach/system.h b/arch/arm/mach-highbank/include/mach/system.h
index 0754c79..b1d8b5f 100644
--- a/arch/arm/mach-highbank/include/mach/system.h
+++ b/arch/arm/mach-highbank/include/mach/system.h
@@ -21,8 +21,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
index 12fc8c3..901514e 100644
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ b/arch/arm/mach-integrator/include/mach/system.h
@@ -30,8 +30,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
index 7f798dc..1f31ed3 100644
--- a/arch/arm/mach-iop13xx/include/mach/system.h
+++ b/arch/arm/mach-iop13xx/include/mach/system.h
@@ -11,7 +11,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
index 44e46f2..4a88727 100644
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ b/arch/arm/mach-iop32x/include/mach/system.h
@@ -11,7 +11,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
index 696d88c..4f98e76 100644
--- a/arch/arm/mach-iop33x/include/mach/system.h
+++ b/arch/arm/mach-iop33x/include/mach/system.h
@@ -11,7 +11,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index e981fd2..a7fb08b 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -12,7 +12,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index 7a1b96a..277dda7 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -14,7 +14,3 @@ static inline void arch_idle(void)
 		cpu_do_idle();
 #endif
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index 72db2bb..140a9be 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -17,7 +17,3 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 #endif
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
index 8a94d97..5fddde0 100644
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ b/arch/arm/mach-kirkwood/include/mach/system.h
@@ -14,8 +14,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
index 9c6cc0c..bf176c9 100644
--- a/arch/arm/mach-lpc32xx/include/mach/system.h
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -24,8 +24,4 @@ static void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
index c434f3a..1d001ea 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -13,8 +13,4 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
 #endif /* __ASM_MACH_SYSTEM_H */
diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index e180e8b..311db2b 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -14,10 +14,6 @@
  */
 void arch_idle(void);
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 /* low level hardware reset hook -- for example, hitting the
  * PSHOLD line on the PMIC to hard reset the system
  */
diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
index 1ae3585..8c3a538 100644
--- a/arch/arm/mach-mv78xx0/include/mach/system.h
+++ b/arch/arm/mach-mv78xx0/include/mach/system.h
@@ -14,9 +14,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
-
 #endif
diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
index bcd8989..e7ad1bb 100644
--- a/arch/arm/mach-mxs/include/mach/system.h
+++ b/arch/arm/mach-mxs/include/mach/system.h
@@ -22,8 +22,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __MACH_MXS_SYSTEM_H__ */
diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
index 6677677..825a265 100644
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ b/arch/arm/mach-orion5x/include/mach/system.h
@@ -16,8 +16,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
index a12da63..1a5d8cb 100644
--- a/arch/arm/mach-picoxcell/include/mach/system.h
+++ b/arch/arm/mach-picoxcell/include/mach/system.h
@@ -23,8 +23,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(int mode, const char *cmd)
-{
-}
-
 #endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
index 6710ed3..60cfe71 100644
--- a/arch/arm/mach-pnx4008/include/mach/system.h
+++ b/arch/arm/mach-pnx4008/include/mach/system.h
@@ -26,8 +26,4 @@ static void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
index eb16b4b..2c7d2a9 100644
--- a/arch/arm/mach-prima2/include/mach/system.h
+++ b/arch/arm/mach-prima2/include/mach/system.h
@@ -14,8 +14,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/system.h b/arch/arm/mach-pxa/include/mach/system.h
index 85494ff..c5afacd 100644
--- a/arch/arm/mach-pxa/include/mach/system.h
+++ b/arch/arm/mach-pxa/include/mach/system.h
@@ -13,7 +13,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
index 1630766..471b671 100644
--- a/arch/arm/mach-realview/include/mach/system.h
+++ b/arch/arm/mach-realview/include/mach/system.h
@@ -30,8 +30,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
index e9fb593..359bab9 100644
--- a/arch/arm/mach-rpc/include/mach/system.h
+++ b/arch/arm/mach-rpc/include/mach/system.h
@@ -11,7 +11,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
index 3c3e842..e17b208 100644
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ b/arch/arm/mach-sa1100/include/mach/system.h
@@ -7,7 +7,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 2cc363a..1b2f2c5 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -6,10 +6,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 static inline void arch_idle(void)
 {
 }
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index b87b8a4..a312988 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -21,10 +21,6 @@
 #ifndef __MACH_TEGRA_SYSTEM_H
 #define __MACH_TEGRA_SYSTEM_H
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 static inline void arch_idle(void)
 {
 }
diff --git a/arch/arm/mach-u300/include/mach/system.h b/arch/arm/mach-u300/include/mach/system.h
index 0ddf3cd..574d46e 100644
--- a/arch/arm/mach-u300/include/mach/system.h
+++ b/arch/arm/mach-u300/include/mach/system.h
@@ -12,7 +12,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ux500/include/mach/system.h b/arch/arm/mach-ux500/include/mach/system.h
index ae1dff1..258e5c9 100644
--- a/arch/arm/mach-ux500/include/mach/system.h
+++ b/arch/arm/mach-ux500/include/mach/system.h
@@ -17,8 +17,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
index 335946a..f3fa347 100644
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ b/arch/arm/mach-versatile/include/mach/system.h
@@ -30,8 +30,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-vexpress/include/mach/system.h b/arch/arm/mach-vexpress/include/mach/system.h
index 899a4e6..f653a8e 100644
--- a/arch/arm/mach-vexpress/include/mach/system.h
+++ b/arch/arm/mach-vexpress/include/mach/system.h
@@ -30,8 +30,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
index 001a2f9..2aaeb93 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -17,8 +17,3 @@
 static void arch_idle(void)
 {
 }
-
-static void arch_reset(char mode, const char *cmd)
-{
-}
-
diff --git a/arch/arm/mach-zynq/include/mach/system.h b/arch/arm/mach-zynq/include/mach/system.h
index 34be7ed..8e88e0b 100644
--- a/arch/arm/mach-zynq/include/mach/system.h
+++ b/arch/arm/mach-zynq/include/mach/system.h
@@ -20,8 +20,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 22b8911..b9c71b4 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -27,8 +27,4 @@ static inline void arch_idle(void)
 		cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __ASM_ARCH_MXC_SYSTEM_H__ */
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
index 4a0d125..86c6f83 100644
--- a/arch/arm/plat-spear/include/plat/system.h
+++ b/arch/arm/plat-spear/include/plat/system.h
@@ -23,8 +23,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __PLAT_SYSTEM_H */
-- 
1.7.4.4
