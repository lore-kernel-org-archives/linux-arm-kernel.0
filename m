From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Jun 2013 14:20:44 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: Initialise clocks and SCIF in
 r8a7790_add_dt_devices()
In-Reply-To: <1372396845-28767-1-git-send-email-horms+renesas@verge.net.au>
References: <1372396845-28767-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372396845-28767-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is sufficient to allow boot of the Lager board with
a console without boards-lager.c compiled into the kernel.
This is an example of a minimal but still useful initialisation
of the board using DT as much as possible.

Also provide r8a7790_add_dt_device() in
r8a7790.h to allow it be used from a boards-lager-reference.c
file which will be added by a subsequent patch.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 2e919e6..d50403e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -2,6 +2,7 @@
 #define __ASM_R8A7790_H__
 
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_standard_devices_dt(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_timer_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 06c720f..a6344a1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -160,7 +160,7 @@ static struct resource thermal_resources[] __initdata = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
-void __init r8a7790_add_standard_devices(void)
+void __init r8a7790_add_dt_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
 	r8a7790_register_scif(SCIFA1);
@@ -172,6 +172,11 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(SCIF1);
 	r8a7790_register_scif(HSCIF0);
 	r8a7790_register_scif(HSCIF1);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
+	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 }
@@ -191,6 +196,10 @@ void __init r8a7790_timer_init(void)
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
+	/* clocks are setup late during boot in the case of DT */
+	r8a7790_clock_init();
+
+	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.2.1
