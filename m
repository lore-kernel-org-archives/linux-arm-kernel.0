From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jul 2018 16:55:22 +0100
Subject: [PATCH v3 5/7] arm64: smp: remove cpu and numa topology
 information when hotplugging out CPU
In-Reply-To: <1c47b3fd-59ba-aba4-43b2-ed98e750887b@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
 <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdXw9My+P1UCJ19Qdjq4O9gY_0QVFZaw6C5Ytmpyac59Vw@mail.gmail.com>
 <20180717140536.GA27323@e107155-lin>
 <CAMuHMdUnL=XyoSfRU+ebVUjsiP89V4vcoN=O4xc0VwHmLP72HA@mail.gmail.com>
 <1c47b3fd-59ba-aba4-43b2-ed98e750887b@arm.com>
Message-ID: <5a23f1c8-27cb-b09c-90fc-edab3eec99f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/07/18 16:34, Sudeep Holla wrote:
> 
> 
> On 17/07/18 16:06, Geert Uytterhoeven wrote:
>> Hi Sudeep,
>>
>> On Tue, Jul 17, 2018 at 4:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On Tue, Jul 17, 2018 at 02:58:14PM +0200, Geert Uytterhoeven wrote:
>>>> On Fri, Jul 6, 2018 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> [...]
> 
>>>> All but CPU0 tested, as expected.
>>>
>>> OK, does the firmware on this system not allow CPU0 to be hotplugged out ?
>>
>> Correct. But that's not the issue.
>>
> 
> Yes,  was just trying to understand the behavior.
> 
> [..]
> 
>>>> Woops, CPU5-7 are not tested.
>>>
>>> I don't understand what you mean by that. From the logs, it looks fine.
>>> What do you mean by "CPU5-7 are not tested" ?
>>> Sorry, but I am finding it hard to understand the issue from the log.
>>
>> The above is not the log, but the diff between the log before and after the bad
>> commit. So lines prefixed with "-" are no longer printed.
>> Before, CPU4-7 were tested for hotplug in group 1.
>> After, only CPU4 is tested for hotplug in group 1.
>>
> 
> Ah OK, I think I now understand what is the issue, will try to replicate
> at my end and get back to you.
> 
Going through the code again, I think I understand the problem here.
We use the topology_core_mask pointers which are stashed in cpu_groups[]
But, the cpumask themselves will be getting modified as the cpus go up
and down, so we need to make a copy instead of just using the pointer.
I will see what we can do to fix that.

-- 
Regards,
Sudeep
