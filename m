From: awallis@codeaurora.org (Adam Wallis)
Date: Fri, 17 Nov 2017 12:17:26 -0500
Subject: [PATCH v3][for 4.15] dmaengine: dmatest: move callback wait queue
 to thread context
In-Reply-To: <79ea89ca-d8b6-0bfc-7bb5-053dcf5c40e4@codeaurora.org>
References: <1510927894-15297-1-git-send-email-awallis@codeaurora.org>
 <CAPcyv4hF=LjEdhPvD3TNWa4+XfN83NCuW2Lv7ERwo4ChFSyTbg@mail.gmail.com>
 <7637068c-4079-1235-cd6b-777907a42e8b@codeaurora.org>
 <CAPcyv4h2O7+nbxu2fyBNtcrisCntqRtFxAzDgP-7D9iAyGJSKw@mail.gmail.com>
 <79ea89ca-d8b6-0bfc-7bb5-053dcf5c40e4@codeaurora.org>
Message-ID: <66a44d84-76df-1b2a-4b6b-33011f1687a4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2017 12:01 PM, Adam Wallis wrote:
> On 11/17/2017 10:57 AM, Dan Williams wrote:
>> On Fri, Nov 17, 2017 at 7:28 AM, Adam Wallis <awallis@codeaurora.org> wrote:
>>> On 11/17/2017 10:12 AM, Dan Williams wrote:
>>>> On Fri, Nov 17, 2017 at 6:11 AM, Adam Wallis <awallis@codeaurora.org> wrote:
>>>>> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
>>>>> introduced a bug (that is in fact documented by the patch commit text)
>>>>> that leaves behind a dangling pointer. Since the done_wait structure is
>>>>> allocated on the stack, future invocations to the DMATEST can produce
>>>>> undesirable results (e.g., corrupted spinlocks).
>>>>>
>>>>> Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
>>>>> out") attempted to WARN the user that the stack was likely corrupted but
>>>>> did not fix the actual issue.
>>>>>
>>>>> This patch fixes the issue by pushing the wait queue and callback
>>>>> structs into the the thread structure. If a failure occurs due to time,
>>>>> dmaengine_terminate_all will force the callback to safely call
>>>>> wake_up_all() without possibility of using a freed pointer.
>>>>>
>>>>> Cc: stable at vger.kernel.org # 4.13.x: a9df21e: dmatest: Warn User
>>>>> Cc: stable at vger.kernel.org # 4.13.x
>>>>> Cc: stable at vger.kernel.org # 4.14.x
>>>>
>>>
>>> Sure - do you want me to remove them? I was just following the instructions on
>>> stable.
>>
>> It's not broken, just a note for next time.
>>
One last question - if all we need is Fixes and CC stable...how do we indicate a
dependency (for a cherry pick)?

Thanks


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
