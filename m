From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 May 2013 19:55:59 -0700
Subject: [PATCH] ARM: dts: Fix musb interrupt for device tree booting
In-Reply-To: <20130511023557.GB28602@atomide.com>
References: <20130511023557.GB28602@atomide.com>
Message-ID: <20130511025558.GC28602@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ad871c10 (ARM: dts: OMAP: Add usb_otg and glue data to
OMAP3+ boards) added support for MUSB on omap3 for device tree,
but added the interrupts the wrong way probably as they were
copied from the omap4.dtsi file. On omap3 we have TI specific
interrupt controller, not GIC.

Fix this by specifying the interrupt following the TI INTC
binding.

Without this fix MUSB won't work as it is trying to use
irq0 instead of irq92.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---
Sorry had the wrong subject in the previous mail. That was
for the breaking commit. Here's the patch again with correct
subject.

--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -516,7 +516,7 @@
 		usb_otg_hs: usb_otg_hs at 480ab000 {
 			compatible = "ti,omap3-musb";
 			reg = <0x480ab000 0x1000>;
-			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupts = <92>, <93>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			multipoint = <1>;
