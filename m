From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 23:15:41 +0800
Subject: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree
In-Reply-To: <521E0722.9040206@wwwdotorg.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
 <8761uxsiox.fsf@linaro.org> <52165D5E.7040500@wwwdotorg.org>
 <CAD6h2NTYNSFAQ0NWVwKXEr7BHUikmjROk-i+qYGo0otFPZKu0A@mail.gmail.com>
 <521B86D9.5060108@wwwdotorg.org>
 <CAD6h2NSdk0fs-Z=Es9bOkwUEaubDTmAjv3hLDkrS3m1yshrbtQ@mail.gmail.com>
 <521E0722.9040206@wwwdotorg.org>
Message-ID: <CAD6h2NRVnO+cY=chLSmVVtegUm6vORCkJZhjVYupqcyhHDkspA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2013 22:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/27/2013 08:17 PM, Haojian Zhuang wrote:
>> On 27 August 2013 00:48, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 08/23/2013 09:52 PM, Haojian Zhuang wrote:
>>>> On 23 August 2013 02:50, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>> On 08/22/2013 12:07 PM, Kevin Hilman wrote:
>>>>>> [+ DT maintainers]
>>>>>>
>>>>>> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>>>>>>
>>>>>>> Enable Hisilicon Hi4511 development platform with device tree support.
>>>>>>>
>>>>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>>>> ...
>>>
>>>>>>> +    osc32k: osc32k {
>>>>>>> +            compatible = "fixed-clock";
>>>>>>> +            #clock-cells = <0>;
>>>>>>> +            clock-frequency = <32768>;
>>>>>>> +            clock-output-names = "osc32khz";
>>>>>>> +    };
>>>>>>
>>>>>> ...seems many of the recent users of clocks have grouped them into a
>>>>>> clocks {} grouping on a "simple-bus".
>>>>>>
>>>>>> DT folks: is there a rule of thumb on how whether these fixed clocks
>>>>>> should be grouped on a simple bus?
>>>>>
>>>>> I would expect all the clock node names to be just "clock", since the
>>>>> node names should describe the type of device not their identity (i.e.
>>>>> clock name).
>>>>>
>>>>> In turn, this means that each clock node name needs to use a unit
>>>>> address ("@nnn") to make them unique. In turn, this means they must have
>>>>> a reg property since the unit address must match the first entry in the
>>>>> reg property.
>>>>
>>>> No, it's really bad on using a unit address. The register always contains
>>>> multiple mux or gate or divider. It would cause duplicated unit address.
>>>
>>> There shouldn't be multiple nodes with identical reg values; if that's
>>> happening, then it seems like the mapping of nodes to HW is incorrect.
>>>
>>> Each HW block should have 1 DT node. That way, the reg values won't collide.
>>
>> At here, I emphasize each clock node is one clock node. They are organized in
>> tree. The same register integrates multiple clock gate/clock mux/clock divider.
>> If each clock node is depend on reg, maybe it's not easy to read and the clock
>> driver will be more complex.
>
> If there's a single HW block (or single register) that provides multiple
> clocks, there should be a single DT node and a single device that
> provides multiple clocks.
>
>>>> I tried to use index number also. And it's also bad to append new clock nodes.
>>>> So I use the label name instead.
>>>>
>>>>> Now I assume these clocks don't have any memory-mapped IO registers, so
>>>>> they would need an arbitrary reg value rather than a real one. So it
>>>>> doesn't make sense to place them directly under the root DT node, since
>>>>> their reg values would make no sense within the context of the
>>>>> CPU-visible MMIO space that the root node describes.
>>>>>
>>>>> In this case, it's typical to put all the clock nodes into e.g. a
>>>>> /clocks node, since that node can introduce a separate numbering-space
>>>>> for clocks. For example, I'd expect something like:
>>>>>
>>>>>         clocks {
>>>>>                 #address-cells = <1>;
>>>>>                 #size-cells = <0>;
>>>>>
>>>>>                 osc32k: clock at 0 {
>>>>>                         compatible = "fixed-clock";
>>>>>                         reg = <0>;
>>> ...
>>>>>                 osc26m: clock at 1 {
>>>>>                         compatible = "fixed-clock";
>>>>>                         reg = <1>;
>>> ...
>>>
>>>> Those fixed-clock doesn't contain reg property. Since it needs not to access
>>>> any clock register. It only provides the clock rate those child clock node.
>>>
>>> Inside the clocks node, the reg property is just a dummy value.
>>
>> Is a dummy value helpful? I don't think so.
>
> It's not a matter of whether it's helpful; it's just how DT works.
>
>

I copied some texts from device tree spec (Page 87. file name:
Power_ePAPER_APPROVED_v1.0.pdf).

    Node and property definitions
    Device tree nodes are defined with a node name and unit address
with braces marking the start and
    end of the node definition. They may be preceded by a label.

    [label:] node-name[@unit-address] {
        [properties definitions]
        [child nodes]
    }

We can see that "unit-address" is optional.

I also copied some texts from $LINUX/Documentation/devicetree/usage-model.txt

     Structurally, the DT is a tree, or acyclic graph with named nodes, and
     nodes may have an arbitrary number of named properties encapsulating
     arbitrary data.  A mechanism also exists to create arbitrary
     links from one node to another outside of the natural tree structure.

     Conceptually, a common set of usage conventions, called 'bindings',
     is defined for how data should appear in the tree to describe typical
     hardware characteristics including data busses, interrupt lines, GPIO
     connections, and peripheral devices.

I define each clock as one node although multiple clocks share one
register, because it could
share clock driver as much as possible. Whether they're sharing one
register or not, they
can be distinguished by clock types. I think that encapsulating them
into one single
node could only make clock driver complex. Sometimes one clock is
using a single register,
and sometime some clocks are sharing a single register. If the clock
driver wants to support
both, it needs to add more logic to check. And I don't think that
abstracting clock breaks
any law in DT.

Regards
Haojian
