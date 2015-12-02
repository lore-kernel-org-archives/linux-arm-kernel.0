From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed,  2 Dec 2015 18:06:52 +0100
Subject: [PATCH] ARM: dts: stm32f429: Boost perfs by remapping SDRAM Bank 1 to
 0x0
Message-ID: <1449076012-19519-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32F429 allows to remap FMC SDRAM Bank 1 from 0xc0000000 to 0x0,
by writing 0x4 to SYSCFG_MEMRMP register.

As mentionned in the reference manual (see chapter 9.3.1), the performance
gain is really interresting:
"In remap mode at address 0x0000 0000, the CPU can access the external
memory via ICode bus instead of System bus which boosts up the
performance."

These are the dhrystone results with and without the remap enabled:
Default (SDRAM in 0xc0000000):
---------------------------------
Microseconds for one run through Dhrystone:   31.8
Dhrystones per Second:                      31416.9

Remap (SDRAM in 0x0000000):
-----------------------------
Microseconds for one run through Dhrystone:   20.6
Dhrystones per Second:                      48520.1

This patch first change the SDRAM start address to 0x0 for STM32429i-EVAL
board, and also set the dma-range property as the other masters than the M4
CPU still see SDRAM in 0xc0000000.

Note that the Discovery board cannot benefit from this feature, since the
SDRAM is connected to Bank 2.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 2 +-
 arch/arm/boot/dts/stm32f429.dtsi     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6964fc9..a717acb 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -58,7 +58,7 @@
 	};
 
 	memory {
-		reg = <0xc0000000 0x2000000>;
+		reg = <0x00000000 0x2000000>;
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index eaf7a72..84e5fb3 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -57,6 +57,8 @@
 	};
 
 	soc {
+		dma-ranges = <0xc0000000 0x0 0x10000000>;
+
 		timer2: timer at 40000000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
-- 
1.9.1
