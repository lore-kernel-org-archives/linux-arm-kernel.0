From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:19 +0100
Subject: [PATCH 51/51] ARM: reset: remove empty arch_reset definitions
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-52-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_reset is now an empty static inline function for all ARM platforms,
so remove it and the temporary_arm_arch_reset function.

I used this very basic Coccinelle script for the platform updates:

	@@
	@@
	- arch_reset(...) { }

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/process.c                      |    7 +------
 arch/arm/mach-at91/include/mach/system.h       |    4 ----
 arch/arm/mach-bcmring/include/mach/system.h    |    4 ----
 arch/arm/mach-clps711x/include/mach/system.h   |    4 ----
 arch/arm/mach-cns3xxx/include/mach/system.h    |    4 ----
 arch/arm/mach-davinci/include/mach/system.h    |    4 ----
 arch/arm/mach-dove/include/mach/system.h       |    4 ----
 arch/arm/mach-ebsa110/include/mach/system.h    |    4 ----
 arch/arm/mach-ep93xx/include/mach/system.h     |    4 ----
 arch/arm/mach-footbridge/include/mach/system.h |    4 ----
 arch/arm/mach-gemini/include/mach/system.h     |    4 ----
 arch/arm/mach-h720x/include/mach/system.h      |    5 -----
 arch/arm/mach-integrator/include/mach/system.h |    4 ----
 arch/arm/mach-iop13xx/include/mach/system.h    |    4 ----
 arch/arm/mach-iop32x/include/mach/system.h     |    4 ----
 arch/arm/mach-iop33x/include/mach/system.h     |    4 ----
 arch/arm/mach-ixp2000/include/mach/system.h    |    4 ----
 arch/arm/mach-ixp23xx/include/mach/system.h    |    4 ----
 arch/arm/mach-ixp4xx/include/mach/system.h     |    5 -----
 arch/arm/mach-kirkwood/include/mach/system.h   |    4 ----
 arch/arm/mach-ks8695/include/mach/system.h     |    4 ----
 arch/arm/mach-lpc32xx/include/mach/system.h    |    4 ----
 arch/arm/mach-mmp/include/mach/system.h        |    4 ----
 arch/arm/mach-msm/include/mach/system.h        |    4 ----
 arch/arm/mach-mv78xx0/include/mach/system.h    |    4 ----
 arch/arm/mach-mxs/include/mach/system.h        |    4 ----
 arch/arm/mach-netx/include/mach/system.h       |    4 ----
 arch/arm/mach-nomadik/include/mach/system.h    |    4 ----
 arch/arm/mach-nuc93x/include/mach/system.h     |    4 ----
 arch/arm/mach-orion5x/include/mach/system.h    |    4 ----
 arch/arm/mach-pnx4008/include/mach/system.h    |    4 ----
 arch/arm/mach-prima2/include/mach/system.h     |    4 ----
 arch/arm/mach-pxa/include/mach/system.h        |    5 -----
 arch/arm/mach-realview/include/mach/system.h   |    4 ----
 arch/arm/mach-rpc/include/mach/system.h        |    4 ----
 arch/arm/mach-s3c64xx/include/mach/system.h    |    4 ----
 arch/arm/mach-sa1100/include/mach/system.h     |    4 ----
 arch/arm/mach-shark/include/mach/system.h      |    3 ---
 arch/arm/mach-shmobile/include/mach/system.h   |    4 ----
 arch/arm/mach-tegra/include/mach/system.h      |    3 ---
 arch/arm/mach-u300/include/mach/system.h       |    4 ----
 arch/arm/mach-ux500/include/mach/system.h      |    5 -----
 arch/arm/mach-versatile/include/mach/system.h  |    4 ----
 arch/arm/mach-vexpress/include/mach/system.h   |    4 ----
 arch/arm/mach-vt8500/include/mach/system.h     |    4 ----
 arch/arm/mach-w90x900/include/mach/system.h    |    4 ----
 arch/arm/mach-zynq/include/mach/system.h       |    5 -----
 arch/arm/plat-omap/include/plat/system.h       |    3 ---
 arch/arm/plat-spear/include/plat/system.h      |    4 ----
 arch/arm/plat-tcc/include/mach/system.h        |    4 ----
 50 files changed, 1 insertions(+), 204 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 13e68c5..0594f4c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -129,11 +129,6 @@ void arm_machine_restart(char mode, const char *cmd)
 	while (1);
 }
 
-static void temporary_arm_arch_reset(char mode, const char *cmd)
-{
-	arch_reset(mode, cmd);
-}
-
 /*
  * Function pointers to optional machine specific functions
  */
@@ -143,7 +138,7 @@ EXPORT_SYMBOL(pm_power_off);
 void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
-void (*arm_arch_reset)(char mode, const char *cmd) = temporary_arm_arch_reset;
+void (*arm_arch_reset)(char mode, const char *cmd);
 EXPORT_SYMBOL_GPL(arm_arch_reset);
 
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
diff --git a/arch/arm/mach-bcmring/include/mach/system.h b/arch/arm/mach-bcmring/include/mach/system.h
index 6cd872d..e7343c5 100644
--- a/arch/arm/mach-bcmring/include/mach/system.h
+++ b/arch/arm/mach-bcmring/include/mach/system.h
@@ -27,8 +27,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
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
index 092d774..7f43a64 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -23,8 +23,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index 6bd1dc0..fcb7a01 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -18,8 +18,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
index ce3e749..21d651a 100644
--- a/arch/arm/mach-dove/include/mach/system.h
+++ b/arch/arm/mach-dove/include/mach/system.h
@@ -16,8 +16,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
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
index ce48083..a2f0967 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -8,7 +8,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
index 0c19392..85f44ab 100644
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ b/arch/arm/mach-footbridge/include/mach/system.h
@@ -17,7 +17,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
index 7df8e48..3c4f114 100644
--- a/arch/arm/mach-gemini/include/mach/system.h
+++ b/arch/arm/mach-gemini/include/mach/system.h
@@ -28,8 +28,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index 4c2fba9..16ac46e 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -24,9 +24,4 @@ static void arch_idle(void)
 	nop();
 }
 
-
-static __inline__ void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
index 6e5adbf..37314a2 100644
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ b/arch/arm/mach-integrator/include/mach/system.h
@@ -32,8 +32,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
index 6b9bba7..9f0d83e 100644
--- a/arch/arm/mach-iop13xx/include/mach/system.h
+++ b/arch/arm/mach-iop13xx/include/mach/system.h
@@ -12,7 +12,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
index 094714d..0ee7dae 100644
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ b/arch/arm/mach-iop32x/include/mach/system.h
@@ -15,7 +15,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
index df98c56..04500c8 100644
--- a/arch/arm/mach-iop33x/include/mach/system.h
+++ b/arch/arm/mach-iop33x/include/mach/system.h
@@ -13,7 +13,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index d79c7ad..47c8757 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -13,7 +13,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
index 4569003..3b89dd5 100644
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ b/arch/arm/mach-ixp23xx/include/mach/system.h
@@ -15,7 +15,3 @@ static inline void arch_idle(void)
 		cpu_do_idle();
 #endif
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index ed5964c..5ac2578 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -18,8 +18,3 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 #endif
 }
-
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
index f094431..f85cf7f 100644
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ b/arch/arm/mach-kirkwood/include/mach/system.h
@@ -14,9 +14,5 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 
 #endif
diff --git a/arch/arm/mach-ks8695/include/mach/system.h b/arch/arm/mach-ks8695/include/mach/system.h
index b73ee70..59fe992 100644
--- a/arch/arm/mach-ks8695/include/mach/system.h
+++ b/arch/arm/mach-ks8695/include/mach/system.h
@@ -24,8 +24,4 @@ static void arch_idle(void)
 
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
index b09c19a..f5add75 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -15,8 +15,4 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
 #endif /* __ASM_MACH_SYSTEM_H */
diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index ab6590b..a8a53b2 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -16,7 +16,3 @@
 #include <mach/hardware.h>
 
 void arch_idle(void);
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
index 1a41dc5..dd7a016 100644
--- a/arch/arm/mach-mv78xx0/include/mach/system.h
+++ b/arch/arm/mach-mv78xx0/include/mach/system.h
@@ -16,9 +16,5 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
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
diff --git a/arch/arm/mach-netx/include/mach/system.h b/arch/arm/mach-netx/include/mach/system.h
index 83ae2b1..b38fa36 100644
--- a/arch/arm/mach-netx/include/mach/system.h
+++ b/arch/arm/mach-netx/include/mach/system.h
@@ -24,9 +24,5 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
 
diff --git a/arch/arm/mach-nomadik/include/mach/system.h b/arch/arm/mach-nomadik/include/mach/system.h
index 16f59f6..25e198b 100644
--- a/arch/arm/mach-nomadik/include/mach/system.h
+++ b/arch/arm/mach-nomadik/include/mach/system.h
@@ -29,8 +29,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-nuc93x/include/mach/system.h b/arch/arm/mach-nuc93x/include/mach/system.h
index a4d39a3..08188e7 100644
--- a/arch/arm/mach-nuc93x/include/mach/system.h
+++ b/arch/arm/mach-nuc93x/include/mach/system.h
@@ -18,7 +18,3 @@
 static void arch_idle(void)
 {
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
index 91a933c..997b13e 100644
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ b/arch/arm/mach-orion5x/include/mach/system.h
@@ -18,8 +18,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
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
index 1d14a77..98e5d83 100644
--- a/arch/arm/mach-prima2/include/mach/system.h
+++ b/arch/arm/mach-prima2/include/mach/system.h
@@ -16,8 +16,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/system.h b/arch/arm/mach-pxa/include/mach/system.h
index 0687110..2ff62d6 100644
--- a/arch/arm/mach-pxa/include/mach/system.h
+++ b/arch/arm/mach-pxa/include/mach/system.h
@@ -16,8 +16,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
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
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index 436a8b3..353ed43 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -16,8 +16,4 @@ static void arch_idle(void)
 	/* nothing here yet */
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
index ac3bdb8..6bcafe3 100644
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ b/arch/arm/mach-sa1100/include/mach/system.h
@@ -8,7 +8,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 2cc363a..c543685 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -6,9 +6,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
 
 static inline void arch_idle(void)
 {
diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
index 4f2bea5..e150937 100644
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ b/arch/arm/mach-shmobile/include/mach/system.h
@@ -6,8 +6,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index b87b8a4..bc51978 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -21,9 +21,6 @@
 #ifndef __MACH_TEGRA_SYSTEM_H
 #define __MACH_TEGRA_SYSTEM_H
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
 
 static inline void arch_idle(void)
 {
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
index c0cd800..258e5c9 100644
--- a/arch/arm/mach-ux500/include/mach/system.h
+++ b/arch/arm/mach-ux500/include/mach/system.h
@@ -17,9 +17,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-	/* yet to be implemented - TODO */
-}
-
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
index ebc6348..cc5cdd9 100644
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ b/arch/arm/mach-versatile/include/mach/system.h
@@ -34,8 +34,4 @@ static inline void arch_idle(void)
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
diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
index 4bbcce4..6daf809 100644
--- a/arch/arm/mach-vt8500/include/mach/system.h
+++ b/arch/arm/mach-vt8500/include/mach/system.h
@@ -7,7 +7,3 @@ static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
index ed3478b..da6e4e8 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -18,7 +18,3 @@
 static void arch_idle(void)
 {
 }
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
diff --git a/arch/arm/mach-zynq/include/mach/system.h b/arch/arm/mach-zynq/include/mach/system.h
index 1b84d70..8e88e0b 100644
--- a/arch/arm/mach-zynq/include/mach/system.h
+++ b/arch/arm/mach-zynq/include/mach/system.h
@@ -20,9 +20,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-	/* Add architecture specific reset processing here */
-}
-
 #endif
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index ac32d88..91db6db 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -12,9 +12,6 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-/* To be removed in a future ARM-wide cleanup */
-static inline void arch_reset(char mode, const char *cmd) {}
-
 extern void omap1_arch_reset(char mode, const char *cmd);
 extern void omap_prcm_arch_reset(char mode, const char *cmd);
 
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
diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
index e97ae31..da3f019 100644
--- a/arch/arm/plat-tcc/include/mach/system.h
+++ b/arch/arm/plat-tcc/include/mach/system.h
@@ -19,8 +19,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
 #endif
-- 
1.7.4.1
