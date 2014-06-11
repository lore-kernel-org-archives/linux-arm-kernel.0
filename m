From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Jun 2014 14:06:37 +0200
Subject: [PATCH] ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7
 platforms
Message-ID: <1402488397-31381-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Armada platforms, the PMSU (Power Management Service Unit)
controls a number of power management related activities, needed for
things like suspend/resume, CPU hotplug, cpuidle or even simply SMP.

Since cpuidle support was added for Armada XP, the pmsu.c file in
arch/arm/mach-mvebu/ calls the cpu_suspend() and cpu_resume() ARM
functions, which are only available when
CONFIG_ARM_CPU_SUSPEND=y. Therefore, configurations that have
CONFIG_ARM_CPU_SUSPEND disabled due to PM_SLEEP being disabled no
longer build properly, due to undefined references to cpu_suspend()
and cpu_resume().

To fix this, this patch simply ensures CONFIG_ARM_CPU_SUSPEND is
always enabled for Marvell EBU v7 platforms. Doing things in a more
fine-grained way would require a lot of #ifdef-ery in pmsu.c to
isolate the parts that use cpu_suspend()/cpu_resume(), and those parts
would anyway have been needed as soon as either one of suspend/resume,
CPU hotplug or cpuidle was enabled.

Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, this patch is against the mvebu/soc branch, and should be
pushed to 3.16, where the problem was introduced.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index d6b0a77..b4ef28c 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -22,6 +22,7 @@ config MACH_MVEBU_V7
 	bool
 	select ARMADA_370_XP_TIMER
 	select CACHE_L2X0
+	select ARM_CPU_SUSPEND
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
-- 
2.0.0
