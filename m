From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 14 Mar 2018 18:57:40 -0400
Subject: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
 <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
 <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
Message-ID: <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On 3/14/2018 5:49 PM, Alexander Duyck wrote:
> On Wed, Mar 14, 2018 at 5:13 AM,  <okaya@codeaurora.org> wrote:
>> On 2018-03-14 01:08, Timur Tabi wrote:
>>>
>>> On 3/13/18 10:20 PM, Sinan Kaya wrote:

> Actually I would argue this whole patch set is pointless. For starters
> why is it we are only updating the Intel Ethernet drivers here? 

I did a regex search for wmb() followed by writel() in each drivers directory.
I scrubbed the ones I care about and posted this series. Note also that
I have one Infiniband patch in the series. 

I considered "ease of change", "popular usage" and "performance critical
path" as the determining criteria for my filtering. 


> This
> seems like something that is going to impact the whole kernel tree
> since many of us have been writing drivers for some time assuming x86
> style behavior.

That's true. We used relaxed API heavily on ARM for a long time but
it did not exist on other architectures. For this reason, relaxed
architectures have been paying double penalty in order to use the common
drivers. 

Now that relaxed API is present on all architectures, we can go and scrub
all drivers to see what needs to change and what can remain.

> 
> It doesn't make sense to be optimizing the drivers for one subset of
> architectures. The scope of the work needed to update the drivers for
> this would be ridiculous. Also I don't see how this could be expected
> to work on any other architecture when we pretty much need to have a
> wmb() before calling the writel on x86 to deal with accesses between
> coherent and non-coherent memory. It seems to me more like somebody
> added what they considered to be an optimization somewhere that is a
> workaround for a poorly written driver. Either that or the barrier is
> serving a different purpose then the one we were using.

Is there a semantic problem with the definition of wmb() vs. writel() vs.
writel_relaxed()? I thought everything is well described in barriers
document about what to expect from these APIs.

AFAIK, writel() is equal to writel_relaxed() on x86 architecture.
It doesn't really change anything for x86 but it saves barriers on
other architectures.

> 
> It would make more sense to put in the effort making writel and
> writel_relaxed consistent between architectures before we go through
> and start modifying driver code to support different architectures.
> 

Is there an arch problem that I'm not seeing?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
