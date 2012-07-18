From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Jul 2012 12:13:16 +0200
Subject: [RFC PATCHv3 2/2] ARM: socfpga: Add DTS bindings for Altera's
 SOCFPGA
In-Reply-To: <20120718091617.572070c2@skate>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-3-git-send-email-dinguyen@altera.com>
 <20120718091617.572070c2@skate>
Message-ID: <20120718101316.GB7607@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +	soc {
> > +		amba {
> > +			compatible = "arm,amba-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			pdma: pdma at ffe01000 {
> > +				compatible = "arm,pl330", "arm,primecell";
> > +				reg = <0xffe01000 0x1000>;
> > +				interrupts = <0 180 4>;
> > +			};
> > +		};
> > +
> > +		apb_periphs {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			gmac0: stmmac at ff700000 {
> > +				compatible = "st,spear600-gmac";
> > +				reg = <0xff700000 0x2000>;
> > +				interrupts = <0 115 4>;
> > +				interrupt-names = "macirq";
> > +				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> > +				phy-mode = "gmii";
> > +			};
> > +		};
> 
> Are the pdma and gmac0 really specific to the cyclone board? Aren't
> they similar to the uarts and timers in that they are part of the SoC
> itself?

I guess they are not. I'm not dts expert, but would something like
this be suitable? It boots :-). 

									Pavel

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 903d4bb..ee13a3e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -115,5 +115,27 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 		};
+
+		gmac0: stmmac at ff700000 {
+			compatible = "st,spear600-gmac";
+			reg = <0xff700000 0x2000>;
+			interrupts = <0 115 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+			phy-mode = "gmii";
+		};
+
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma: pdma at ffe01000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0xffe01000 0x1000>;
+				interrupts = <0 180 4>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 3433ee3..683d035 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -37,35 +37,4 @@
 		device_type = "memory";
 		reg = <0x0 0x10000000>; /* 256MB */
 	};
-
-	soc {
-		amba {
-			compatible = "arm,amba-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma: pdma at ffe01000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0xffe01000 0x1000>;
-				interrupts = <0 180 4>;
-			};
-		};
-
-		apb_periphs {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			gmac0: stmmac at ff700000 {
-				compatible = "st,spear600-gmac";
-				reg = <0xff700000 0x2000>;
-				interrupts = <0 115 4>;
-				interrupt-names = "macirq";
-				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-				phy-mode = "gmii";
-			};
-		};
-	};
 };


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
