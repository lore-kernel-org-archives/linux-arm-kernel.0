From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jan 2015 17:54:15 +0000
Subject: [PATCH 1/4] arm64: dts: fix PMU IRQ ordering for Juno
Message-ID: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For better or worse, perf expects the per-cpu SPI PMU interrupts to be
listed in order of logical CPU. This patch fixes the Juno .dts to
satisfy that requirement.

Without this patch, I see unhandled IRQs in mainline:

  irq 9: nobody cared (try booting with the "irqpoll" option)
  CPU: 3 PID: 2830 Comm: cc1 Not tainted 3.19.0-rc6+ #1
  Hardware name: ARM Juno development board (r0) (DT)

  [...]

  handlers:
  [<ffffffc00009447c>] armv8pmu_handle_irq
  Disabling IRQ #9

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This is an immediate fix for mainline, with the remaining patches in the
series solving this by extending the binding.

 arch/arm64/boot/dts/arm/juno.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index cb3073e4e7a8..4ed9287aaef1 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -107,11 +107,11 @@
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	/include/ "juno-clocks.dtsi"
-- 
2.1.4
