From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Sep 2017 13:00:50 +0100
Subject: [PATCH] arm64: KVM: VHE: reset PSTATE.UAO when switch to host
In-Reply-To: <eebc5831-79ff-c79c-34ff-37c852885bbe@huawei.com>
References: <1504763684-30128-1-git-send-email-gengdongjiu@huawei.com>
 <59B10F52.9010400@arm.com> <f710f68a-1e89-85a6-41a6-afc7588114db@huawei.com>
 <ec27c833-c9f7-d144-3c6f-a87a3bf3d97f@arm.com>
 <eebc5831-79ff-c79c-34ff-37c852885bbe@huawei.com>
Message-ID: <a2f82bb5-e61c-9c80-51c9-738fbcdd127e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/17 12:49, gengdongjiu wrote:
> 
> 
> On 2017/9/7 18:13, Marc Zyngier wrote:
>> On 07/09/17 11:05, gengdongjiu wrote:
>>> Hi James,
>>>
>>> On 2017/9/7 17:20, James Morse wrote:
>>>> Hi Dongjiu Geng,
>>>>
>>>> On 07/09/17 06:54, Dongjiu Geng wrote:
>>>>> In VHE mode, host kernel runs in the EL2 and can enable
>>>>> 'User Access Override' when fs==KERNEL_DS so that it can
>>>>> access kernel memory. However, PSTATE.UAO is set to 0 on
>>>>> an exception taken from EL1 to EL2. Thus when VHE is used
>>>>> and exception taken from a guest UAO will be disabled and
>>>>> host will use the incorrect PSTATE.UAO. So check and reset
>>>>> the PSTATE.UAO when switching to host.
>>>>
>>>> This would only be a problem if KVM were calling into world-switch with
>>>> fs==KERNEL_DS. I can't see where this happens.
>>>  Not only KVM, may also kernel sets the fs == KERNEL_DS before calling into world-switch
>>
>> How? Please describe the exact sequence of event that lead to this
>> situation with the current code base.
> 
> Hi Marc,
> 
>    Different tasks have different fs, such as USER_DS or KERNEL_DS. In the context switch, it will restore the
> task's fs. Thus, that depends on task itself, as shown below code. UAO is different with PAN, PAN will be always enabled if
> hardware CPU supports PAN feature, but UAO is dynamical change.

You haven't answered my question: There is exactly one point where we
enter the world-switch. Show me that, at this point, PSTATE.UAO *before*
the call is different from PSTATE.UAO after the call. Give me the exact
sequence of event that leads to this situation. Show me a stack trace.

Until you do this, I will ignore any further comment coming from you on
this subject.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
