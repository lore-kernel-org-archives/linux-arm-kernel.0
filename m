From: john.stultz@linaro.org (John Stultz)
Date: Mon, 22 Aug 2016 15:48:04 -0700
Subject: [PATCH 3/4] arm64: dts: hikey: Add hikey support for
 syscon-reboot-mode
In-Reply-To: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
References: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1471906085-16682-3-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to hikey dts for the syscon-reboot-mode driver.

After trying an approach using a sram driver and node, a number
of issues cropped up which would make it so we would be
duplicating a lot of extra syscon infrastructure in order to
support mfds on sram. After talking with Bjorn, using the
syscon driver for this seems like an better choice.

Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 8597e9b..4492a15 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -29,6 +29,7 @@
 	 * Reserve below regions from memory node:
 	 *
 	 *  0x05e0,0000 - 0x05ef,ffff: MCU firmware runtime using
+	 *  0x05f0,1000 - 0x05f0,1fff: Reboot reason
 	 *  0x06df,f000 - 0x06df,ffff: Mailbox message data
 	 *  0x0740,f000 - 0x0740,ffff: MCU firmware section
 	 *  0x3e00,0000 - 0x3fff,ffff: OP-TEE
@@ -36,11 +37,26 @@
 	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
-		      <0x00000000 0x05f00000 0x00000000 0x00eff000>,
+		      <0x00000000 0x05f00000 0x00000000 0x00001000>,
+		      <0x00000000 0x05f02000 0x00000000 0x00efd000>,
 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
 		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
 	};
 
+	reboot-mode-syscon at 5f01000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x05f01000 0x0 0x00001000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x0>;
+
+			mode-normal	= <0x77665501>;
+			mode-bootloader	= <0x77665500>;
+			mode-recovery	= <0x77665502>;
+		};
+	};
+
 	soc {
 		spi0: spi at f7106000 {
 			status = "ok";
-- 
1.9.1
