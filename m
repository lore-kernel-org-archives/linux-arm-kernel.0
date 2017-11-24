From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 24 Nov 2017 14:39:47 +0000
Subject: [PATCH] arm64: dts: Hi3660: Fix state id for 'CPU_NAP' state
In-Reply-To: <20171124065623.GD13184@leoy-linaro>
References: <1511415614-9859-1-git-send-email-leo.yan@linaro.org>
 <17639ecc-8ff8-e118-f6e1-51e2cfe4342b@arm.com>
 <20171124065623.GD13184@leoy-linaro>
Message-ID: <b62517be-1d4d-7b2e-7a6e-1c2abbb4ecee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/11/17 06:56, Leo Yan wrote:
> Hi Sudeep,
> 
> On Thu, Nov 23, 2017 at 02:03:51PM +0000, Sudeep Holla wrote:
>> Hi Daniel,
>>
>> Thanks a lot for pointing me to this and having some useful discussion
>> in private. That helped to dig a bit further on this.
>>
>> On 23/11/17 05:40, Leo Yan wrote:
>>> Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
>>> idle state. From ftrace log we can observe CA73 CPUs can be easily waken
>>> up from 'CPU_NAP' state but the 'waken up' CPUs doesn't handle anything
>>> and sleep again; so there have tons of trace events for CA73 CPUs
>>> entering and exiting idle state.
>>>
>>> On Hi3660 CA73 has retention state 'CPU_NAP' for CPU idle, this state we
>>> set its psci parameter as '0x0000001' and from this parameter it can
>>> calculate state id is 1. Unfortunately ARM trusted firmware (ARM-TF)
>>> takes 1 as a invalid value for state id, so the CPU cannot enter idle
>>> state and directly bail out to kernel.
>>>
>>> This commit changes psci parameter to '0x00000000' for state id = 0;
>>> this id is accepted by ARM trusted firmware and finally CPU can stay
>>> properly in 'CPU_NAP' state.
>>>
>>
>> I would like to conditionally NACK this patch. If we can't update the
>> ARM TF at all then, I will agree with this change reluctantly.
> 
> Thanks for reviewing. Just like Daniel said, we need to figure out the
> right method for this. So suggestions are very welcome!
> 

Sure, thanks for such a quick response and resolution :)

>> This looks like an artifact of copy paste in ARM TF port for this
>> platform. If you look as PSCI specification, CPU suspend parameter has
>> some recommendations and it's good to follow then unless you have strong
>> reasons not to.
>>
>> As Daniel pointed to me, this patch is required to satisfy TF
>> particularly [1]. Now that looks like copy pasted from Juno or FVP port
>> and if you look deeper, it's clearly under !ARM_RECOM_STATE_ID_ENC [2]
>> which was not copied IIUC :).
> 
> Thanks for sharing pointers. It's shame that the copying is not
> correct for Hikey960 :)
> 

Indeed.

> Come back to recommended state id, I reviewed Juno board defintion and
> I found it's not align with PSCI spec defintion, in ARM-TF Juno code
> defines state as below [1]:
> 

Yes Juno is almost 4 years old now, so it may not be too good a
reference platform for latest and greatest platforms like hikey2 ;)
As I said, Juno predates the recommendation in the PSCI spec.

> #define ARM_LOCAL_STATE_RUN     0
> #define ARM_LOCAL_STATE_RET     1
> #define ARM_LOCAL_STATE_OFF     2
> 
> In PSCI spec chapter "6.5 Recommended StateID Encoding" recommends power
> state id as below:
> 
> 0: Run
> 1: Standby
> 2: Retention
> 3: Powerdown
> 
> So could you confirm on Hikey960 we should follow PSCI definition for
> state id definition?
> 

Yes, I don't see any reason not to, as this may become reference to some
other platform, it's good to keep it aligned so that copy paste happens
in a good sense for future platforms. :)

>> Juno's implementation is legacy as these recommendations were added
>> later in the specification while Juno is 3 year old platform now.
>>
>> Though strictly speaking it's not violation of the PSCI specification,
>> but I would rather get this fixed not before it's too late and copied to
>> the next generation of platforms. Since the firmware can be easily
>> upgraded that shouldn't be that difficult.
> 
> If completely compliant with PSCI recommended state id, we need change
> both for ARM-TF and kernel for this. In ARM-TF, I have sent PR [2].
> 

OK

> For the kernel patch, we should change state id as below. Please let me
> know if you have suggestion for this.
> 

I would wait until ATF changes are merged before you patch DT in the kernel.

-- 
Regards,
Sudeep
