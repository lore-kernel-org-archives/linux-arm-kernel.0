From: leo.yan@linaro.org (Leo Yan)
Date: Mon,  3 Aug 2015 09:13:10 +0800
Subject: [RFC PATCH 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1438564390-28111-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Hi6220, below memory regions in DDR have specific purpose:

- 0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
- 0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
- 0x06df,f000 - 0x06df,ffff: For mailbox message data.

This patch reserves these memory regions and add device node for
mailbox in dts.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 20 +++++++++++++++++---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e36a539..1715f9d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -7,9 +7,6 @@
 
 /dts-v1/;
 
-/*Reserved 1MB memory for MCU*/
-/memreserve/ 0x05e00000 0x00100000;
-
 #include "hi6220.dtsi"
 
 / {
@@ -28,4 +25,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mcu-buf at 05e00000 {
+			no-map;
+			reg = <0x0 0x0740f000 0x0 0x00001000>,	/* MCU firmware section */
+			      <0x0 0x05e00000 0x0 0x00100000>;	/* MCU firmware buffer */
+		};
+
+		mbox-buf at 06dff000 {
+			no-map;
+			reg = <0x0 0x06dff000 0x0 0x00001000>;	/* Mailbox message buf */
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..b42a9b7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,5 +167,13 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		mailbox: mailbox {
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
