From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 15 Feb 2017 19:14:14 +0100
Subject: [PATCH 11/11] ARM64: dts: Prepare Actions Semi S900 and
 Bubblegum-96
In-Reply-To: <20170215171232.GI31733@leverpostej>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-12-afaerber@suse.de>
 <20170215171232.GI31733@leverpostej>
Message-ID: <267b586e-06ce-f123-b7cc-dc0feb880ca9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 15.02.2017 um 18:12 schrieb Mark Rutland:
> On Wed, Feb 15, 2017 at 05:55:28PM +0100, Andreas F?rber wrote:
>> +#include "s900.dtsi"
>> +
>> +/ {
>> +	compatible = "ucrobotics,bubblegum-96", "acts,s900";
>> +	model = "Bubblegum-96";
>> +
>> +	aliases {
>> +		serial5 = &uart5;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial5:115200n8";
>> +	};
>> +};
> 
> I didn't spot a memory node here or in the dtsi. Does the FW/bootloader
> create one?

Heh, apparently... For S500, skeleton.dtsi added that - not entirely
clean either. I'll add one here in the .dts and think about adding one
in s500-guitar.dtsi as well.

--- a/arch/arm64/boot/dts/actions/s900-bubblegum96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum96.dts
@@ -55,6 +55,11 @@
        chosen {
                stdout-path = "serial5:115200n8";
        };
+
+       memory {
+               device_type = "memory";
+               reg = <0x0 0x0 0x0 0x80000000>;
+       };
 };

 &uart5 {

>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +	};
> 
> Why have this empty node?

Forgotten about... I see these:

   reserving fdt memory region: addr=19000000 size=3000000
   reserving fdt memory region: addr=20000000 size=20000000
   reserving fdt memory region: addr=18fff000 size=1000
   reserving fdt memory region: addr=1f000000 size=1000000

Vendor tree says 0x1f000000 is for secure monitor; 0x19000000 for fb,
0x20000000 for ion (ignoring), and 0x20000000 for afinfo - whatever that
may be (not me! :)).

So as minimum:

--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -86,6 +86,11 @@
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;
+
+               secmon at 1f000000 {
+                       reg = <0x0 0x1f000000 0x0 0x1000000>;
+                       no-map;
+               };
        };

        psci {

>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	arm-pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>> +		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
> 
> Please ad an interrupt-affinity property, as described in
> Documentation/devicetree/bindings/arm/pmu.txt.

I had done my best to check my properties matched the bindings, but you
caught me not checking for any missing properties.

Again, my guess is:

@@ -99,6 +104,7 @@
                             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+               interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
        };

        timer {

>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		gic: interrupt-controller at e00f1000 {
>> +			compatible = "arm,gic-400";
>> +			reg = <0x0 0xe00f1000 0x0 0x1000>,
>> +			      <0x0 0xe00f2000 0x0 0x1000>,
>> +			      <0x0 0xe00f4000 0x0 0x2000>,
>> +			      <0x0 0xe00f6000 0x0 0x2000>;
> 
> I believe that the second entry should be 0x2000 in length.

The vendor tree does have 0x1000, but that might be a mistake of course.
I vaguely recall having such discussions elsewhere in the past.

@@ -122,7 +128,7 @@
                gic: interrupt-controller at e00f1000 {
                        compatible = "arm,gic-400";
                        reg = <0x0 0xe00f1000 0x0 0x1000>,
-                             <0x0 0xe00f2000 0x0 0x1000>,
+                             <0x0 0xe00f2000 0x0 0x2000>,
                              <0x0 0xe00f4000 0x0 0x2000>,
                              <0x0 0xe00f6000 0x0 0x2000>;
                        interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4)
| IRQ_TYPE_LEVEL_LOW)>;

Thanks for the quick review,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
