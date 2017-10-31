From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 31 Oct 2017 23:23:16 +0100
Subject: [PATCH 2/2] ARM: dts: meson8: add more L2 cache settings
In-Reply-To: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
References: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171031222316.24548-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic's vendor kernel prints these PL310 L2 cache controller settings
during boot:
  8 ways, 4096 sets, CACHE_ID 0x4100a0c9,  Cache size: 1048576 B
  AUX_CTRL 0x7ec80001, PERFETCH_CTRL 0x71000007, POWER_CTRL  0x00000000
  TAG_LATENCY 0x00000111, DATA_LATENCY 0x00000222

Add the "prefetch-data", "prefetch-instr" and "arm,shared-override"
properties to get the same L2 cache controller configuration as the
vendor kernel.
Two differences still remain:
- L310_AUX_CTRL_NS_INT_CTRL is currently not supported by the cache-l2x0
driver
- bit 23 is set by the vendor kernel, but this is defined in cache-l2x0.h

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index bedcbebc2433..264f2b80e2af 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -313,6 +313,9 @@
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
