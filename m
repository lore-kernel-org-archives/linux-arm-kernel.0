From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:47:05 +0000
Subject: [PATCH 21/41] ARM: restart: mmp: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6oD-0001Xy-Bu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the Shark restart code into the new restart hook rather than
using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mmp/aspenite.c            |    2 ++
 arch/arm/mach-mmp/avengers_lite.c       |    1 +
 arch/arm/mach-mmp/brownstone.c          |    1 +
 arch/arm/mach-mmp/common.c              |    5 +++++
 arch/arm/mach-mmp/common.h              |    1 +
 arch/arm/mach-mmp/flint.c               |    1 +
 arch/arm/mach-mmp/gplugd.c              |    1 +
 arch/arm/mach-mmp/include/mach/pxa168.h |    1 +
 arch/arm/mach-mmp/include/mach/system.h |    6 ------
 arch/arm/mach-mmp/jasper.c              |    1 +
 arch/arm/mach-mmp/pxa168.c              |    5 +++++
 arch/arm/mach-mmp/tavorevb.c            |    1 +
 arch/arm/mach-mmp/teton_bga.c           |    1 +
 arch/arm/mach-mmp/ttc_dkb.c             |    1 +
 14 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5ad7..45d21e8 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -242,6 +242,7 @@ MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
+	.restart	= pxa168_restart,
 MACHINE_END
 
 MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
@@ -250,4 +251,5 @@ MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
+	.restart	= pxa168_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 39f0878..8de3dc6 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -45,4 +45,5 @@ MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = avengers_lite_init,
+	.restart	= pxa168_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 983cfb1..e16f04b 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -219,4 +219,5 @@ MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
 	.init_irq	= mmp2_init_irq,
 	.timer		= &mmp2_timer,
 	.init_machine	= brownstone_init,
+	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 5720674..062b5b9 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -45,3 +45,8 @@ void __init mmp_map_io(void)
 	/* this is early, initialize mmp_chip_id here */
 	mmp_chip_id = __raw_readl(MMP_CHIPID);
 }
+
+void mmp_restart(char mode, const char *cmd)
+{
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index ec8d65d..1c9d6c1 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -6,3 +6,4 @@ extern void timer_init(int irq);
 
 extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
+extern void mmp_restart(char, const char *);
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index c4fd806..5a6a27a 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -121,4 +121,5 @@ MACHINE_START(FLINT, "Flint Development Platform")
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = flint_init,
+	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 6915656..a87f2f5 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -194,4 +194,5 @@ MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = gplugd_init,
+	.restart	= pxa168_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7fb568d..a677aa7 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -5,6 +5,7 @@ struct sys_timer;
 
 extern struct sys_timer pxa168_timer;
 extern void __init pxa168_init_irq(void);
+extern void pxa168_restart(char, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
index cb06379..c434f3a 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_MACH_SYSTEM_H
 #define __ASM_MACH_SYSTEM_H
 
-#include <mach/cputype.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -18,9 +16,5 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (cpu_is_pxa168())
-		soft_restart(0xffff0000);
-	else
-		soft_restart(0);
 }
 #endif /* __ASM_MACH_SYSTEM_H */
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 8bfac66..96cf5c8 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -175,4 +175,5 @@ MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = jasper_init,
+	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 76ca15c..13f2386 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -214,3 +214,8 @@ int __init pxa168_add_usb_host(struct pxa168_usb_pdata *pdata)
 	pxa168_device_usb_host.dev.platform_data = pdata;
 	return platform_device_register(&pxa168_device_usb_host);
 }
+
+void pxa168_restart(char mode, const char *cmd)
+{
+	soft_restart(0xffff0000);
+}
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index eb5be87..257a212 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -103,4 +103,5 @@ MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = tavorevb_init,
+	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbe4727..8ac22a6 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -86,4 +86,5 @@ MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = teton_bga_init,
+	.restart	= pxa168_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 176515a..f026588 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -159,4 +159,5 @@ MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = ttc_dkb_init,
+	.restart	= mmp_restart,
 MACHINE_END
-- 
1.7.4.4
