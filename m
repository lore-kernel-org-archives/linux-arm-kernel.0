From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 17:12:16 -0700
Subject: [PATCH] ARM: OMAP1: Fix warnings about enabling 32 KiHz timer
Message-ID: <20111007001216.GD6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix "Enable 32kHz OS timer in order to allow sleep states in idle"
warning. We are now compiling in bothe MPU timer and 32 KiHz timer,
so this warning is only valid when CONFIG_OMAP_32K_TIMER is not set.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 495b398..6badc29 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -116,7 +116,7 @@ void omap1_pm_idle(void)
 		return;
 	}
 
-#ifdef CONFIG_OMAP_MPU_TIMER
+#if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_32K_TIMER)
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
 	use_idlect1 = use_idlect1 & ~(1 << 9);
 #else
