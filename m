From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:32 +0100
Subject: [PATCH v2 13/16] ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the zynq platform to be using the gic_handle_irq
function as its primary interrupt handler.

Acked-by: John Linn <john.linn@xilinx.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-zynq/common.c                   |    1 +
 arch/arm/mach-zynq/include/mach/entry-macro.S |    3 ---
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70a947e..0514264 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -911,6 +911,7 @@ config ARCH_ZYNQ
 	select ARM_AMBA
 	select ICST
 	select USE_OF
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 73e9368..ab5cfdd 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -112,6 +112,7 @@ static const char *xilinx_dt_match[] = {
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.map_io		= xilinx_map_io,
 	.init_irq	= xilinx_irq_init,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= xilinx_init_machine,
 	.timer		= &xttcpss_sys_timer,
 	.dt_compat	= xilinx_dt_match,
diff --git a/arch/arm/mach-zynq/include/mach/entry-macro.S b/arch/arm/mach-zynq/include/mach/entry-macro.S
index 3cfc01b..d621fb7 100644
--- a/arch/arm/mach-zynq/include/mach/entry-macro.S
+++ b/arch/arm/mach-zynq/include/mach/entry-macro.S
@@ -20,9 +20,6 @@
  * GNU General Public License for more details.
  */
 
-#include <mach/hardware.h>
-#include <asm/hardware/entry-macro-gic.S>
-
 		.macro  disable_fiq
 		.endm
 
-- 
1.7.0.4
