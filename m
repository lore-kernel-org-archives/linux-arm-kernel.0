From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 09:21:29 +0100
Subject: [PATCH 4/6] ARM: at91/dt: add SRAM nodes
In-Reply-To: <54B476EC.3090207@atmel.com>
References: <1421089317-12607-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421089317-12607-5-git-send-email-alexandre.belloni@free-electrons.com>
 <54B476EC.3090207@atmel.com>
Message-ID: <20150113082129.GA4104@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2015 at 09:37:48 +0800, Bo Shen wrote :
> Hi Alexandre,
> 
> On 01/13/2015 03:01 AM, Alexandre Belloni wrote:
> >
> >+	sram0: sram at 002ff000 {
> 
> Why here is 002ff000, while not 00200000?
> 
> >+		compatible = "mmio-sram";
> >+		reg = <0x00200000 0x2000>;
> >+	};
> >+

I'll correct that one. I followed what was done before. The sam9260 has
two banks, one at 0x00200000, and the other one at 0x00300000. Thanks to
address mirroring on the range, we can declare that as one contiguous
range of sram, starting at 0x002ff000.


> >  	ahb {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
> >diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
> >index cdb9ed612109..e247b0b5fdab 100644
> >--- a/arch/arm/boot/dts/at91sam9261.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9261.dtsi
> >@@ -60,6 +60,11 @@
> >  		};
> >  	};
> >
> >+	sram: sram at 00300000 {
> >+		compatible = "mmio-sram";
> >+		reg = <0x00300000 0x28000>;
> >+	};
> >+
> >  	ahb {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
> >diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> >index ef8a70c27439..8a210d5033b1 100644
> >--- a/arch/arm/boot/dts/at91sam9263.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9263.dtsi
> >@@ -62,6 +62,16 @@
> >  		};
> >  	};
> >
> >+	sram0: sram at 00300000 {
> >+		compatible = "mmio-sram";
> >+		reg = <0x00300000 0x14000>;
> >+	};
> >+
> >+	sram1: sram at 00500000 {
> >+		compatible = "mmio-sram";
> >+		reg = <0x00300000 0x4000>;
> >+	};
> >+
> >  	ahb {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
> >diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> >index a50ee587a7af..9012fe9d7758 100644
> >--- a/arch/arm/boot/dts/at91sam9g20.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> >@@ -16,6 +16,15 @@
> >  		reg = <0x20000000 0x08000000>;
> >  	};
> >
> >+	sram0: sram at 002ff000 {
> 
> Why here is 002ff000, while not 00200000?
> 
> >+		status = "disabled";
> 
> Btw, why it needs set to disabled.
> 
> >+	};
> >+
> >+	sram1: sram at 002fc000 {
> 
> Why here is 002fc000, while not 00300000? And length is on 0x4000.
> 

The same here, because we use mirroring, we have to disable the one that
is coming from at91sam9260.dtsi and then declare another one. I'll
correct the addresses in the reg properties. I was first declaring two
banks but we chose to switch back to only one range.

> >+		compatible = "mmio-sram";
> >+		reg = <0x00200000 0x8000>;
> >+	};
> >+

Thanks for the review.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
