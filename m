From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 1 Apr 2014 08:23:06 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <5339A036.6090703@codethink.co.uk>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <5339A036.6090703@codethink.co.uk>
Message-ID: <20140401062306.GS17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 06:04:54PM +0100, Ben Dooks wrote:
> On 31/03/14 17:41, Sylwester Nawrocki wrote:
> >This function adds a helper function to configure clock parents and rates
> >as specified in clock-parents, clock-rates DT properties for a consumer
> >device and a call to it before driver is bound to a device.
> 
> [snip]
> 
> tree/bindings/clock/clock-bindings.txt
> b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >index 700e7aa..59fbb4e 100644
> >--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >@@ -132,3 +132,45 @@ clock signal, and a UART.
> >    ("pll" and "pll-switched").
> >  * The UART has its baud clock connected the external oscillator and its
> >    register clock connected to the PLL clock (the "pll-switched" signal)
> >+
> >+==Assigned clock parents and rates==
> >+
> >+Some platforms require static initial configuration of parts of the clocks
> >+controller. Such a configuration can be specified in a clock consumer node
> >+through clock-parents and clock-rates DT properties. The former should
> >+contain a list of parent clocks in form of phandle and clock specifier pairs,
> >+the latter the list of assigned clock frequency values (one cell each).
> >+
> >+    uart at a000 {
> >+        compatible = "fsl,imx-uart";
> >+        reg = <0xa000 0x1000>;
> >+        ...
> >+        clocks = <&clkcon 0>, <&clkcon 3>;
> >+        clock-names = "baud", "mux";
> >+
> >+        clock-parents = <0>, <&pll 1>;
> >+        clock-rates = <460800>;
> >+    };
> >+
> >+In this example the pll is set as parent of "mux" clock and frequency of "baud"
> >+clock is specified as 460800 Hz.
> >+
> >+Configuring a clock parent and rate through the device node that uses
> >+the clock can be done only for clocks that have a single user. Specifying
> >+conflicting parent or rate configuration in multiple consumer nodes for
> >+a shared clock is forbidden.
> >+
> >+Configuration of common clocks, which affect multiple consumer devices
> >+can be specified in a dedicated 'assigned-clocks' subnode of a clock
> >+provider node, e.g.:
> >+
> >+    clkcon {
> >+        ...
> >+        #clock-cells = <1>;
> >+
> >+        assigned-clocks {
> >+            clocks = <&clkcon 16>, <&clkcon 17>;
> >+            clock-parents = <0>, <&clkcon 1>;
> >+            clock-rates = <200000>;
> >+        };
> >+    };
> 
> How do you support not-setting a rate for a clock?

Not setting a rate is supported by specifying the rate to 0. That should
be documented of course.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
