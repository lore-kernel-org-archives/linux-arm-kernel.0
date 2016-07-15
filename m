From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 15 Jul 2016 09:53:09 +0200
Subject: [Xen-devel] [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <5787C88A.8030103@arm.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <146836236759.73491.11707389619985827497@resonance>
 <c320f820-8749-f4a4-435e-ddd9379655b5@de.bosch.com>
 <alpine.DEB.2.10.1607131941200.26575@sstabellini-ThinkPad-X260>
 <57868EDE.6060406@gmail.com>
 <146844380895.73491.4867379517577413421@resonance>
 <7df784ab-d0c0-939b-393e-214535c4b191@de.bosch.com>
 <alpine.DEB.2.10.1607141132000.26575@sstabellini-ThinkPad-X260>
 <86951b96-0a3e-79b1-1a2f-88dfeba9b76b@de.bosch.com>
 <alpine.DEB.2.10.1607141647350.22290@sstabellini-ThinkPad-X260>
 <5787BE0B.8060504@gmail.com> <5787C88A.8030103@arm.com>
Message-ID: <2bc46969-544d-3e07-a7f6-83895703d11a@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.07.2016 19:14, Julien Grall wrote:
> Hello,
>
> On 14/07/16 17:30, Dirk Behme wrote:
>> On 14.07.2016 17:55, Stefano Stabellini wrote:
>>> On Thu, 14 Jul 2016, Dirk Behme wrote:
>>>> On 14.07.2016 12:38, Stefano Stabellini wrote:
>>>>> On Thu, 14 Jul 2016, Dirk Behme wrote:
>>>>>> On 13.07.2016 23:03, Michael Turquette wrote:
>>>>>>> Quoting Dirk Behme (2016-07-13 11:56:30)
>>>>>>>> On 13.07.2016 20:43, Stefano Stabellini wrote:
>>>>>>>>> On Wed, 13 Jul 2016, Dirk Behme wrote:
>>>>>>>>>> On 13.07.2016 00:26, Michael Turquette wrote:
>>>>>>>>>>> Quoting Dirk Behme (2016-07-12 00:46:45)
>>>>>>>>>>>> Clocks described by this property are reserved for use by Xen,
>>>>>>>>>>>> and
>>>>>>>>>>>> the OS
>>>>>>>>>>>> must not alter their state any way, such as disabling or
>>>>>>>>>>>> gating a
>>>>>>>>>>>> clock,
>>>>>>>>>>>> or modifying its rate. Ensuring this may impose constraints on
>>>>>>>>>>>> parent
>>>>>>>>>>>> clocks or other resources used by the clock tree.
>>>>>>>>>>>
>>>>>>>>>>> Note that clk_prepare_enable will not prevent the rate from
>>>>>>>>>>> changing
>>>>>>>>>>> (clk_set_rate) or a parent from changing (clk_set_parent). The
>>>>>>>>>>> only
>>>>>>>>>>> way
>>>>>>>>>>> to do this currently would be to set the following flags on the
>>>>>>>>>>> effected
>>>>>>>>>>> clocks:
>>>>>>>>>>>
>>>>>>>>>>>      CLK_SET_RATE_GATE
>>>>>>>>>>>      CLK_SET_PARENT_GATE
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Regarding setting flags, I think we already talked about that. I
>>>>>>>>>> think
>>>>>>>>>> the
>>>>>>>>>> conclusion was that in our case its not possible to manipulate
>>>>>>>>>> the
>>>>>>>>>> flags in
>>>>>>>>>> the OS as this isn't intended to be done in cases like ours.
>>>>>>>>>> Therefore
>>>>>>>>>> no API
>>>>>>>>>> is exported for this.
>>>>>>>>>>
>>>>>>>>>> I.e. if we need to set these flags, we have to do that in Xen
>>>>>>>>>> where we
>>>>>>>>>> add the
>>>>>>>>>> clocks to the hypervisor node in the device tree. And not in the
>>>>>>>>>> kernel patch
>>>>>>>>>> discussed here.
>>>>>>>>>
>>>>>>>>> These are internal Linux flags, aren't they?
>>>>>>>>
>>>>>>>>
>>>>>>>> I've been under the impression that you can set clock "flags" via
>>>>>>>> the
>>>>>>>> device tree. Seems I need to re-check that ;)
>>>>>>>
>>>>>>> Right, you cannot set flags from the device tree. Also, setting
>>>>>>> these
>>>>>>> flags is done by the clock provider driver, not a consumer. Xen is
>>>>>>> the
>>>>>>> consumer.
>>>>>>
>>>>>>
>>>>>> Ok, thanks, then I think we can forget about using flags for the
>>>>>> issue we
>>>>>> are
>>>>>> discussing here.
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> Dirk
>>>>>>
>>>>>> P.S.: Would it be an option to merge the v4 patch we are discussing
>>>>>> here,
>>>>>> then? From the discussion until here, it sounds to me that it's the
>>>>>> best
>>>>>> option we have at the moment. Maybe improving it in the future, then.
>>>>>
>>>>> It might be a step in the right direction, but it doesn't really
>>>>> prevent
>>>>> clk_set_rate from changing properties of a clock owned by Xen.  This
>>>>> patch is incomplete.
>>>>
>>>>
>>>> Let me ask then: Do we have a practical example where it's not
>>>> sufficient
>>>> practically?
>>>>
>>>> To my understanding, Xen people have been happy with the
>>>> "clk_ignore_unused"
>>>> workaround since ~2 years, now [1]. And I think the "clk_ignore_unused"
>>>> workaround does mainly the same like the patch discussed here. It
>>>> doesn't care
>>>> regarding clk_set_rate from changing properties, too?
>>>
>>> Let me premise that I appreciate what you are trying to achieve with
>>> this patch and I don't want to feature-creep it.
>>>
>>> However we are defining a new Device Tree binding,
>>
>>
>> I don't think so.
>>
>> We are just using the existing one
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n66
>>
>>
>>
>> , pick it from other device tree nodes (e.g. serial, timer etc) and add
>> it to the hypervisor node. And then use this existing one with the
>> existing well defined clock API.
>>
>>
>>> one which will have
>>> to be supported for a long time by both Xen and Linux, so at the very
>>> least we need to have the full picture. We need to understand if the
>>> binding if sufficient
>>
>>
>> Even if it's not sufficient, you can't change it.
>
> I think you misunderstood Stefano's comment. Whilst the clock bindings
> is set in stone, the binding you are adding in this patch is not yet
> fixed.


It has to be

a) identical what we pick from UART, timer, etc

b) compatible to the kernel's clock API

No?

With these two requirements I have some difficulties to imagine how it 
could be different to the clock binding from clock-bindings.txt?



> There is no requirement to follow what was defined in
> clock-bindings.txt. I agree it would be convenient, but as mentioned by
> Stefano this will need to be supported for a long time by Xen, Linux,
> and any other consumer (i.e BSD kernels).


Sounds like an additional argument for clock-bindings.txt ;)


> So we have to be careful on
> how it has been defined.
>
> I would wait the answer of Michael on Stefano's question before taking
> any decision here.


Fine with me :)


Best regards

Dirk


>>> or if we need something different to solve the
>>> problem completely.
>>
>>
>> You might need anything additionally. E.g. an extension of the Linux
>> kernel clock API to be able to modify the flags was proposed.
>
> The Linux kernel is not the only consumer of the device tree bindings.
> This is also used by other OS such as FreeBSD where you might already be
> able (I have not actually checked) to forbid a user to change the clock
> rate.
>
>>
>> Best regards
>>
>> Dirk
>>
>> P.S.: I still would be interested if we do have a practical example
>> where it's not sufficient practically?
>
> Very easy. What does prevent a driver to change the clock rate? Nothing
> but the flags mentioned by Michael. There are already drivers which
> modify the clock rate, thankfully those clocks are not shared with the
> UART for now.
>
> But we cannot rule out that it will not be possible in the future. Think
> about a clock that would be used by another guest (I know it is still
> theoretical as we have not yet solved the problem).
