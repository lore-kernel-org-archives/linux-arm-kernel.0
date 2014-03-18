From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 18 Mar 2014 17:10:59 +1100
Subject: linux-next: manual merge of the staging tree with the arm-soc tree
Message-ID: <20140318171059.a1134a2c670e1b18847f98d0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in
Documentation/devicetree/bindings/iio/adc/at91_adc.txt between commit
b5303ffbcf11 ("Documentation: dt: iio: improve atmel-adc documentation")
from the arm-soc tree and commit 1a5b7d41f8f6 ("iio: at91: document ADC
clock properties") from the staging tree.

[This file is renamed from
Documentation/devicetree/bindings/arm/atmel-adc.txt in the arm-soc tree.]

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/iio/adc/at91_adc.txt
index 82061c7e4fea,9a1175b46f49..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
@@@ -5,7 -5,10 +5,10 @@@ Required properties
      <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
    - reg: Should contain ADC registers location and length
    - interrupts: Should contain the IRQ line for the ADC
+   - clock-names: tuple listing input clock names.
+ 	Required elements: "adc_clk", "adc_op_clk".
+   - clocks: phandles to input clocks.
 -  - atmel,adc-channels-used: Bitmask of the channels muxed and enable for this
 +  - atmel,adc-channels-used: Bitmask of the channels muxed and enabled for this
      device
    - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
      defined in the datasheet
@@@ -41,14 -44,19 +44,16 @@@ Optional trigger Nodes
  
  Examples:
  adc0: adc at fffb0000 {
 +	#address-cells = <1>;
 +	#size-cells = <0>;
  	compatible = "atmel,at91sam9260-adc";
  	reg = <0xfffb0000 0x100>;
 -	interrupts = <20 4>;
 +	interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
+ 	clocks = <&adc_clk>, <&adc_op_clk>;
+ 	clock-names = "adc_clk", "adc_op_clk";
 -	atmel,adc-channel-base = <0x30>;
  	atmel,adc-channels-used = <0xff>;
 -	atmel,adc-drdy-mask = <0x10000>;
 -	atmel,adc-num-channels = <8>;
  	atmel,adc-startup-time = <40>;
 -	atmel,adc-status-register = <0x1c>;
 -	atmel,adc-trigger-register = <0x08>;
 -	atmel,adc-use-external;
 +	atmel,adc-use-external-triggers;
  	atmel,adc-vref = <3300>;
  	atmel,adc-res = <8 10>;
  	atmel,adc-res-names = "lowres", "highres";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/be9e9b24/attachment-0001.sig>
