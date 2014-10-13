From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Oct 2014 13:08:12 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <20141013103219.GE14739@leverpostej>
References: <cover.1413136383.git.stefan@agner.ch>
 <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
 <20141013103219.GE14739@leverpostej>
Message-ID: <fadc1e22c016f4259819d87ba06d0d99@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-13 12:32, schrieb Mark Rutland:
> On Sun, Oct 12, 2014 at 07:13:58PM +0100, Stefan Agner wrote:
>> This adds an initial device tree to run Linux on the Cortex-M4 on
>> Vybrid.
>>
>> HACK: Because we include armv7-m.dtsi, the soc node happens to
>> be before the clock node. This is a problem for vf610-clk.c, which
>> tries to optain the fixed clocks defined in the clock nodes. But
>> because clock drivers are initialized sequencially, and we do not
>> have support for deferred probing, the clock initialization fails
>> horrible.
>> Move the armv7-m.dtsi include to the bottom to temporarily work
>> work around this...
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
>> hack as well. Is it common acceptable that the kernel depends
>> on DTS order?
> 
> The kernel should not depend on DTS ordering. We should sort out
> deferred probing if there is an issue with it.
> 
> [...]

Yes I guess to make this working independent of device tree order, we
need to defer probing of vf610-clk when the fixed clocks are not
initialized yet. 

Clock initialization (using CLK_OF_DECLARE) doesn't support EPROBE_DEFER
currently. 

We seem to have already a work around merged because of this.
http://thread.gmane.org/gmane.linux.kernel/1635576

Anybody tried to reverse device tree parsing to unveil how many such
assumptions are still slumbering?

 
>> +	clocks {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		sxosc {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +		};
>> +
>> +		fxosc {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <24000000>;
>> +		};
>> +	};
> 
> Please get rid of the clocks node and put these under the root node.
> There is nothing special about clocks, and the kernel in no way handles
> a clocks node specially.
> 
>> +
>> +	soc {
>> +		aips0: aips-bus at 40000000 {
>> +			compatible = "fsl,aips-bus", "simple-bus";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			reg = <0x40000000 0x70000>;
> 
> Out of curiosity, given that this can be driven as a simple-bus, what do
> the aips bus registers allow to be configured?
> 

There is a chapter about the AIPS lite bus in the RM, but according to
this the AIPS lite bus itself has no registers by itself. 

--
Stefan
