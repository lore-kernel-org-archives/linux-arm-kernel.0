From: embed3d@gmail.com (Philipp Rossak)
Date: Sat, 17 Feb 2018 15:22:35 +0100
Subject: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
Message-ID: <20180217142235.28541-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now the performance govenor is the default frequency govenor on
sunxi devices. This causes some general problems.
When the cpu is idle the cpu runs with its maximum frequency.
This causes a higher cpu temperature in the idle state. When the cpu is
now under load the cpu gets with that higher idle temperature now faster
to its thermal limits.
An other big problem of the performace govenor is the missing
thermal throttling. Some tests with cpuburn resulted in a system crash
when the soc reached its thermal limits since no thermal throttling
occurred.

With this patch we set the default frequency govenor to ondemand mode
and reduce the temperature when the cpu is idle and activate the thermal
throtteling.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..e5812851091c 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -14,6 +14,7 @@ CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.11.0
