From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 08:49:33 -0500
Subject: [PATCH 7/7] ARM: OMAP4+: PM: Use only valid low power state for CPU
 hotplug
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com>
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Message-ID: <1408715373-25791-8-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all SoCs support OFF mode - for example DRA74/72. So, use valid
power state during CPU hotplug.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 4001325..e9cdacf 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -298,6 +298,10 @@ int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
 
+	/* Use the achievable power state for the domain */
+	power_state = pwrdm_get_valid_lp_state(pm_info->pwrdm,
+					       false, power_state);
+
 	if (power_state == PWRDM_POWER_OFF)
 		cpu_state = 1;
 
-- 
1.7.9.5
