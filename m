From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 21:28:02 +0900
Subject: [PATCH v5 4/8] ARM: shmobile: r7s72100: Add MTU2 device to DT
In-Reply-To: <20140715122308.GC25333@verge.net.au>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1404911564-17380-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140715114741.GB25333@verge.net.au> <4380270.nzol65dDjU@avalon>
 <20140715122308.GC25333@verge.net.au>
Message-ID: <20140715122801.GF25333@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 09:23:09PM +0900, Simon Horman wrote:
> On Tue, Jul 15, 2014 at 01:55:25PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Tuesday 15 July 2014 20:47:41 Simon Horman wrote:
> > > On Wed, Jul 09, 2014 at 03:12:40PM +0200, Laurent Pinchart wrote:
> > > > Add the MTU2 counter to the r7s72100 device tree and make it disabled by
> > > > default.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/r7s72100.dtsi | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> > > > b/arch/arm/boot/dts/r7s72100.dtsi index bdee225..c902b0b 100644
> > > > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > > > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > > > @@ -229,6 +229,16 @@
> > > >  		status = "disabled";
> > > >  	};
> > > > 
> > > > +	mtu2: timer at fcff0000 {
> > > > +		compatible = "renesas,mtu2";
> > > > +		reg = <0xfcff0000 0x400>;
> > > > +		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		interrupt-names = "tgi0a";
> > > > +		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
> > > > +		clock-names = "fck";
> > > > +		status = "disabled";
> > > > +	};
> > > > +
> > > >  	scif0: serial at e8007000 {
> > > >  		compatible = "renesas,scif-r7s72100", "renesas,scif";
> > > >  		reg = <0xe8007000 64>;
> > > 
> > > I believe that I claimed to have tested this in the past but that
> > > my testing was by booting a config to userspace that as it happens
> > > did not require to timer to get that far.
> > > 
> > > I now believe there is a minor error: the interrupt number should be
> > > (139 - 32 =) 107 rather than 139.
> > > 
> > > This allows a system with this and the related genmai patch applied
> > > on top of renesas-next-v3.16-rc3-20140715 to boot to uerspace
> > > when compiled with shmobile_defconfig (+ an initrd).
> > > Without the irq number change the boot gets stuck in
> > > ip_auto_config (which presumably sleeps).
> > > 
> > > Laurent, should I squash the following in and queue-up the result?
> > 
> > Please do, and sorry for the mistake.
> 
> Not at all. I've made the same one several times myself.
> 
> > > diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> > > b/arch/arm/boot/dts/r7s72100.dtsi index c902b0b..1d28d01 100644
> > > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > > @@ -232,7 +232,7 @@
> > >  	mtu2: timer at fcff0000 {
> > >  		compatible = "renesas,mtu2";
> > >  		reg = <0xfcff0000 0x400>;
> > > -		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
> > > +		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
> > >  		interrupt-names = "tgi0a";
> > >  		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
> > >  		clock-names = "fck";

For reference I have queued up the following.


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

ARM: shmobile: r7s72100: Add MTU2 device to DT

Add the MTU2 counter to the r7s72100 device tree and make it disabled by
default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[horms+renesas at verge.net.au correct irq number]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index bdee225..1d28d01 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -229,6 +229,16 @@
 		status = "disabled";
 	};
 
+	mtu2: timer at fcff0000 {
+		compatible = "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tgi0a";
+		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
 	scif0: serial at e8007000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8007000 64>;
-- 
2.0.0
