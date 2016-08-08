From: john.stultz@linaro.org (John Stultz)
Date: Mon,  8 Aug 2016 16:48:40 -0700
Subject: [RFC][PATCH 4/4 v2] arm64: dts: hikey: Add pstore support for HiKey
In-Reply-To: <CAGXu5j+UHuTDT=_DXcKHdxM0CWAp7kkwYiDSenbqk7Ub7yXX6w@mail.gmail.com>
References: <CAGXu5j+UHuTDT=_DXcKHdxM0CWAp7kkwYiDSenbqk7Ub7yXX6w@mail.gmail.com>
Message-ID: <1470700120-26510-1-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reserves some memory in the DTS and sets up a
pstore device tree node to enable pstore support on HiKey.

Cc: Kees Cook <keescook@chromium.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Quick rework to update to new ramoops format.

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index b2683e4..748d0dc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -32,6 +32,7 @@
 	 *  0x05f0,1000 - 0x05f0,1fff: Reboot reason
 	 *  0x06df,f000 - 0x06df,ffff: Mailbox message data
 	 *  0x0740,f000 - 0x0740,ffff: MCU firmware section
+	 *  0x21f0,0000 - 0x21ff,ffff: pstore/ramoops buffer
 	 *  0x3e00,0000 - 0x3fff,ffff: OP-TEE
 	 */
 	memory at 0 {
@@ -40,9 +41,25 @@
 		      <0x00000000 0x05f00000 0x00000000 0x00001000>,
 		      <0x00000000 0x05f02000 0x00000000 0x00efd000>,
 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
-		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
+		      <0x00000000 0x07410000 0x00000000 0x1aaf0000>,
+		      <0x00000000 0x22000000 0x00000000 0x1c000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops at 0x21f00000 {
+			compatible = "ramoops";
+			reg = <0x0 0x21f00000 0x0 0x00100000>;
+			record-size	= <0x00020000>;
+			console-size	= <0x00020000>;
+			ftrace-size	= <0x00020000>;
+		};
+	};
+
+
 	reboot-mode-syscon at 5f01000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x0 0x05f01000 0x0 0x00001000>;
-- 
1.9.1
