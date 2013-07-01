From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Jul 2013 11:18:39 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: Initialise clocks and SCIF in
 r8a7790_add_dt_devices()
In-Reply-To: <1372645120-27256-1-git-send-email-horms+renesas@verge.net.au>
References: <1372645120-27256-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372645120-27256-2-git-send-email-horms+renesas@verge.net.au>
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

v2

* Rebase
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 7851cc1..7a25138 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -2,6 +2,7 @@
 #define __ASM_R8A7790_H__
 
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_standard_devices_dt(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d89cd83..770109b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -180,7 +180,7 @@ static struct resource cmt00_resources[] = {
 					  &cmt##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
-void __init r8a7790_add_standard_devices(void)
+void __init r8a7790_add_dt_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
 	r8a7790_register_scif(SCIFA1);
@@ -192,6 +192,11 @@ void __init r8a7790_add_standard_devices(void)
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
 	r8a7790_register_cmt(00);
@@ -219,6 +224,10 @@ void __init r8a7790_init_delay(void)
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
