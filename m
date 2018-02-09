From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 9 Feb 2018 12:19:02 -0600
Subject: [PATCHv3 1/3] dt-bindings: documentation: add clock bindings
 information for Stratix10
In-Reply-To: <20180209024340.f7sijb7h5egdn675@rob-hp-laptop>
References: <1517847767-16053-1-git-send-email-dinguyen@kernel.org>
 <20180209024340.f7sijb7h5egdn675@rob-hp-laptop>
Message-ID: <9b8ae02b-67d5-8d0a-2e35-cab85f89470d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On 02/08/2018 08:43 PM, Rob Herring wrote:
> On Mon, Feb 05, 2018 at 10:22:45AM -0600, Dinh Nguyen wrote:
>> Document that Stratix10 clock bindings, and add the clock header file. The
>> clock header is an enumeration of all the different clocks on the Stratix10
>> platform.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v3:
>> - s/intc/intel for correct vendor prefix
>> - fixup node name to "intel,stratix10-clkmgr"
>> - document the required fixed-clock for oscillators
>> v2:
>> - use a single binding for the clock controller
>> ---
>>  .../devicetree/bindings/clock/intc_stratix10.txt   | 47 ++++++++++++
>>  include/dt-bindings/clock/stratix10-clock.h        | 85 ++++++++++++++++++++++
>>  2 files changed, 132 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
>>  create mode 100644 include/dt-bindings/clock/stratix10-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/intc_stratix10.txt b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
>> new file mode 100644
>> index 0000000..8d218f4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
>> @@ -0,0 +1,47 @@
>> +Device Tree Clock bindings for Intel's SoCFPGA Stratix10 platform
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : shall be
>> +	"intel,stratix10-clkmgr"
>> +
>> +- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
>> +
>> +- #clock-cells : from common clock binding, shall be set to 1.
>> +
>> +- clocks : Should contain fixed-clock sources, such as oscillators.
>> +
>> +Example:
>> +	clkmgr: clock-controller at ffd10000 {
>> +		compatible = "intel,stratix10-clkmgr";
>> +		reg = <0xffd10000 0x1000>;
>> +		#clock-cells = <1>;
>> +
>> +		clocks {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
> 
> Don't use '_' in node names.
> 

Ok..

>> +				#clock-cells = <0>;
>> +				compatible = "fixed-clock";
> 
> fixed clock with no frequency?

The frequency gets populated in the board's dts file. This provides for
the scenario where different boards might use different oscillator
frequencies.

So in socfpga_stratix10, I would have:

soc {
	clock-controller at ffd10000 {
		clocks {
			osc1 {
				clock-frequency = <25000000>;
			};
		};
	};
};

Thanks,
Dinh
