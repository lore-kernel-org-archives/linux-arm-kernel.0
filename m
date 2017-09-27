From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:16:53 +0200
Subject: [PATCH 2/4] ARM: dts: integratorap: Fix PCI windows
In-Reply-To: <20170927211655.3687-1-linus.walleij@linaro.org>
References: <20170927211655.3687-1-linus.walleij@linaro.org>
Message-ID: <20170927211655.3687-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes up several errors and additions in the
PCIv3 ranges:
- The I/O space is 64KB and translates from 61000000 to
  00000000.
- The non-prefetched and prefected memories are 1:1 mapped
  according to ARM DUI 0098A page 5-9 and should be like
  that in the device tree as well.
- We also add the DMA ranges, in the manual these are
  described as "PCI to local bus windows" on page 5-12 ff.
- Set the bus range to 0x00-0xff.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 152d59821db0..ecca38b43f83 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -157,18 +157,22 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0x62000000 0x10000>;
+		/* Bridge registers and config access space */
+		reg = <0x62000000 0x10000>, <0x61000000 0x01000000>;
 		interrupt-parent = <&pic>;
 		interrupts = <17>; /* Bus error IRQ */
 		clocks = <&pciclk>;
-		ranges = <0x00000000 0 0x61000000 /* config space */
-			0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
-			0x01000000 0 0x0 /* I/O space */
-			0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
-			0x02000000 0 0x00000000 /* non-prefectable memory */
-			0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
-			0x42000000 0 0x10000000 /* prefetchable memory */
-			0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
+		bus-range = <0x00 0xff>;
+		ranges = <0x01000000 0 0x0000000 /* I/O space @00000000 */
+			0x60000000 0 0x00010000 /* 64 KB @ LB 60000000 */
+			0x02000000 0 0x40000000 /* non-prefectable memory @40000000 */
+			0x40000000 0 0x10000000 /* 256 MiB @ LB 40000000 1:1 */
+			0x42000000 0 0x50000000 /* prefetchable memory @50000000 */
+			0x50000000 0 0x10000000>; /* 256 MiB @ LB 50000000 1:1 */
+		dma-ranges = <0x02000000 0 0x20000000 /* EBI memory space */
+			0x20000000 0 0x20000000 /* 512 MB @ LB 20000000 1:1 */
+			0x02000000 0 0x80000000 /* Core module alias memory */
+			0x80000000 0 0x40000000>; /* 1GB @ LB 80000000 */
 		interrupt-map-mask = <0xf800 0 0 0x7>;
 		interrupt-map = <
 		/* IDSEL 9 */
-- 
2.13.5
