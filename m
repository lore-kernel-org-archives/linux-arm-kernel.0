From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 15 Sep 2015 22:37:57 +0800
Subject: [PATCH v3 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1442327877-2620-1-git-send-email-leo.yan@linaro.org>
References: <1442327877-2620-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1442327877-2620-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Hi6220, below memory regions in DDR have specific purpose:

  0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
  0x06df,f000 - 0x06df,ffff: For mailbox message data;
  0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
  0x3e00,0000 - 0x3fff,ffff: For OP-TEE.

This patch reserves these memory regions and add device node for
mailbox in dts.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e36a539..e3f4cb3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -7,9 +7,6 @@
 
 /dts-v1/;
 
-/*Reserved 1MB memory for MCU*/
-/memreserve/ 0x05e00000 0x00100000;
-
 #include "hi6220.dtsi"
 
 / {
@@ -24,8 +21,19 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	/*
+	 * Reserve below regions from memory node:
+	 *
+	 *  - 0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
+	 *  - 0x06df,f000 - 0x06df,ffff: Mailbox message data
+	 *  - 0x0740,f000 - 0x0740,ffff: MCU firmware section
+	 *  - 0x3e00,0000 - 0x3fff,ffff: OP-TEE
+	 */
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
+		reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
+		      <0x00000000 0x05f00000 0x00000000 0x00eff000>,
+		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
+		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..9ff25bc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,5 +167,13 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		mailbox: mailbox at f7510000 {
+			#mbox-cells = <1>;
+			compatible = "hisilicon,hi6220-mbox";
+			reg = <0x0 0xf7510000 0x0 0x1000>, /* IPC_S */
+			      <0x0 0x06dff800 0x0 0x0800>; /* Mailbox buffer */
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
1.9.1
