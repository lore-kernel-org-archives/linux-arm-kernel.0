From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 08:58:13 +0800
Subject: [PATCH v2 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
References: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1444697896-4323-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Hi6220, below memory regions in DDR have specific purpose:

  0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
  0x06df,f000 - 0x06df,ffff: For mailbox message data;
  0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
  0x3e00,0000 - 0x3fff,ffff: For OP-TEE.

This patch reserves these memory regions in DT.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

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
-- 
1.9.1
