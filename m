From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 31 Mar 2017 20:34:58 +0530
Subject: [PATCH v6 07/11] drivers: perf: hisi: Add support for Hisilicon
 SoC event counters
In-Reply-To: <20170331142351.GC6488@leverpostej>
References: <1489127311-112778-1-git-send-email-anurup.m@huawei.com>
 <20170321165252.GA29116@leverpostej> <58DCD47C.2010501@gmail.com>
 <20170330104607.GC16211@leverpostej> <58DE6400.8030900@gmail.com>
 <20170331142351.GC6488@leverpostej>
Message-ID: <58DE701A.2090604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 31 March 2017 07:53 PM, Mark Rutland wrote:
> On Fri, Mar 31, 2017 at 07:43:20PM +0530, Anurup M wrote:
>> On Thursday 30 March 2017 04:16 PM, Mark Rutland wrote:
>>>>>>> +	/*
>>>>>>>>>>> +	 * We must NOT create groups containing mixed PMUs, although
>>>>>>>>>>> +	 * software events are acceptable
>>>>>>>>>>> +	 */
>>>>>>>>>>> +	if (event->group_leader->pmu != event->pmu &&
>>>>>>>>>>> +	    !is_software_event(event->group_leader))
>>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>>> +
>>>>>>>>>>> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>>>>>>>>>>> +			    group_entry)
>>>>>>>>>>> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
>>>>>>>>>>> +			return -EINVAL;
>>>>>>> Please also check the number of counters.
>>>>> Sorry, I could not follow this comment correctly. Could you please explain ?
>>>>> I check the available counters and update used mask in pmu_add -->
>>>>> get_event_index
>>> What I meant was that here we should ensure that a group does not
>>> contain more events than can fit into counters.
>>>
>>> For example, if the HW had two counters, we should reject any group with
>>> more than two events. Such groups can never be scheduled, and make no
>>> sense.
>> I have referred drivers/bus/arm-cci.c and could find validate_group
>> and validate_event functions,
>> which create a fake_pmu to check the available counters for the
>> events in the group.
>> Is that the same way which is expected here? Please comment.
> Something like that.
>
> I think it's simplest to have a validate_group() function, which counts
> the number of counters used. See my suggestion in [1].

This looks simpler. Thanks for the suggestion.

~Anurup

> Thanks,
> Mark.
>
> [1] https://lkml.kernel.org/r/20170331135955.GB6488 at leverpostej
