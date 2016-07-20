From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Jul 2016 09:57:43 -0600
Subject: [PATCH 2/3] dt-bindings: allow child nodes inside the Tegra BPMP
In-Reply-To: <20160720131622.GA20276@rob-hp-laptop>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-2-swarren@wwwdotorg.org>
 <20160720131622.GA20276@rob-hp-laptop>
Message-ID: <578F9F77.9010203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 07:16 AM, Rob Herring wrote:
> On Tue, Jul 19, 2016 at 01:14:41PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The BPMP implements some services which must be represented by separate
>> nodes. For example, it can provide access to certain I2C controllers, and
>> the I2C bindings represent each I2C controller as a device tree node.
>> Update the binding to describe how the BPMP supports this.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>   .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 23 ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> index 9a3864f56955..142d363406f6 100644
>> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> @@ -38,6 +38,24 @@ implemented by this node:
>>   - .../reset/reset.txt
>>   - <dt-bindings/reset/tegra186-reset.h>
>>
>> +The BPMP implements some services which must be represented by separate nodes.
>> +For example, it can provide access to certain I2C controllers, and the I2C
>> +bindings represent each I2C controller as a device tree node. Such nodes should
>> +be nested directly inside the main BPMP node.
>> +
>> +Software can determine whether a child node of the BPMP node represents a device
>> +by checking for a compatible property. Any node with a compatible property
>> +represents a device that can be instantiated. Nodes without a compatible
>> +property may be used to provide configuration information regarding the BPMP
>> +itself, although no such configuration nodes are currently defined by this
>> +binding.
>> +
>> +The BPMP firmware defines no single global name-/numbering-space for such
>> +services. Put another way, the numbering scheme for I2C buses is distinct from
>> +the numbering scheme for any other service the BPMP may provide (e.g. a future
>> +hypothetical SPI bus service). As such, child device nodes will have no reg
>> +property, and the BPMP node will have no #address-cells or #size-cells property.
>> +
>>   The shared memory bindings for BPMP
>>   -----------------------------------
>>
>> @@ -78,4 +96,9 @@ bpmp {
>>   	#clock-cells = <1>;
>>   	#power-domain-cells = <1>;
>>   	#reset-cells = <1>;
>> +
>> +	bpmp-i2c {
>
> Just 'i2c' here. With that:
>
> Acked-by: Rob Herring <robh@kernel.org>

What if we have multiple BPMP I2C buses? The node names need to be 
unique, and there's no concept of register number so we can't use a unit 
address to do that.

I guess we could go for plain "i2c" for now and defer the more general 
naming discussion until some later point if/when we actually instantiate 
multiple buses, but I would like to confirm we can solve the problem 
if/when that time comes.

(As an aside, "pwr-i2c" might be a better name for the current bus, when 
the time comes, since any/all I2C nodes inside the BPMP would be BPMP 
I2C buses).
