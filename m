From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 10:17:14 +0800
Subject: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree
In-Reply-To: <521B86D9.5060108@wwwdotorg.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
 <8761uxsiox.fsf@linaro.org> <52165D5E.7040500@wwwdotorg.org>
 <CAD6h2NTYNSFAQ0NWVwKXEr7BHUikmjROk-i+qYGo0otFPZKu0A@mail.gmail.com>
 <521B86D9.5060108@wwwdotorg.org>
Message-ID: <CAD6h2NSdk0fs-Z=Es9bOkwUEaubDTmAjv3hLDkrS3m1yshrbtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2013 00:48, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/23/2013 09:52 PM, Haojian Zhuang wrote:
>> On 23 August 2013 02:50, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 08/22/2013 12:07 PM, Kevin Hilman wrote:
>>>> [+ DT maintainers]
>>>>
>>>> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>>>>
>>>>> Enable Hisilicon Hi4511 development platform with device tree support.
>>>>>
>>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> ...
>
>>>>> +    osc32k: osc32k {
>>>>> +            compatible = "fixed-clock";
>>>>> +            #clock-cells = <0>;
>>>>> +            clock-frequency = <32768>;
>>>>> +            clock-output-names = "osc32khz";
>>>>> +    };
>>>>
>>>> ...seems many of the recent users of clocks have grouped them into a
>>>> clocks {} grouping on a "simple-bus".
>>>>
>>>> DT folks: is there a rule of thumb on how whether these fixed clocks
>>>> should be grouped on a simple bus?
>>>
>>> I would expect all the clock node names to be just "clock", since the
>>> node names should describe the type of device not their identity (i.e.
>>> clock name).
>>>
>>> In turn, this means that each clock node name needs to use a unit
>>> address ("@nnn") to make them unique. In turn, this means they must have
>>> a reg property since the unit address must match the first entry in the
>>> reg property.
>>
>> No, it's really bad on using a unit address. The register always contains
>> multiple mux or gate or divider. It would cause duplicated unit address.
>
> There shouldn't be multiple nodes with identical reg values; if that's
> happening, then it seems like the mapping of nodes to HW is incorrect.
>
> Each HW block should have 1 DT node. That way, the reg values won't collide.
>

At here, I emphasize each clock node is one clock node. They are organized in
tree. The same register integrates multiple clock gate/clock mux/clock divider.
If each clock node is depend on reg, maybe it's not easy to read and the clock
driver will be more complex.

>> I tried to use index number also. And it's also bad to append new clock nodes.
>> So I use the label name instead.
>>
>>> Now I assume these clocks don't have any memory-mapped IO registers, so
>>> they would need an arbitrary reg value rather than a real one. So it
>>> doesn't make sense to place them directly under the root DT node, since
>>> their reg values would make no sense within the context of the
>>> CPU-visible MMIO space that the root node describes.
>>>
>>> In this case, it's typical to put all the clock nodes into e.g. a
>>> /clocks node, since that node can introduce a separate numbering-space
>>> for clocks. For example, I'd expect something like:
>>>
>>>         clocks {
>>>                 #address-cells = <1>;
>>>                 #size-cells = <0>;
>>>
>>>                 osc32k: clock at 0 {
>>>                         compatible = "fixed-clock";
>>>                         reg = <0>;
> ...
>>>                 osc26m: clock at 1 {
>>>                         compatible = "fixed-clock";
>>>                         reg = <1>;
> ...
>
>> Those fixed-clock doesn't contain reg property. Since it needs not to access
>> any clock register. It only provides the clock rate those child clock node.
>
> Inside the clocks node, the reg property is just a dummy value.

Is a dummy value helpful? I don't think so.

Regards
Haojian
