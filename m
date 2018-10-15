From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 15 Oct 2018 18:28:32 +0200
Subject: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
In-Reply-To: <20181015162833.7544-1-jbrunet@baylibre.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
Message-ID: <20181015162833.7544-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
was merged Amlogic's boards using mainline u-boot started showing the
following warning:

WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : reserve_memblock_reserved_regions+0xd8/0x144
lr : reserve_memblock_reserved_regions+0xd0/0x144
[...]

This is due to u-boot setting some /reservedmem/ region while our
dts declares reserved memory on the same region with no-map.

The conflict produce the warning. This is fixed by using /reservedmem/
in our dts as well, which is probably something we should have done from
the beginning.

Cc: stable at vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Kevin,

I would have liked to put a Fixes tag above but I could not figure out
which commit to pick, considering how much we changed those regions in
the past. If you have suggestion, I'll be happy to repost this patch.
If you prefer, feel free to amend this patch directly.

Cheers
Jerome

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 24 +++++--------------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
 2 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 178d8e8c56b8..06a06f11f114 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,6 +13,12 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
+/* 16 MiB reserved for Hardware ROM Firmware */
+/memreserve/ 0x0 0x1000000;
+
+/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x05000000 0x300000;
+
 / {
 	compatible = "amlogic,meson-axg";
 
@@ -115,24 +121,6 @@
 		method = "smc";
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		/* 16 MiB reserved for Hardware ROM Firmware */
-		hwrom_reserved: hwrom at 0 {
-			reg = <0x0 0x0 0x0 0x1000000>;
-			no-map;
-		};
-
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon at 5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 676a995fb912..23e879b29b1e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -13,6 +13,15 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+/* 16 MiB reserved for Hardware ROM Firmware */
+/memreserve/ 0x0 0x1000000;
+
+/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x10000000 0x200000;
+
+/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+/memreserve/ 0x05000000 0x300000;
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
@@ -23,24 +32,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		/* 16 MiB reserved for Hardware ROM Firmware */
-		hwrom_reserved: hwrom at 0 {
-			reg = <0x0 0x0 0x0 0x1000000>;
-			no-map;
-		};
-
-		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon at 10000000 {
-			reg = <0x0 0x10000000 0x0 0x200000>;
-			no-map;
-		};
-
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved_alt: secmon at 5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
-
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-- 
2.17.2
