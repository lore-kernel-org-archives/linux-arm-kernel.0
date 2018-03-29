From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 29 Mar 2018 09:45:38 -0400
Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
In-Reply-To: <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
 <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
Message-ID: <d3ef68c2-bf18-9bc8-76ce-8077f3987189@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ariel,

On 3/29/2018 5:17 AM, Elior, Ariel wrote:
>> Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
>>
>> barrier() doesn't guarantee memory writes to be observed by the hardware on
>> all architectures. barrier() only tells compiler not to move this code
>> with respect to other read/writes.
>>
>> If memory write needs to be observed by the HW, wmb() is the right choice.
> The wmb() is there (a couple of lines above). Your modification adds an
> unnecessary fence which would hurt high pps scenarios. The memory
> writes which the HW needs to observe are the buffer descriptors, not the
> producer update message. The producer is written to the HW, and exists
> on the stack. The barrier() is there to prevent the compiler from mixing the
> order of the prod update message preparation and writing it to the host.
> A possible alternative would be to move the existing wmb() to where
> the barrier() is, achieving both goals, although in the existing design each
> barrier has a distinct purpose. The comment location is misleading, though.

I was told that barrier() is there to guarantee that HW is observing the memory
write before writel(). 

I reacted to this and changed barrier() to wmb() following the old directions. 
You are saying that this not true. 

Since then, Linus gave us direction not to have wmb() in front of writel() as
writel() already has memory-IO guarantee.

https://www.mail-archive.com/netdev at vger.kernel.org/msg225806.html

I'll be doing one more pass to remove wmb() before writel() soon. Please review
that carefully. 

Intel drivers use wmb() as a substitute for smp_wmb(). So, we can't always assume
that you can remove all wmb() in front of writel() as the write barrier seems to
serve dual purpose.

Please help me getting this right on the next version.

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
