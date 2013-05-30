From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 22:07:39 -0600
Subject: [PATCH] ARM: bcm2835: override the HW UART periphid
Message-ID: <1369886859-22114-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongsung Kim <neidhard.kim@lge.com>

Stephen Warren reported the recent commit 78506f2 (add support for
extended FIFO-size of PL011-r1p5) breaks the serial port on the
BCM2835 ARM SoC.

A UART compatible with the ARM PL011-r1p5 should have 32-deep FIFOs.
The BCM2835 UART just looks like an ARM PL011-r1p5, but has 16-deep
FIFOs just like PL011-r1p4 or earlier revisions. As a workaround for
this compatibility issue, this patch overrides the HW UART periphid
register values with the actually compatible UART periphid 0x00241011
(r1p3 or r1p4).

Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is a fix for v3.10-rc*.

 arch/arm/boot/dts/bcm2835.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index f0052dc..1e12aef 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -44,6 +44,7 @@
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
 			clock-frequency = <3000000>;
+			arm,primecell-periphid = <0x00241011>;
 		};
 
 		gpio: gpio {
-- 
1.7.10.4
