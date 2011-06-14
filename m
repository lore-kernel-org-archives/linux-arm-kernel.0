From: saeed@marvell.com (Saeed Bishara)
Date: Tue, 14 Jun 2011 16:28:52 +0300
Subject: [PATCH] ARM: realview,
	vexpress: fix section mismatch from platform_cpu_die() to pen_release
Message-ID: <1308058132-32058-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following false section mismatch warning, this function used
only in CONFIG_HOTPLUG_CPU, and in this configuration, the cpuinit section will not
be freed, so it's ok to reference pen_release.

WARNING: vmlinux.o(.text+0x12484): Section mismatch in reference from the function platform_cpu_die() to the variable .cpuinit.data:pen_release
The function platform_cpu_die() references
the variable __cpuinitdata pen_release.
This is often because platform_cpu_die lacks a __cpuinitdata
annotation or the annotation of pen_release is wrong.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-realview/hotplug.c |    2 +-
 arch/arm/mach-vexpress/hotplug.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index a87523d..44841c6 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -97,7 +97,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index ea4cbfb..0436fcf 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -98,7 +98,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
-- 
1.7.4.1
