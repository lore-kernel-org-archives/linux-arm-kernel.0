From: motobud@gmail.com (Brent Taylor)
Date: Sun, 24 Nov 2013 12:02:35 -0600
Subject: [PATCH] fixed unresolved symbol "at91_pm_set_standby" when built
 without CONFIG_PM
Message-ID: <CAP+RiCDKcBwJunmNF89kh1zoT0xKYRWvaBPHnijRafLU2MHf_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_PM is not defined, then arch/arm/mach-at91/pm.c is not
compiled in.  This patch creates an inline function that does nothing
if CONFIG_PM is not defined.

---
 arch/arm/mach-at91/pm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3ed190c..c5101dc 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -16,7 +16,11 @@
 #include <mach/at91_ramc.h>
 #include <mach/at91rm9200_sdramc.h>

+#ifdef CONFIG_PM
 extern void at91_pm_set_standby(void (*at91_standby)(void));
+#else
+static inline void at91_pm_set_standby(void (*at91_standby)(void)) { }
+#endif

 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
--
1.8.3.2
