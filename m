From: songjun.wu@atmel.com (Wu, Songjun)
Date: Fri, 20 May 2016 11:30:17 +0800
Subject: [PATCH v2 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <20160518230522.GA3198@rob-hp-laptop>
References: <1463557590-29318-1-git-send-email-songjun.wu@atmel.com>
 <1463557590-29318-3-git-send-email-songjun.wu@atmel.com>
 <20160518230522.GA3198@rob-hp-laptop>
Message-ID: <c3ffa795-a59a-6453-f371-7bced5944cf6@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thank you for your comments.

On 5/19/2016 07:05, Rob Herring wrote:
> On Wed, May 18, 2016 at 03:46:29PM +0800, Songjun Wu wrote:
>> DT binding documentation for ISC driver.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
>> ---
>>
>> Changes in v2:
>> - Remove the unit address of the endpoint.
>> - Add the unit address to the clock node.
>> - Avoid using underscores in node names.
>> - Drop the "0x" in the unit address of the i2c node.
>> - Modify the description of "atmel,sensor-preferred".
>> - Add the description for the ISC internal clock.
>>
>>  .../devicetree/bindings/media/atmel-isc.txt        | 100 +++++++++++++++++++++
>>  1 file changed, 100 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
>> new file mode 100644
>> index 0000000..9e65395
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
>> @@ -0,0 +1,100 @@
>> +Atmel Image Sensor Controller (ISC)
>> +----------------------------------------------
>> +
>> +Required properties for ISC:
>> +- compatible
>> +	Must be "atmel,sama5d2-isc"
>> +- reg
>> +	Physical base address and length of the registers set for the device;
>> +- interrupts
>> +	Should contain IRQ line for the ISC;
>> +- clocks
>> +	List of clock specifiers, corresponding to entries in
>> +	the clock-names property;
>> +	Please refer to clock-bindings.txt.
>> +- clock-names
>> +	Required elements: "hclock", "ispck".
>> +- pinctrl-names, pinctrl-0
>> +	Please refer to pinctrl-bindings.txt.
>> +- clk-in-isc
>> +	ISC internal clock node, it includes two clock nodes,
>> +	isc-ispck and isc-mck.
>
> And you need to describe each of these nodes and the properties they
> have. But more on this below...
>
Should I move the description of clock node below to here?

>> +- atmel,sensor-preferred
>> +	ISC may convert the raw format to the specified format when the sensor
>> +	outputs the raw format, and the sensor may output the specified format
>> +	directly. If sensor is preferred to output the specified format
>> +	directly, the value should be 1 (1-preferred, 0-not).
>> +	The default value is 1.
>
> I don't think this belongs in DT. It sounds more like a configuration
> and userspace decision. It is still not clear what you mean by
> "specified format".
>
Accept, I will remove this.

>> +
>> +ISC supports a single port node with parallel bus. It should contain one
>> +'port' child node with child 'endpoint' node. Please refer to the bindings
>> +defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
>> +
>> +Required properties for the ISC internal clocks:
>> +- #address-cells
>> +	should be 1 (reg is used to encode clk id).
>> +- #size-cells
>> +	should be 0 (reg is used to encode clk id).
>> +- name
>> +	device tree node describing a ISC internal clock.
>> +	* #clock-cells: from common clock binding; should be set to 0.
>> +	* reg: clock id, there are two values,
>> +	       <0> is ISP clock, <1> is master clock.
>> +	* clocks: shall be the isc internal clock source phandles.
>> +		  e.g. clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
>> +
>> +Example:
>> +isc: isc at f0008000 {
>> +	compatible = "atmel,sama5d2-isc";
>> +	reg = <0xf0008000 0x4000>;
>> +	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
>> +	clocks = <&isc_clk>, <&isc_ispck>;
>> +	clock-names = "hclock", "ispck";
>> +	atmel,sensor-preferred = <1>;
>> +
>> +	port {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		isc_0: endpoint {
>> +			remote-endpoint = <&ov7740_0>;
>> +			hsync-active = <1>;
>> +			vsync-active = <0>;
>> +			pclk-sample = <1>;
>> +		};
>> +	};
>> +
>> +	clk-in-isc {
>
> Is this really separate from the rest of the isc block. It would be
> much more simple to define all the input clocks at the parent and then
> reference these 2 clocks with <&isc 0> and <&isc 1>.
>
Yes, it's separate from the rest of isc block.
It will register two clocks, one is used in ISC internal processor, the 
other will provide the clock to the sensor outside.
I think it's better that the parent clock is included in node 
'clk-in-isc' node. I will try to optimize this node.

>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		isc_ispck: isc-ispck at 0 {
>
> These would need a compatible string otherwise.
>
>> +			#clock-cells = <0>;
>> +			reg = <0>;
>
> Are 0 and 1 meaningful in terms of the hardware description?
>
Yes, It's meaningful.
The register field is different, 0 and 1 can distinguish the different 
clock.

>> +			clocks = <&isc_clk>, <&iscck>;
>> +		};
>> +
>> +		isc_mck: isc-mck at 1 {
>> +			#clock-cells = <0>;
>> +			reg = <1>;
>> +			clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
>> +		};
>> +	};
>> +};
