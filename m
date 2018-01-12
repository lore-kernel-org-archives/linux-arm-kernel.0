From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 20:29:50 -0600
Subject: [PATCH v2 1/2] ARM: dts: da850-lego-ev3: Add node for reboot modes
In-Reply-To: <1515724191-30499-1-git-send-email-david@lechnology.com>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
Message-ID: <1515724191-30499-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new node for reboot modes on LEGO MINDSTORMS EV3. The EV3's
bootloader looks for a magic number in the ARM local RAM and if found,
it will boot into a special firmware update mode where the flash memory
can be written via USB.

This has been testing working using the command:

    # systemctl reboot loader

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 81942ae..2e85080 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -184,6 +184,23 @@
 		io-channel-names = "voltage", "current";
 		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
 	};
+
+	/* ARM local RAM */
+	memory at ffff0000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0xffff0000 0x2000>; /* 8k */
+
+		/*
+		 * The I2C bootloader looks for this magic value to either
+		 * boot normally or boot into a firmware update mode.
+		 */
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x1ffc>;
+			mode-normal = <0x00000000>;
+			mode-loader = <0x5555aaaa>;
+		};
+	};
 };
 
 &pmx_core {
-- 
2.7.4
