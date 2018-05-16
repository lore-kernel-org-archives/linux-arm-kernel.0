From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 16 May 2018 11:29:45 -0600
Subject: [PATCH] arm64: dts: juno: fix graph node unit addresses for
 coresight components
In-Reply-To: <eba4cddf-f668-a5e1-acea-5e6538c230f0@arm.com>
References: <1526466862-19173-1-git-send-email-sudeep.holla@arm.com>
 <574f6959-6a84-9e0e-3d89-84d2d75d9191@arm.com>
 <eba4cddf-f668-a5e1-acea-5e6538c230f0@arm.com>
Message-ID: <CANLsYkyi+m_uQydSWZkf_e1PNSoU-n1rLixuJ0+P9G8hpm68TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2018 at 05:49, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 16/05/18 12:23, Suzuki K Poulose wrote:
>> On 05/16/2018 11:34 AM, Sudeep Holla wrote:
>
> [..]
>
>>> Hi Suzuki/Mathieu,
>>>
>>> I did a quick scan @ drivers/hwtracing/coresight/of_coresight.c to
>>> check if reg field is being used or not and whether this change
>>> causes any regression. I don't think so, but I may be wrong, let me
>>> know.
>>
>> Unfortunately, I think this would break the components like funnel,
>> where we need the input port number for the connected master to enable
>> the port. Similarly for the output port number for master components in
>> the paths. I have a set of patches which address this by taking care of
>> the port number order to find out the hardware port number.
>>
>
> Ah ok, I now see of_graph_parse_endpoint, sorry for missing that.

The problem is not with of_graph_parse_endpoint(), that will work just
fine.  In fact you can add whatever number you want there without
impact on how devices see each other in the framework.  The problem is
that the port numbering doesn't reflect the HW layout anymore and as
such  you can't rely on the port value when configuring the HW.

>
>> I will dust it up and send it. That would bring up another important
>> question.
>>
>
> Cool
>
>> How do we deal with the change in the port number scheme ? e.g, should
>> the new kernel support DTBs with old scheme ?
>

DT files following the old scheme will spew out warnings like we're
getting on Juno and are bound to be fixed.

> IIUC, that's needed for backward compatibility as it was used schema.
> Again I may be wrong.
>
>> If so, how do we specify that the DT uses new scheme.
>
> Perhaps, add something to indicate the change in numbering scheme ?

The current customers should be moved to the new scheme.  That way we
don't have to support two different DT scheme (where one will die
eventually).

>
> --
> Regards,
> Sudeep
