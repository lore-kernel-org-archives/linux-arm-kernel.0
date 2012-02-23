From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 23 Feb 2012 12:28:30 +0530
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
 platform_cpu_die()
In-Reply-To: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.text+0x226d0):
Section mismatch in reference from the function
platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
The function platform_cpu_die() references
the function __cpuinit omap4_hotplug_cpu().
This is often because platform_cpu_die lacks a __cpuinit
annotation or the annotation of omap4_hotplug_cpu is wrong.

Thanks to Russell King for suggesting __ref annotation trick
just like it's parent function for this warning becasue __cupinit
usage was definitely wrong to fix this warning..

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index adbe4d8..56c345b 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;
 
-- 
1.7.4.1
