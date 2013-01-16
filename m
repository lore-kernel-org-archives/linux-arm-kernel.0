From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 16 Jan 2013 15:42:14 +0530
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <20130116100321.GA2325@e102568-lin.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
 <50F059A4.4010107@ti.com> <alpine.LFD.2.02.1301111425020.6300@xanadu.home>
 <50F10EF4.9070909@ti.com>
 <20130114122547.GA21142@e102568-lin.cambridge.arm.com>
 <50F4F5D2.5000706@ti.com> <20130115182059.GB1983@linaro.org>
 <50F649C4.70400@ti.com> <20130116100321.GA2325@e102568-lin.cambridge.arm.com>
Message-ID: <50F67CFE.7070109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 January 2013 03:33 PM, Lorenzo Pieralisi wrote:
> On Wed, Jan 16, 2013 at 06:33:40AM +0000, Santosh Shilimkar wrote:
>> On Tuesday 15 January 2013 11:50 PM, Dave Martin wrote:
>>> On Tue, Jan 15, 2013 at 11:53:14AM +0530, Santosh Shilimkar wrote:
>>>> On Monday 14 January 2013 05:55 PM, Lorenzo Pieralisi wrote:
>>>>> On Sat, Jan 12, 2013 at 07:21:24AM +0000, Santosh Shilimkar wrote:
>>>>>> On Saturday 12 January 2013 12:58 AM, Nicolas Pitre wrote:
>>>>>>> On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
>>>>>>>
>>>>>>>> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
>>>>>>>>> From: Dave Martin <dave.martin@linaro.org>
>>>>>>>>>
>>>>>>>>> +		/*
>>>>>>>>> +		 * Flush the local CPU cache.
>>>>>>>>> +		 *
>>>>>>>>> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
>>>>>>>>> +		 * a preliminary flush here for those CPUs.  At least, that's
>>>>>>>>> +		 * the theory -- without the extra flush, Linux explodes on
>>>>>>>>> +		 * RTSM (maybe not needed anymore, to be investigated).
>>>>>>>>> +		 */
>>>>>>>> This is expected if the entire code is not in one stack frame and the
>>>>>>>> additional flush is needed to avoid possible stack corruption. This
>>>>>>>> issue has been discussed in past on the list.
>>>>>>>
>>>>>>> I missed that.  Do you have a reference or pointer handy?
>>>>>>>
>>>>>>> What is strange is that this is 100% reproducible on RTSM while this
>>>>>>> apparently is not an issue on real hardware so far.
>>>>>>>
>>>>>> I tried searching archives and realized the discussion was in private
>>>>>> email thread. There are some bits and pieces on list but not all the
>>>>>> information.
>>>>>>
>>>>>> The main issue RMK pointed out is- An additional L1 flush needed
>>>>>> to avoid the effective change of view of memory when the C bit is
>>>>>> turned off, and the cache is no longer searched for local CPU accesses.
>>>>>>
>>>>>> In your case dcscb_power_down() has updated the stack which can be hit
>>>>>> in cache line and hence cache is dirty now. Then cpu_proc_fin() clears
>>>>>> the C-bit and hence for sub sequent calls the L1 cache won't be
>>>>>> searched. You then call flush_cache_all() which again updates the
>>>>>> stack but avoids searching the L1 cache. So it overwrites previous
>>>>>> saved stack frame. This seems to be an issue in your case as well.
>>>>>
>>>>> On A15/A7 even with the C bit cleared the D-cache is searched, the
>>>>> situation above cannot happen and if it does we are facing a HW/model bug.
>>>>> If this code is run on A9 then we have a problem since there, when the C bit
>>>>> is cleared D-cache is not searched (and that's why the sequence above
>>>>> should be written in assembly with no data access whatsoever), but on
>>>>> A15/A7 we do not.
>>>>>
>>>> Good point. May be model has modeled A9 and not A15 but in either
>>>> case, lets be consistent for all ARMv7 machines at least to avoid
>>>> people debugging similar issues. Many machines share code for ARMv7
>>>> processors so the best things is to stick to the sequence which works
>>>> across all ARMv7 processors.
>>>
>>> Is it sufficient to clarify the comment to indicate that the code is
>>> not directly reusable for other CPU combinations?
>>>
>> Thats not what I mean. CPU power down sequence is as per the
>> ARM specs so there shouldn't be an issue in case people
>> find it useful for other purposes. Thats other topc though.
>
> If they run it on an A9 there is an issue and as hotplug code for
> vexpress proved, copy'n'paste is a real danger.
>
>>
>>> DCSCB is incredibly platform-specific, and we would not expect to
>>> see it in other platforms.
>
> Agreed, but it is also the first example of power API implementation.
> Stubbing out this code in an assembly file valid for all v7 implementations
> is simple, provided we consider that worthwhile. I do. Or at least I can
> write the sequence up in /Documentation, how it should be done to be generic
> and describe the pitfalls.
>
>>>
>>> Or do we consider the risk of people copying this code verbatim
>>> (including the "do not copy this code" comment) too high?
>>>
>> I am not sure what exactly you mean. We are discussing the sequence
>> here on the basis of additional L1 cache flush. As mentioned
>> clearly the documentation is the ARM ARM(which is generic for
>> all ARMv7) missing to capture the need of the power
>> down code and stack usage which at least creates an issue on
>> A9. Documenting that in code and mainly in ARM specs would avoid
>> any further confusions.
>
> Power down sequence is defined explicitly in A15 and A7 TRMs. I do not
> think they should write "do not use the stack or cacheable memory that
> can result in dirty lines" in betweeen the power down steps. Once you
> know the C bit behaviour coding follows. True, they might add this for
> A9, and I asked that, to no avail, for internal reasons.
>
Fair enough.

> Documenting it in the kernel won't hurt either. And to answer Dave, I
> think that copy'n'paste verbatim is a risk we should not run, unless we
> are willing to be on the lookout for bugs. I can write up some documentation
> that we can merge along with the power API.
>
+1

Regards,
Santosh
