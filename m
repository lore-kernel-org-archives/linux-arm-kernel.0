From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 14:53:39 -0600
Subject: [PATCH] media: add V4L2 DT binding documentation
In-Reply-To: <Pine.LNX.4.64.1209122111100.28968@axis700.grange>
References: <Pine.LNX.4.64.1209111746420.22084@axis700.grange>
 <5050DA40.8050105@wwwdotorg.org>
 <Pine.LNX.4.64.1209122111100.28968@axis700.grange>
Message-ID: <5050F653.5070404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 01:28 PM, Guennadi Liakhovetski wrote:
> Hi Stephen
> 
> On Wed, 12 Sep 2012, Stephen Warren wrote:
> 
>> On 09/11/2012 09:51 AM, Guennadi Liakhovetski wrote:
>>> This patch adds a document, describing common V4L2 device tree bindings.
>>>
>>> Co-authored-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> Overall, I think this looks pretty reasonable, so:
...
>>
>>> +			clock-frequency = <50000000>;	/* max clock frequency */
>>> +			clock-output-names = "mclk";
>>> +		};
>>> +
>>> +		port {
>> ...
>>> +			ceu0_0: link at 0 {
>>> +				reg = <0>;
>>> +				remote = <&csi2_2>;
>>> +				immutable;
>>
>> Did we decide "immutable" was actually needed? Presumably the driver for
>> the HW in question knows the HW isn't configurable, and would simply not
>> attempt to apply any configuration even if the .dts author erroneously
>> provided some?
> 
> Well, I've been thinking about this today. I think, bridge drivers will 

Sorry, I'm not sure what a "bridge" driver is; is it any v4l2 device?

> call centrally provided helper functions to enumerate links inside ports. 

Presumably a given driver would only parse the ports/links of its own DT
node, and hence would be able to provide a parameter to any helper
function that indicated the same information that "immutable" would?

> While doing that they will want to differentiate between links to external 
> devices with explicit configuration, and links to internal devices, whose 
> configuration drivers might be able to figure out themselves. How should a 
> driver find out what device this link is pointing to? Should it follow the 
> "remote" phandle and then check the "compatible" property? The word 
> "immutable" is a hint, that this is a link to an internal device, but it 
> might either be unneeded or be transformed into something more 
> informative.

I would imagine that a given driver would only ever parse its own DT
node; the far end of any link is purely the domain of the other driver.
I thought that each link node would contain whatever hsync-active,
data-lanes, ... properties that were needed to configure the local device?
