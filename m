From: nm@ti.com (Nishanth Menon)
Date: Wed, 8 May 2013 14:06:16 -0500
Subject: [PATCH V5 6/6] ARM: OMAP3+: use cpu0-cpufreq driver in device tree
 supported boot
In-Reply-To: <1368039976-29648-1-git-send-email-nm@ti.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
Message-ID: <1368039976-29648-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With OMAP3+ and AM33xx supported SoC having defined CPU device tree
entries with operating-points and clock nodes defined, we can now use
the SoC generic cpufreq-cpu0 driver by registering appropriate device.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
no change in current revision.
Previous version: http://marc.info/?l=linux-omap&m=136580759924239&w=2

 arch/arm/mach-omap2/pm.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e742118..11bd585 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -266,7 +266,12 @@ static void __init omap4_init_voltages(void)
 
 static inline void omap_init_cpufreq(void)
 {
-	struct platform_device_info devinfo = { .name = "omap-cpufreq", };
+	struct platform_device_info devinfo = { };
+
+	if (!of_have_populated_dt())
+		devinfo.name = "omap-cpufreq";
+	else
+		devinfo.name = "cpufreq-cpu0";
 	platform_device_register_full(&devinfo);
 }
 
@@ -300,9 +305,9 @@ int __init omap2_common_pm_late_init(void)
 		/* Smartreflex device init */
 		omap_devinit_smartreflex();
 
-		/* cpufreq dummy device instantiation */
-		omap_init_cpufreq();
 	}
+	/* cpufreq dummy device instantiation */
+	omap_init_cpufreq();
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.7.9.5
