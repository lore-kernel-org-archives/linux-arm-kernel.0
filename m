From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 13:13:46 -0400
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <20180323.130418.2223623186761161723.davem@davemloft.net>
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
 <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
 <20180323.130418.2223623186761161723.davem@davemloft.net>
Message-ID: <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2018 1:04 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Fri, 23 Mar 2018 12:51:47 -0400
> 
>> It could if txdata->tx_db was not a union. There is a data dependency
>> between txdata->tx_db.data.prod and txdata->tx_db.raw. 
>>
>> So, no reordering.
> 
> I don't see it that way, the code requires that:
> 
>  	txdata->tx_db.data.prod += nbd;
> 
> is visible before the doorbell update.> 
> barrier() doesn't provide that.
> 
> Neither does writel_relaxed().  However plain writel() does.

Correct for some architectures including ARM but not correct universally.

writel() just guarantees register read/writes before and after to be
ordered when HW observes it. 

writel() doesn't guarantee that the memory update is visible to the HW
on all architectures.

If you need memory update visibility, that barrier() should have been a
wmb()

A correct multi-arch pattern is

wmb()
writel_relaxed()
mmiowb()

We have decided to drop a similar patch on Infiniband due to incorrect
usage of barrier(). If you feel strongly about it, I can remove the
DOORBELL change.

> 
> Therefore the code is only correct as-is, and your change potentially
> adds a reordering problem.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
