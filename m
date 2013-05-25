From: adam@baker-net.org.uk (Adam Baker)
Date: Sat, 25 May 2013 22:32:04 +0100
Subject: Kirkwood CPU Freq driver
Message-ID: <51A12DD4.9010907@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been trying to test Andrew Lunn's work creating a CPU Idle driver 
for Kirkwood. The first problem I encountered was that somehow in 
merging the patch the ARCH_HAS_CPUFREQ line appears to have got lost in 
arch/arm/Kconfig so I put that back (this may not be an issue if you 
build a multiarch kernel but I was targetting just Kirkwood)

--- a/arch/arm/Kconfig	2013-05-24 19:45:59.000000000 +0100
+++ b/arch/arm/Kconfig	2013-05-17 19:58:21.000000000 +0100
@@ -567,6 +567,7 @@ config ARCH_DOVE

  config ARCH_KIRKWOOD
  	bool "Marvell Kirkwood"
+	select ARCH_HAS_CPUFREQ
  	select ARCH_REQUIRE_GPIOLIB
  	select CPU_FEROCEON
  	select GENERIC_CLOCKEVENTS

Then I saw that the driver needs a cpu definition and none of the 
kirkwood dts files provide one. I believe all kirkwood SoCs are 
uniprocessor so I created an entry in kirkwood.dtsi

--- a/arch/arm/boot/dts/kirkwood.dtsi	2013-05-19 22:57:07.000000000 +0100
+++ b/arch/arm/boot/dts/kirkwood.dtsi	2013-05-19 23:10:32.000000000 +0100
@@ -4,6 +4,18 @@
  	compatible = "marvell,kirkwood";
  	interrupt-parent = <&intc>;

+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+		      device_type = "cpu";
+		      compatible = "marvell,feroceon";
+		      clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
+		      clock-names = "cpu_clk", "ddrclk", "powersave";
+		};
+	};
+
  	aliases {
  	       gpio0 = &gpio0;
  	       gpio1 = &gpio1;

(Yes I know Thunderbird has mangled the wordwrap in the patch but as I'm 
only providing it as a description of what I did not to be applied I 
won't beat it into submission this time)

As nothing seems to depend upon it I went with the CPU compatible type 
as defined in Documentation/devicetree/bindings/arm/cpus.txt rather than 
the marvell,sheeva-88SV131 in 
Documentation/devicetree/bindings/arm/kirkwood.txt

I tried putting some debug code in kirkwood_cpufreq_probe() and it 
doesn't appear to be getting called.

Have I

a) misunderstood what kirkwood variants this driver is supposed to work with
b) manged my CPU definition so it doesn't work
or c) missed some other critical configuration step?

Many thanks

Adam
