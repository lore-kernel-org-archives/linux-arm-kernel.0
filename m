From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Jul 2016 15:50:52 -0600
Subject: [PATCH 2/3] dt-bindings: allow child nodes inside the Tegra BPMP
In-Reply-To: <f1ca284a-5332-3323-80b9-7cf61e7c97ac@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-2-swarren@wwwdotorg.org>
 <20160726100302.GE2433@ulmo.ba.sec>
 <f1ca284a-5332-3323-80b9-7cf61e7c97ac@wwwdotorg.org>
Message-ID: <36967d69-cb2a-654e-9a4c-2021fd476464@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2016 10:21 AM, Stephen Warren wrote:
> On 07/26/2016 04:03 AM, Thierry Reding wrote:
>> On Tue, Jul 19, 2016 at 01:14:41PM -0600, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> The BPMP implements some services which must be represented by separate
>>> nodes. For example, it can provide access to certain I2C controllers,
>>> and
>>> the I2C bindings represent each I2C controller as a device tree node.
>>> Update the binding to describe how the BPMP supports this.
>>>
>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>> ---
>>>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 23
>>> ++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>> b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>> index 9a3864f56955..142d363406f6 100644
>>> ---
>>> a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>> +++
>>> b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>> @@ -38,6 +38,24 @@ implemented by this node:
>>>  - .../reset/reset.txt
>>>  - <dt-bindings/reset/tegra186-reset.h>
>>>
>>> +The BPMP implements some services which must be represented by
>>> separate nodes.
>>> +For example, it can provide access to certain I2C controllers, and
>>> the I2C
>>> +bindings represent each I2C controller as a device tree node. Such
>>> nodes should
>>> +be nested directly inside the main BPMP node.
>>> +
>>> +Software can determine whether a child node of the BPMP node
>>> represents a device
>>> +by checking for a compatible property. Any node with a compatible
>>> property
>>> +represents a device that can be instantiated. Nodes without a
>>> compatible
>>> +property may be used to provide configuration information regarding
>>> the BPMP
>>> +itself, although no such configuration nodes are currently defined
>>> by this
>>> +binding.
>>> +
>>> +The BPMP firmware defines no single global name-/numbering-space for
>>> such
>>> +services. Put another way, the numbering scheme for I2C buses is
>>> distinct from
>>> +the numbering scheme for any other service the BPMP may provide
>>> (e.g. a future
>>> +hypothetical SPI bus service). As such, child device nodes will have
>>> no reg
>>> +property, and the BPMP node will have no #address-cells or
>>> #size-cells property.
>>
>> My understanding is that the I2C bus number is passed as part of the
>> request to the BPMP firmware. Does that not count as addressing? Could
>> we not represent that generically using a device tree hierarchy? I'm
>> thinking something along these lines:
>>
>>     bpmp {
>>         ...
>>
>>         services {
>>             i2c {
>>                 i2c at 0 {
>>                     reg = <0>;
>
> Technically, that is possible. However, Rob Herring rejected the idea of
> multiple levels of sub-nodes.
>
> Can we please just go with what we have? DT bindings are frankly an
> obstacle to getting anything done:-(

Thierry, any further thoughts here? I really need to get these DT 
bindings finalized so that I can use them in U-Boot, which is very 
urgent. Thanks.
