From: cinifr@gmail.com (Fan Rong)
Date: Fri, 18 Oct 2013 00:37:07 +0800
Subject: [Add SMP support for Allwinner A20: PATCH V5 3/3] Add arch count
 timer node in dts for Allwinner A20(sunxi 7i).
In-Reply-To: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
References: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
Message-ID: <1382027827-10080-4-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux kernel usually use virtual arch timer for smp cpu tick. But the arch timer register VCTOFF normally is very different between the two cpus in A20 afer hardware reset, so SMP Cpus will see different time tick. It will cause kernel crash currently. You have two choices to fix it: 1 Simpley use physical arch timer, 2 Set VCTOFF to same value for each cpu in bootloader. The first choice will cause some other problem for kernel, especially for KVM, guest OS want to use virtual arch timer. So the second choice is perfect. So if you want to use arch timer for smp cpu tick, you must ensure you bootload have set same VCTOFF for all cpus.

Signed-off-by: Fan Rong <cinifr@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6543b3f..dc01d5a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -410,5 +410,15 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+
+		timer {
+			compatible ="arm,armv7-timer";
+			interrupts = <1 13 0x308>,
+				     <1 14 0x308>,
+				     <1 11 0x308>,
+				     <1 10 0x308>;
+			clock-frequency = <24000000>;
+		};
+
 	};
 };
-- 
1.8.1.2
