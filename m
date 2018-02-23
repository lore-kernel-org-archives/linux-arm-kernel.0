From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 23 Feb 2018 14:37:36 +0100
Subject: [PATCH v4 04/10] ARM: sun8i: smp: Add hotplug support for sun8i-a83t
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
Message-ID: <20180223133742.26044-5-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hotplug support for sun8i-a83t.

Hotplug CPU for CPU0 is currently not working.
Remove the possibility to disable CPU0 only for sun8i-a83t.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 3bd9066a1422..f2c2cfca28cd 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -579,6 +579,8 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	if (is_sun9i)
 		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	else
+		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -660,8 +662,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	return !ret;
 }
 
-static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
+static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
 {
+	/* CPU0 hotplug handled only for sun9i */
+	if (!is_sun9i)
+		if (cpu == 0)
+			return false;
 	return true;
 }
 #endif
-- 
2.11.0
