From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 31 Oct 2017 23:23:15 +0100
Subject: [PATCH 1/2] ARM: dts: meson8b: add more L2 cache settings
In-Reply-To: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
References: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171031222316.24548-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic's vendor kernel prints these PL310 L2 cache controller settings
during boot:
  8 ways, 2048 sets, CACHE_ID 0x4100a0c9,  Cache size: 524288 B
  AUX_CTRL 0x7ec60001, PERFETCH_CTRL 0x75000007, POWER_CTRL  0x00000000
  TAG_LATENCY 0x00000111, DATA_LATENCY 0x00000222

Add the "prefetch-data", "prefetch-instr" and "arm,shared-override"
properties to get the same L2 cache controller configuration as the
vendor kernel.
Four differences still remain:
- L310_AUX_CTRL_EARLY_BRESP is enabled by the vendor kernel, however
  this is only supported on Cortex-A9 cores (Meson8b has Cortex-A5 cores
  though)
- L310_AUX_CTRL_NS_INT_CTRL is currently not supported by the cache-l2x0
  driver
- bit 23 is set by the vendor kernel, but this is defined in cache-l2x0.h
- L310_AUX_CTRL_FULL_LINE_ZERO is enabled by the vendor kernel which is
  also only supported on Cortex-A9 cores

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 554c58e67b01..71466077890e 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -223,6 +223,9 @@
 	arm,data-latency = <3 3 3>;
 	arm,tag-latency = <2 2 2>;
 	arm,filter-ranges = <0x100000 0xc0000000>;
+	prefetch-data = <1>;
+	prefetch-instr = <1>;
+	arm,shared-override;
 };
 
 &pwm_ab {
-- 
2.15.0
