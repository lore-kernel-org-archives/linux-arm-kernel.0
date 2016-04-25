From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 Apr 2016 09:18:04 -0600
Subject: [PATCH V3 13/18] coresight: tmc: make sysFS and Perf mode
 mutually exclusive
In-Reply-To: <571E339E.9080306@arm.com>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
 <1461345255-11758-14-git-send-email-mathieu.poirier@linaro.org>
 <571E2A7F.2070802@arm.com>
 <CANLsYkywBS2_wXHsjELRy-s5y36W5_U29csBfTt0h=40TNbU-A@mail.gmail.com>
 <571E2F16.3010706@arm.com>
 <CANLsYkxJB2HzsDqwdKBJmUfVgnH7q7dF6+GQFhuSF+6-LzB_9Q@mail.gmail.com>
 <571E339E.9080306@arm.com>
Message-ID: <CANLsYkwbme0FcYOAp5McyXxh-rQ77jCS0WhyAOr1pqdtdaSBFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2016 at 09:11, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 25/04/16 16:05, Mathieu Poirier wrote:
>>
>> On 25 April 2016 at 08:52, Suzuki K Poulose <Suzuki.Poulose@arm.com>
>> wrote:
>>>
>>> On 25/04/16 15:48, Mathieu Poirier wrote:
>>>>
>>>>
>>>> On 25 April 2016 at 08:32, Suzuki K Poulose <Suzuki.Poulose@arm.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 22/04/16 18:14, Mathieu Poirier wrote:
>>>
>>>
>>>
>>>>>> +       spin_lock_irqsave(&drvdata->spinlock, flags);
>>>>>> +       if (drvdata->reading) {
>>>>>> +               ret = -EINVAL;
>>>>>> +               goto out;
>>>>>> +       }
>>>>>> +
>>>>>> +       val = local_xchg(&drvdata->mode, mode);
>>>>>> +       /*
>>>>>> +        * In Perf mode there can be only one writer per sink.  There
>>>>>> +        * is also no need to continue if the ETR is already operated
>>>>>> +        * from sysFS.
>>>>>> +        */
>>>>>> +       if (val != CS_MODE_DISABLED) {
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Could val be CS_MODE_PERF ? In other words, should we be checking :
>>>>>           if (val == CS_MODE_SYSFS)  instead ?
>>>>
>>>>
>>>>
>>>> If we check for CS_MODE_SYSFS we also have to check for CS_MODE_PERF,
>>>> which is two checks rather than a single one with the current
>>>> solution.
>>>
>>>
>>>
>>> I am confused now. The comment says, we want to check for sysfs mode and
>>> don't continue in that case. So, we shouldn't be worried about PERF mode.
>>
>>
>> You are correct about the sysFS part, but the first sentence of the
>> comment also mention that in perf mode there can only be one writer
>> per sink.  Otherwise ring buffers for one session would end up with
>> traces from other ongoing sessions, and that is not taking into
>> account the buffer management nightmares it would cause.
>
>
> OK, in either case, val == CS_MODE_SYSFS is much better check there, to
> what we want to do

If we check for SYSFS we also need to check for PERF.  Otherwise
nothing prevents another session from using the sink buffer, which is
not supported.

>
> Suzuki
