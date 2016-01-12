From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 12 Jan 2016 12:35:47 +0000
Subject: [PATCH V2 2/3] ARM: bcm2835: I2S: use new register-range and clock
 framework
In-Reply-To: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Since the move to the new clock framework with commit 94cb7f76caa0
("ARM: bcm2835: Switch to using the new clock driver support.")
the bcm2835-i2s driver was no longer working.

This patch fixes the address ranges:
* remove the PCM clock register range that is owned by the clockmanager
* fix the length, which did not include the last register of this device

It also adds the required pcm-clock.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..83d9787 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -120,9 +120,8 @@
 
 		i2s: i2s at 7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
-
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PCM>;
 			dmas = <&dma 2>,
 			       <&dma 3>;
 			dma-names = "tx", "rx";
-- 
1.7.10.4
