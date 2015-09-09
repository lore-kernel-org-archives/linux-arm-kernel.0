From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Sep 2015 16:18:11 -0500
Subject: [PATCH 1/4] ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Message-ID: <1441833494-32450-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 and DRA7 reuse the same pm44xx_erratum variable so, enable the
same, else PM features such as Suspend to ram is broken in a SoC only
build configuration.

Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 425bfcd67db6..f5bae699baac 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -103,7 +103,8 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
 #define PM_OMAP4_CPU_OSWR_DISABLE		(1 << 1)
 
-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) ||\
+	   defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX))
 extern u16 pm44xx_errata;
 #define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
 #else
-- 
1.7.9.5
