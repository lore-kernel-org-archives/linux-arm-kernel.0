From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 30 Aug 2016 14:24:53 +0530
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <20160826171718.GB20752@gobelin>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com> <20160804210045.GD15013@gobelin>
 <m2fuqknnqk.fsf@baylibre.com> <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
 <dd4712ba-6144-8c64-59a6-7673936af53c@ti.com>
 <20160824082934.GA20246@gobelin>
 <a076cc95-d338-ec13-ba05-360c1857cda5@ti.com>
 <20160826171718.GB20752@gobelin>
Message-ID: <c3b0be53-d9ed-574e-4699-3e294ec6c927@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2016 10:47 PM, Karl Beldan wrote:

>>> Also I think it would be better for the serial nodes to reclaim the rxtx
>>> pins in the dtsi, and override the reclaimed pins in the .dts only for
>>> the nodes reclaiming flow control (some other pins could also be
>>> directly reclaimed in the dtsi).
>>
>> You lost me here. I guess I will benefit from a code snippet to
>> illustrate the intention.
>>
> 
> Sure, instead of having: {
> 
> ### board.dts:
> &serialN {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&serialN_rxtx_pins>;
> 	status = "okay";
> };
> &serialN+1 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&serialN+1_rxtx_pins>, <&serialN+1_rtscts_pins>;
> 	status = "okay";
> };
> 
> } use ------------------ {
> 
> ### plat.dtsi:
> serialN: serial at xxxxx {
> 	compatible = "ns16550a";
> 	pinctrl-0 = <&serialN_rxtx_pins>;
> 	status = "disabled";
> 	[...]
> };
> serialN+1: serial at xxxxx {
> 	compatible = "ns16550a";
> 	pinctrl-0 = <&serialN+1_rxtx_pins>;
> 	status = "disabled";
> 	[...]
> };
> 
> ### board.dts:
> &serialN {
> 	status = "okay";
> };
> &serialN+1 {
> 	pinctrl-0 = <&serialN+1_rxtx_pins>, <&serialN+1_rtscts_pins>;
> 	status = "okay";
> };

I dont think it is a good idea to specify a pinctrl setting in
da850.dtsi and override it in board.dts. Fundamentally I am against
having properties in <soc.dtsi> overridden from <board.dts>.  Sure, it
saves some code in some cases, but it is confusing to read/debug and you
are never sure that the property you seen set in one place is the one
finally taking effect.

The only notable exception is 'status' property. If you see other
exceptions in DaVinci, its only because of my oversight.

>> It would be nice if you could fixup mcasp0_pins in da850-evm.dts. Surely
>> it is doing more than what is needed.
>>
> 
> According to the schematics it is indeed, I could squeeze it in the series.

Thanks!

Regards,
Sekhar
