From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 24 Jan 2014 14:12:09 -0500
Subject: [PATCH V2 4/6] ARM: Make PID_IN_CONTEXTIDR incompatible with
 PID_NS
In-Reply-To: <52E2A866.1050400@codeaurora.org>
References: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
 <1390581656-16372-5-git-send-email-adrienverge@gmail.com>
 <20140124164343.GJ31040@mudshark.cambridge.arm.com>
 <CANsc=4UgWrFis6hi-0mXZAfery7YGDJ2F+NdZBzq6afwx_i58A@mail.gmail.com>
 <20140124171754.GM31040@mudshark.cambridge.arm.com>
 <52E2A866.1050400@codeaurora.org>
Message-ID: <52E2BB09.1020008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2014 12:52 PM, Christopher Covington wrote:
> On 01/24/2014 12:17 PM, Will Deacon wrote:
>> On Fri, Jan 24, 2014 at 05:16:28PM +0000, Adrien Verg? wrote:
>>> 2014/1/24 Will Deacon <will.deacon@arm.com>:
>>>> Are you sure about this? The value we write is actually task_pid_nr, which I
>>>> believe to be globally unique.
>>>
>>> You are right: the task_pid_nr is unique in the system. However when
>>> using namespaces, the so called "PID" is the virtual number that
>>> processes in different namespaces can share.
>>>
>>> This PID is the one visible by user-space tasks, in particular
>>> user-space tracers and debuggers. These programs would expect to find
>>> the PID of the traced process in the Context ID reg, while it is not.
>>> I think it is better to remove confusion by making PID_IN_CONTEXTIDR
>>> and PID_NS incompatible.
>>>
>>> What do you think?
>>
>> I think I'd rather have the global ID than disable a potentially useful
>> feature, especially since this is likely to be consumed by external trace
>> tools as opposed to user-space tasks.
> 
> We've discussed before that the ARM architecture doesn't say what should be
> written to the CONTEXTIDR, so it's up to us to decide. Will has a use case
> where the global PID is useful. Adrien's patches present a use case where I
> think the virtual PID would be useful. I've done work in the past where
> writing the process group ID was useful. Would it be reasonable to make what's
> written to the CONTEXTIDR run-time configurable? If so, what would be the best
> interface for configuring it?

D'oh, I mixed things up. For ETM to work it can only use global PID's in the
CONTEXTIDR.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
