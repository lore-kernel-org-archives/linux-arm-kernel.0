From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 15:42:42 +0800
Subject: [PATCH] ARM: imx: do not return from imx_cpu_die() call
Message-ID: <1381304562-22852-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When imx_cpu_die() is being called, the cpu should never return from the
call but just in WFI and wait for hardware to take it down.  So let's
do cpu_do_idle() repeatly in the call.  Doing this help improve the
relibility of hotplug operation.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/hotplug.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 3daf1ed..b35e99c 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -52,7 +52,9 @@ void imx_cpu_die(unsigned int cpu)
 	 * the register being cleared to kill the cpu.
 	 */
 	imx_set_cpu_arg(cpu, ~0);
-	cpu_do_idle();
+
+	while (1)
+		cpu_do_idle();
 }
 
 int imx_cpu_kill(unsigned int cpu)
-- 
1.7.9.5
