From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 23 Nov 2017 13:40:14 +0800
Subject: [PATCH] arm64: dts: Hi3660: Fix state id for 'CPU_NAP' state
Message-ID: <1511415614-9859-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
idle state. From ftrace log we can observe CA73 CPUs can be easily waken
up from 'CPU_NAP' state but the 'waken up' CPUs doesn't handle anything
and sleep again; so there have tons of trace events for CA73 CPUs
entering and exiting idle state.

On Hi3660 CA73 has retention state 'CPU_NAP' for CPU idle, this state we
set its psci parameter as '0x0000001' and from this parameter it can
calculate state id is 1. Unfortunately ARM trusted firmware (ARM-TF)
takes 1 as a invalid value for state id, so the CPU cannot enter idle
state and directly bail out to kernel.

This commit changes psci parameter to '0x00000000' for state id = 0;
this id is accepted by ARM trusted firmware and finally CPU can stay
properly in 'CPU_NAP' state.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ab0b95b..5666d29 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -147,7 +147,7 @@
 
 			CPU_NAP: cpu-nap {
 				compatible = "arm,idle-state";
-				arm,psci-suspend-param = <0x0000001>;
+				arm,psci-suspend-param = <0x0000000>;
 				entry-latency-us = <7>;
 				exit-latency-us = <2>;
 				min-residency-us = <15>;
-- 
2.7.4
