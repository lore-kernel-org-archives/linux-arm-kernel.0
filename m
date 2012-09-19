From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 19 Sep 2012 10:44:19 +0100
Subject: [PATCH 10/11] ARM: vexpress: Add config bus components and
 clocks to DTs
In-Reply-To: <50463FA4.90106@gmail.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
 <5045FAEC.6030906@gmail.com> <1346763920.2605.81.camel@hornet>
 <504610B4.6060902@gmail.com> <1346773023.20599.15.camel@hornet>
 <50463FA4.90106@gmail.com>
Message-ID: <1348047859.11116.48.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 18:51 +0100, Rob Herring wrote:
> I did say they are *supposed* to be optional, but the amba bus code
> essentially makes them required. Ideally, Linux doesn't dictate what
> goes in the dtb or not, but I don't have a problem if specific users of
> the clock binding require the names.

Ok, so how about such change in wording?

--- a/Documentation/devicetree/bindings/arm/primecell.txt
+++ b/Documentation/devicetree/bindings/arm/primecell.txt
@@ -13,17 +13,18 @@ Required properties:
 Optional properties:
 
 - arm,primecell-periphid : Value to override the h/w value with
-- clocks : From common clock binding. First clock is phandle to clock for apb
-       pclk. Additional clocks are optional and specific to those peripherals.
-- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
+- clocks : From common clock binding. One of the clocks should be a phandle to
+        clock for APB PCLK. Additional clocks are optional and specific to
+        those peripherals.
+- clock-names : From common clock binding. Required here if clocks are
+        defined. Shall be "apb_pclk" for the APB PCLK.
 
 Example:
 
 serial at fff36000 {
        compatible = "arm,pl011", "arm,primecell";
        arm,primecell-periphid = <0x00341011>;
-       clocks = <&pclk>;
-       clock-names = "apb_pclk";
-       
+       clocks = <&refclk>, <&pclk>;
+       clock-names = "uartclk", "apb_pclk";
 };



Also, maybe we could add a possibility of defining the APB clock for
whole APB "cluster" (as usually the same clock is shared across all
peripherals connected to a single AHB/APB bridge) using clock-ranges
parents? What I think about is something of this sort:

iofpga {
	clock-ranges;
	clocks = <&pclk>;
	clock-names = "apb_pclk";

	serial {
	        compatible = "arm,pl011", "arm,primecell";
		clocks = <&refclk>;
		clock-names = "uartclk";
	};
};

Cheers!

Pawel
