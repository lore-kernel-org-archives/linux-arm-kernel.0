From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 16 May 2018 15:30:37 -0600
Subject: [PATCH] arm64: dts: juno: fix graph node unit addresses for
 coresight components
In-Reply-To: <dd4796b7-a078-27db-0fdc-099a834ce8bc@arm.com>
References: <1526466862-19173-1-git-send-email-sudeep.holla@arm.com>
 <574f6959-6a84-9e0e-3d89-84d2d75d9191@arm.com>
 <eba4cddf-f668-a5e1-acea-5e6538c230f0@arm.com>
 <CANLsYkyi+m_uQydSWZkf_e1PNSoU-n1rLixuJ0+P9G8hpm68TA@mail.gmail.com>
 <dd4796b7-a078-27db-0fdc-099a834ce8bc@arm.com>
Message-ID: <CANLsYkxHbV_h=GUjKwOAwjhupineDuHh7xKWRVo3aNk-uPKD2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2018 at 11:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 16/05/18 18:29, Mathieu Poirier wrote:
>> On 16 May 2018 at 05:49, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>
>>> On 16/05/18 12:23, Suzuki K Poulose wrote:
>>>> On 05/16/2018 11:34 AM, Sudeep Holla wrote:
>>>
>>> [..]
>>>
>>>>> Hi Suzuki/Mathieu,
>>>>>
>>>>> I did a quick scan @ drivers/hwtracing/coresight/of_coresight.c to
>>>>> check if reg field is being used or not and whether this change
>>>>> causes any regression. I don't think so, but I may be wrong, let me
>>>>> know.
>>>>
>>>> Unfortunately, I think this would break the components like funnel,
>>>> where we need the input port number for the connected master to enable
>>>> the port. Similarly for the output port number for master components in
>>>> the paths. I have a set of patches which address this by taking care of
>>>> the port number order to find out the hardware port number.
>>>>
>>>
>>> Ah ok, I now see of_graph_parse_endpoint, sorry for missing that.
>>
>> The problem is not with of_graph_parse_endpoint(), that will work just
>> fine.  In fact you can add whatever number you want there without
>> impact on how devices see each other in the framework.  The problem is
>> that the port numbering doesn't reflect the HW layout anymore and as
>> such  you can't rely on the port value when configuring the HW.
>>
>
> Exactly, I had a chat with Suzuki. One option is to introduce new hwid
> field to fix that. If the field is present, it will be used and reg
> field will be ignored. In that way, you won't break the compatibility.

I had the same idea a while back and something Grant Likely and I
talked about at ELC-E 2017 in Prague.  This is the way I would prefer
to move forward on this.

> Just my thoughts. I am not sure if we need to support old kernel with
> updated DTs though. That may be difficult.

Not sure that can be done.  The only way to do that would be to
continue using the reg property, which isn't possible anymore.  As
such said DT wouldn't be upstream and I'm not sure we need to care
about those.

>
>>>
>>>> I will dust it up and send it. That would bring up another important
>>>> question.
>>>>
>>>
>>> Cool
>>>
>>>> How do we deal with the change in the port number scheme ? e.g, should
>>>> the new kernel support DTBs with old scheme ?
>>>
>>
>> DT files following the old scheme will spew out warnings like we're
>> getting on Juno and are bound to be fixed.
>>
> True, they can pick up the new changes too along with changes just
> fixing the warning.
>
>>> IIUC, that's needed for backward compatibility as it was used schema.
>>> Again I may be wrong.
>>>
>>>> If so, how do we specify that the DT uses new scheme.
>>>
>>> Perhaps, add something to indicate the change in numbering scheme ?
>>
>> The current customers should be moved to the new scheme.  That way we
>> don't have to support two different DT scheme (where one will die
>> eventually).
>>
>
> But the problem is if someone has DT which can't be modified and we move
> to new scheme only in the kernel, then they will see regression on their
> platforms. If that's fine, it simplifies things a lot. But I am not so
> sure of that ...

You have a point.  The code could check for both reg and hwid
properties.  If both are there hwid is preferred.  Otherwise the reg
property is used.  That wouldn't be too difficult to implement and
avoid introducing a regression.  Of course all this is fantasy until
we actually try things out.

Thanks,
Mathieu

>
> --
> Regards,
> Sudeep
