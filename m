From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Tue, 3 Apr 2018 10:47:59 -0700
Subject: [PATCH v8 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <b8355df0-f3ba-c8c8-ccbb-53b1a294eab6@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
 <b8355df0-f3ba-c8c8-ccbb-53b1a294eab6@codeaurora.org>
Message-ID: <CAKgT0UfbCzTGuwCnYiXOBL5Lm3AhYw6Kf5i0K2e19mTjise+Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 7:59 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Alex,
>
> On 4/2/2018 3:06 PM, Sinan Kaya wrote:
>> Code includes wmb() followed by writel() in multiple places. writel()
>> already has a barrier on some architectures like arm64.
>>
>> This ends up CPU observing two barriers back to back before executing the
>> register write.
>>
>> Since code already has an explicit barrier call, changing writel() to
>> writel_relaxed().
>>
>> I did a regex search for wmb() followed by writel() in each drivers
>> directory. I scrubbed the ones I care about in this series.
>>
>> I considered "ease of change", "popular usage" and "performance critical
>> path" as the determining criteria for my filtering.
>>
>> We used relaxed API heavily on ARM for a long time but
>> it did not exist on other architectures. For this reason, relaxed
>> architectures have been paying double penalty in order to use the common
>> drivers.
>>
>> Now that relaxed API is present on all architectures, we can go and scrub
>> all drivers to see what needs to change and what can remain.
>>
>> We start with mostly used ones and hope to increase the coverage over time.
>> It will take a while to cover all drivers.
>>
>> Feel free to apply patches individually.
>>
>> Change since 7:
>>
>> * API clarification with Linus and several architecture folks regarding
>> writel()
>>
>> https://www.mail-archive.com/netdev at vger.kernel.org/msg225806.html
>>
>> * removed wmb() in front of writel() at several places.
>> * remove old IA64 comments regarding ordering.
>>
>
> What do you think about this version? Did I miss any SMP barriers?

I would say we should probably just drop the whole set and start over.
If we don't need the wmb() we are going to need to go through and
clean up all of these paths and consider the barriers when updating
the layout of the code.

For example I have been thinking about it and in the case of x86 we
are probably better off not bothering with the wmb() and
writel_relaxed() and instead switch over to the smp_wmb() and writel()
since in the case of a strongly ordered system like x86 or sparc this
ends up translating out to a couple of compile barriers.

I will also need time to reevaluate the Rx paths since dropping the
wmb() may have other effects which I need to verify.

Thanks.

- Alex
