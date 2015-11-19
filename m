From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 19 Nov 2015 10:48:10 -0500
Subject: [PATCH 2/3] ARM: dts: enable clock support for Broadcom NSP
In-Reply-To: <564D1070.2040200@broadcom.com>
References: <1447888430-4451-1-git-send-email-jonmason@broadcom.com>
 <1447888430-4451-3-git-send-email-jonmason@broadcom.com>
 <564D1070.2040200@broadcom.com>
Message-ID: <20151119154810.GC23560@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 03:57:36PM -0800, Ray Jui wrote:
> Would this patch merge properly with the other NSP DT clean up patch
> + I2C DT patch that you worked out internally but have not sent out?
> 
> I thought it's going to make the maintainers' life easier if you can
> group DT changes per platform and send them out in the same series.
> 
> I also have some inline comments below.
> 
> On 11/18/2015 3:13 PM, Jon Mason wrote:
> >Replace current device tree dummy clocks with real clock support for
> >Broadcom Northstar Plus SoC
> >
> >Signed-off-by: Jon Mason <jonmason@broadcom.com>
> >---
> >  arch/arm/boot/dts/bcm-nsp.dtsi | 99 ++++++++++++++++++++++++++++++++----------
> >  1 file changed, 75 insertions(+), 24 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> >index 4bcdd28..f85a4f1 100644
> >--- a/arch/arm/boot/dts/bcm-nsp.dtsi
> >+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> >@@ -32,6 +32,7 @@
> >
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >+#include <dt-bindings/clock/bcm-nsp.h>
> >
> >  #include "skeleton.dtsi"
> >
> >@@ -42,7 +43,7 @@
> >
> >  	mpcore {
> >  		compatible = "simple-bus";
> >-		ranges = <0x00000000 0x19020000 0x00003000>;
> >+		ranges = <0x00000000 0x19000000 0x00023000>;
> 
> Why does this have anything to do with clocks? Shouldn't it be a
> separate patch?

No, this is correct (though the patch is a little odd to look at).
The a9pll starts at 0x19000000 instead of 0x19020000.  So, everything
needs to be adjusted.

> 
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> >
> >@@ -58,32 +59,23 @@
> >  			};
> >  		};
> >
> >-		L2: l2-cache {
> >-			compatible = "arm,pl310-cache";
> >-			reg = <0x2000 0x1000>;
> >-			cache-unified;
> >-			cache-level = <2>;
> >-		};
> >-
> >-		gic: interrupt-controller at 19021000 {
> >-			compatible = "arm,cortex-a9-gic";
> >-			#interrupt-cells = <3>;
> >-			#address-cells = <0>;
> >-			interrupt-controller;
> >-			reg = <0x1000 0x1000>,
> >-			      <0x0100 0x100>;
> >+		a9pll: arm_clk at 19000000 {
> >+			#clock-cells = <0>;
> >+			compatible = "brcm,nsp-armpll";
> >+			clocks = <&osc>;
> >+			reg = <0x00000 0x1000>;
> >  		};
> >
> >  		timer at 19020200 {
> >  			compatible = "arm,cortex-a9-global-timer";
> >-			reg = <0x0200 0x100>;
> >+			reg = <0x20200 0x100>;
> >  			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&periph_clk>;
> >  		};
> >
> >  		twd-timer at 19020600 {
> >  			compatible = "arm,cortex-a9-twd-timer";
> >-			reg = <0x0600 0x20>;
> >+			reg = <0x20600 0x20>;
> >  			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> >  						  IRQ_TYPE_LEVEL_HIGH)>;
> >  			clocks = <&periph_clk>;
> >@@ -91,11 +83,27 @@
> >
> >  		twd-watchdog at 19020620 {
> >  			compatible = "arm,cortex-a9-twd-wdt";
> >-			reg = <0x0620 0x20>;
> >+			reg = <0x20620 0x20>;
> >  			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> >  						  IRQ_TYPE_LEVEL_HIGH)>;
> >  			clocks = <&periph_clk>;
> >  		};
> >+
> >+		gic: interrupt-controller at 19021000 {
> >+			compatible = "arm,cortex-a9-gic";
> >+			#interrupt-cells = <3>;
> >+			#address-cells = <0>;
> >+			interrupt-controller;
> >+			reg = <0x21000 0x1000>,
> >+			      <0x20100 0x100>;
> >+		};
> >+
> >+		L2: l2-cache {
> >+			compatible = "arm,pl310-cache";
> >+			reg = <0x22000 0x1000>;
> >+			cache-unified;
> >+			cache-level = <2>;
> >+		};
> 
> From here and above, all labels are wrong. You are moving them into
> a bus that has translated bus addresses, but you still use absolute
> addresses for all labels.
> 
> And again, 1) Why is this change imbedded in a patch meant for
> adding DT clock support according to the commit message; 2) how does
> the dependency work with the other patches that you are about to
> send out?

This was already discussed in the original series.  See
http://www.spinics.net/lists/arm-kernel/msg451580.html


> 
> 
> >  	};
> >
> >  	clocks {
> >@@ -103,10 +111,34 @@
> >  		#size-cells = <1>;
> >  		ranges;
> >
> >-		periph_clk: periph_clk {
> >+		osc: oscillator {
> >+			#clock-cells = <0>;
> >  			compatible = "fixed-clock";
> >+			clock-frequency = <25000000>;
> >+		};
> >+
> >+		iprocmed: iprocmed {
> >+			#clock-cells = <0>;
> >+			compatible = "fixed-factor-clock";
> >+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
> >+			clock-div = <2>;
> >+			clock-mult = <1>;
> >+		};
> >+
> >+		iprocslow: iprocslow {
> >+			#clock-cells = <0>;
> >+			compatible = "fixed-factor-clock";
> >+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
> >+			clock-div = <4>;
> >+			clock-mult = <1>;
> >+		};
> >+
> >+		periph_clk: periph_clk {
> >  			#clock-cells = <0>;
> >-			clock-frequency = <500000000>;
> >+			compatible = "fixed-factor-clock";
> >+			clocks = <&a9pll>;
> >+			clock-div = <2>;
> >+			clock-mult = <1>;
> >  		};
> >  	};
> >
> >@@ -118,17 +150,17 @@
> >
> >  		uart0: serial at 18000300 {
> >  			compatible = "ns16550a";
> >-			reg = <0x0300 0x100>;
> >+			reg = <0x000300 0x100>;
> >  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> >-			clock-frequency = <62499840>;
> >+			clocks = <&osc>;
> >  			status = "disabled";
> >  		};
> >
> >  		uart1: serial at 18000400 {
> >  			compatible = "ns16550a";
> >-			reg = <0x0400 0x100>;
> >+			reg = <0x000400 0x100>;
> >  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> >-			clock-frequency = <62499840>;
> >+			clocks = <&osc>;
> >  			status = "disabled";
> >  		};
> >
> >@@ -217,5 +249,24 @@
> >
> >  			brcm,nand-has-wp;
> >  		};
> >+
> >+		lcpll0: lcpll0 at 1803f100 {
> 
> wrong label
> 
> >+			#clock-cells = <1>;
> >+			compatible = "brcm,nsp-lcpll0";
> >+			reg = <0x03f100 0x14>;
> >+			clocks = <&osc>;
> >+			clock-output-names = "lcpll0", "pcie_phy", "sdio",
> >+					     "ddr_phy";
> >+		};
> >+
> >+		genpll: genpll at 1803f140 {
> 
> wrong label
> 
> >+			#clock-cells = <1>;
> >+			compatible = "brcm,nsp-genpll";
> >+			reg = <0x03f140 0x24>;
> >+			clocks = <&osc>;
> >+			clock-output-names = "genpll", "phy", "ethernetclk",
> >+					     "usbclk", "iprocfast", "sata1",
> >+					     "sata2";
> >+		};
> >  	};
> >  };
> >
