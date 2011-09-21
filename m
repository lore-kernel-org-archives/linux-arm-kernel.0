From: khilman@ti.com (Kevin Hilman)
Date: Wed, 21 Sep 2011 09:24:53 -0700
Subject: [PATCH] ARM: OMAP: voltage layer present, even when CONFIG_PM=n
Message-ID: <mailman.147.1316623396.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when CONFIG_PM=n, we try to scale the boot voltage to a sane,
known value using OPP table to find matching voltage based on boot
frequency.  This should be done, even when CONFIG_PM=n to avoid
mis-configured bootloaders and/or boot voltage assumptions made by
boot loaders.

Also fixes various compile problems due to depenencies between voltage
domain and powerdomain code (also present when CONFIG_PM=n).

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Compile tested with CONFIG_PM=n
Applies to arm-soc/next/voltage

 arch/arm/mach-omap2/Makefile  |    2 --
 arch/arm/mach-omap2/voltage.h |   14 --------------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8bd389d..5129785 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,7 +89,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   vp44xx_data.o
 
 # OMAP voltage domains
-ifeq ($(CONFIG_PM),y)
 voltagedomain-common			:= voltage.o vc.o vp.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
 					   voltagedomains2xxx_data.o
@@ -97,7 +96,6 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
-endif
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 4c09809..16a1b09 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -148,25 +148,11 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
-#ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 			       struct omap_voltdm_pmic *pmic);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 int omap_voltage_late_init(void);
-#else
-static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-					     struct omap_voltdm_pmic *pmic)
-{
-	return -EINVAL;
-}
-static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method) {}
-static inline int omap_voltage_late_init(void)
-{
-	return -EINVAL;
-}
-#endif
 
 extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
-- 
1.7.6
