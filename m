From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 27 Mar 2018 08:40:41 -0400
Subject: [PATCH v7 0/7] netdev: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <20180326.124846.2182144342929084561.davem@davemloft.net>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <20180326.124846.2182144342929084561.davem@davemloft.net>
Message-ID: <044d58fd-b6ea-6341-0cdf-d99c47fc241e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

On 3/26/2018 12:48 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Sun, 25 Mar 2018 10:39:14 -0400
> 
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
>> directory.
>> I scrubbed the ones I care about in this series.
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
>> Changes since v6:
>> - bring back amazon ena and add mmiowb, remove
>>   ena_com_write_sq_doorbell_rel(). 
>> - remove extra mmiowb in bnx2x
>> - correct spelling mistake in  bnx2x: Replace doorbell barrier() with wmb()
> 
> Series applied, thank you.
> 

I don't know if you have been following "RFC on writel and writel_relaxed" thread
or not but there are some new developments about wmb() requirement. 

Basically, wmb() should never be used before writel() as writel() seem to
provide coherency and observability guarantee.

wmb()+writel_relaxed() is slower on some architectures than plain writel()

I'll have to rework these patches to have writel() only. 

Are you able to drop the applied ones so that I can post V7 or is it too late?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
