From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 30 Jan 2014 13:45:43 +0200
Subject: [PATCH] ARM: keystone: dts: disable "msmcsram" clock
Message-ID: <1391082343-13371-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At late init all unused clocks are disabled. So clocks that were not
get before will be gated. In Keysone 2 SoC we have at least one
necessary clock that is not used by any driver - "msmcsram". This
clock is necessary, because it supplies the Multicore Shared Memory
Controller (MSMC). The MSMC provides memory protection for accesses to
the MSMC SRAM and DDR3 memory from system masters. It also manages
traffic among mastering peripherals and the EMIF.

This means that MSMC clock is always needed by SoC and cannot be gated.
It is only one from necessary clocks that was not used by any driver.
So to avoid its gating at late init we have to disable it in DT.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 2363593..e7aea2e 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -332,6 +332,7 @@ clocks {
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
 		clock-output-names = "msmcsram";
+		status = "disabled";
 		reg = <0x02350038 0xb00>, <0x0235001c 0x400>;
 		reg-names = "control", "domain";
 		domain-id = <7>;
-- 
1.8.3.2
