From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Apr 2018 13:50:46 -0400
Subject: [PATCH v8 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <CAKgT0UfbCzTGuwCnYiXOBL5Lm3AhYw6Kf5i0K2e19mTjise+Ew@mail.gmail.com>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
 <b8355df0-f3ba-c8c8-ccbb-53b1a294eab6@codeaurora.org>
 <CAKgT0UfbCzTGuwCnYiXOBL5Lm3AhYw6Kf5i0K2e19mTjise+Ew@mail.gmail.com>
Message-ID: <92f46034-f041-05e4-56b7-01ae4cb04efc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2018 1:47 PM, Alexander Duyck wrote:
> On Mon, Apr 2, 2018 at 7:59 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Alex,
>>
>> On 4/2/2018 3:06 PM, Sinan Kaya wrote:
>>> Code includes wmb() followed by writel() in multiple places. writel()
>>> already has a barrier on some architectures like arm64.
>>>
>>> This ends up CPU observing two barriers back to back before executing the
>>> register write.
>>>
>>> Since code already has an explicit barrier call, changing writel() to
>>> writel_relaxed().
>>>
>>> I did a regex search for wmb() followed by writel() in each drivers
>>> directory. I scrubbed the ones I care about in this series.
>>>
>>> I considered "ease of change", "popular usage" and "performance critical
>>> path" as the determining criteria for my filtering.
>>>
>>> We used relaxed API heavily on ARM for a long time but
>>> it did not exist on other architectures. For this reason, relaxed
>>> architectures have been paying double penalty in order to use the common
>>> drivers.
>>>
>>> Now that relaxed API is present on all architectures, we can go and scrub
>>> all drivers to see what needs to change and what can remain.
>>>
>>> We start with mostly used ones and hope to increase the coverage over time.
>>> It will take a while to cover all drivers.
>>>
>>> Feel free to apply patches individually.
>>>
>>> Change since 7:
>>>
>>> * API clarification with Linus and several architecture folks regarding
>>> writel()
>>>
>>> https://www.mail-archive.com/netdev at vger.kernel.org/msg225806.html
>>>
>>> * removed wmb() in front of writel() at several places.
>>> * remove old IA64 comments regarding ordering.
>>>
>>
>> What do you think about this version? Did I miss any SMP barriers?
> 
> I would say we should probably just drop the whole set and start over.
> If we don't need the wmb() we are going to need to go through and
> clean up all of these paths and consider the barriers when updating
> the layout of the code.
> 
> For example I have been thinking about it and in the case of x86 we
> are probably better off not bothering with the wmb() and
> writel_relaxed() and instead switch over to the smp_wmb() and writel()
> since in the case of a strongly ordered system like x86 or sparc this
> ends up translating out to a couple of compile barriers.
> 
> I will also need time to reevaluate the Rx paths since dropping the
> wmb() may have other effects which I need to verify.

Sounds good, I'll let you work on it.

@Jeff Kirsher: can you drop this version from your development branch until
Alex posts the next version?

> 
> Thanks.
> 
> - Alex
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
