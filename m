From: joel@jms.id.au (Joel Stanley)
Date: Wed, 14 Mar 2018 17:43:12 +1030
Subject: [PATCH] ARM: dts: aspeed: Add default memory node
Message-ID: <20180314071312.17492-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we removed the inclusion of skeleton.dtsi from the device trees, we
broke booting for systems with bootloaders that aren't device tre aware.
This can be seen, for example, when appending the device tree blob to
the kernel image.

The reason booting broke was that the kernel lacked the device_type
label in the memory node. Add in a default memory node wth the
device_type. It can contain the memory address as the location is fixed
for each SoC generation, but the size needs to be added by the
bootloader or the board specific dts.

Fixes: 73102d6fdc32 ("ARM: dts: aspeed: Remove skeleton.dtsi")
Cc: <stable@vger.kernel.org>
Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Arnd, can you please merge this as a fix for 4.16?

 arch/arm/boot/dts/aspeed-g4.dtsi | 5 +++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 36ae23aa3b48..518d2bc7c7fc 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -42,6 +42,11 @@
 		};
 	};
 
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17ee0fa33a14..f9917717dd08 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -42,6 +42,11 @@
 		};
 	};
 
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.15.1
