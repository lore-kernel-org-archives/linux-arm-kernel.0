From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 27 Mar 2018 08:42:05 -0400
Subject: [PATCH v7 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <862cdbeafb9cfd272a426b010943ffc5@codeaurora.org>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcaxM8Mj9Y9fR0B+aafTm1SzTqh+gHT5ozgvyaoHvrzRQ@mail.gmail.com>
 <1521849496.15055.16.camel@intel.com>
 <862cdbeafb9cfd272a426b010943ffc5@codeaurora.org>
Message-ID: <e3ada376-52a5-573b-33f1-9aa84af75f0d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeff,

On 3/23/2018 10:34 PM, okaya at codeaurora.org wrote:
> On 2018-03-23 19:58, Jeff Kirsher wrote:
>> On Fri, 2018-03-23 at 14:53 -0700, Alexander Duyck wrote:
>>> On Fri, Mar 23, 2018 at 11:52 AM, Sinan Kaya <okaya@codeaurora.org>
>>> wrote:
>>> > Code includes wmb() followed by writel() in multiple places. writel()
>>> > already has a barrier on some architectures like arm64.
>>> >
>>> > This ends up CPU observing two barriers back to back before executing
>>> > the
>>> > register write.
>>> >
>>> > Since code already has an explicit barrier call, changing writel() to
>>> > writel_relaxed().
>>> >
>>> > I did a regex search for wmb() followed by writel() in each drivers
>>> > directory.
>>> > I scrubbed the ones I care about in this series.
>>> >
>>> > I considered "ease of change", "popular usage" and "performance
>>> > critical
>>> > path" as the determining criteria for my filtering.
>>> >
>>> > We used relaxed API heavily on ARM for a long time but
>>> > it did not exist on other architectures. For this reason, relaxed
>>> > architectures have been paying double penalty in order to use the
>>> > common
>>> > drivers.
>>> >
>>> > Now that relaxed API is present on all architectures, we can go and
>>> > scrub
>>> > all drivers to see what needs to change and what can remain.
>>> >
>>> > We start with mostly used ones and hope to increase the coverage over
>>> > time.
>>> > It will take a while to cover all drivers.
>>> >
>>> > Feel free to apply patches individually.
>>>
>>> I looked over the set and they seem good.
>>>
>>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> Grrr, patch 1 does not apply cleanly to my next-queue tree (dev-queue
>> branch).? I will deal with this series in a day or two, after I have dealt
>> with my driver pull requests.
> 
> Sorry, you will have to replace the ones you took from me.

Double sorry now.

I don't know if you have been following "RFC on writel and writel_relaxed" thread
or not but there are some new developments about wmb() requirement. 

Basically, wmb() should never be used before writel() as writel() seem to
provide coherency and observability guarantee.

wmb()+writel_relaxed() is slower on some architectures than plain writel()

I'll have to rework these patches to have writel() only. 

Are you able to drop the applied ones so that I can post V8 or is it too late?


Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
