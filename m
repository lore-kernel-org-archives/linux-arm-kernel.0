From: cpandya@codeaurora.org (Chintan Pandya)
Date: Fri, 16 Mar 2018 12:44:36 +0530
Subject: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
In-Reply-To: <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
 <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
 <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
Message-ID: <7d1716a1-0a69-4851-68c6-ebc00d2e8e1d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/15/2018 8:46 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:55:32PM +0530, Chintan Pandya wrote:
>> On 3/15/2018 6:43 PM, Mark Rutland wrote:
>>> On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
>>>> Huge mapping changes PMD/PUD which could have
>>>> valid previous entries. This requires proper
>>>> TLB maintanance on some architectures, like
>>>> ARM64.
>>>
>>> Just to check, I take it that you mean we could have a valid table
>>> entry, but all the entries in that next level table must be invalid,
>>> right?
>>
>> That was my assumption but my assumption can be wrong if any VA gets
>> block mapping for 1G directly (instead of the 2M cases we discussed
>> so far), then this would go for a toss.
> 
> Ok. Just considering the 4K -> 2M case, is that an assumption, or a
> guarantee?
For 4K->2M case, that's confirmed. I mean, while mapping 2M, all the
next level entries will be unmapped and cleared. That gets ensured
before we land to page table code. But if someone calls these page table
APIs directly without respecting previous mappings, we will not hit
BUG_ON() anywhere but a crash later in unfamiliar situations. But that's
the wrong thing to do.

> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
