From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 19 Feb 2018 09:18:36 +0100
Subject: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
In-Reply-To: <20180219081837.15482-1-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
Message-ID: <20180219081837.15482-7-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timers use an offset between their physical and
virtual counters. That offset should be configured by the bootloader
in CNTVOFF.

However, the A83t bootloader fails to do so, and we end up with an
undefined offset (which in our case is random), meaning that each CPU
will have a different time, which isn't working very well.

Fix that by setting the arm,cpu-registers-not-fw-configured that will
make Linux use the physical timers instead of the virtual ones. One
possible side effect would be that the virtualization features would
be disabled. However, due to the way the GIC has been integrated in
the system, it is already unusable so we're effectively not losing any
feature.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e97a6d17b8d0..b9bdb891cf2f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -123,6 +123,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	clocks {
-- 
2.11.0
