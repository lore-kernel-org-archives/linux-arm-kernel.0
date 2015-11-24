From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:06 +0200
Subject: [PATCH 05/14] ARM: am437x: cm-t43: dts: add NAND support
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-6-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the CompuLab cm-t43 configurations comes with on-board NAND flash as
primary storage. It is partitioned into kernel, dtb, and rootfs partitions.
Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 0761383..370e4e8 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -54,6 +54,80 @@
 		>;
 	};
 
+	nand_flash_x8: nand_flash_x8 {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x800, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x804, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x808, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x80c, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x810, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x814, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x818, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x81c, PIN_INPUT | PULL_DISABLE | MUX_MODE0)
+			AM4372_IOPAD(0x870, PIN_INPUT_PULLUP  | MUX_MODE0)
+			AM4372_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x898, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM4372_IOPAD(0x894, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM4372_IOPAD(0x890, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM4372_IOPAD(0x89c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_flash_x8>;
+	ranges = <0 0 0x08000000 0x1000000>;
+	nand at 0,0 {
+		reg = <0 0 0>;
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		gpmc,wait-pin = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* MTD partition table */
+		partition at 0 {
+			label = "kernel";
+			reg = <0x0 0x00980000>;
+		};
+		partition at 980000 {
+			label = "dtb";
+			reg = <0x00980000 0x00080000>;
+		};
+		partition at a00000 {
+			label = "rootfs";
+			reg = <0x00a00000 0x0>;
+		};
+	};
 };
 
 &i2c0 {
@@ -187,6 +261,10 @@
 	};
 };
 
+&elm {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
