From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 12:51:47 -0400
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <20180323.124326.2170503491903886041.davem@davemloft.net>
References: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
 <20180323.122035.1380806748695640531.davem@davemloft.net>
 <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
Message-ID: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2018 12:43 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Fri, 23 Mar 2018 12:31:12 -0400
> 
>> Sorry, you got me confused now.
>>
>> If you look at the code closer, you'll see this.
>>
>> 	wmb();
>>
>> 	txdata->tx_db.data.prod += nbd;
>> 	barrier();
>>
>> 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
>>
>> and you also asked me to rename DOORBELL to DOORBELL_RELAXED() to make
>> it obvious that we have a relaxed operator inside the macro.
> 
> This still doesn't match the stated pattern.

I can certainly update the commit text for this or spin into its own
patch to make it obvious.

> 
> 	wmb();
> 	/* no other memory or I/O or IOMEM operation */
> 	writel();
> 
> There is a write to a producer index there and then no non-compiler
> barrier or any kind before the writel().
> 
> So, in fact, it might really need that implicit writel() barrier here!
> 

It could if txdata->tx_db was not a union. There is a data dependency
between txdata->tx_db.data.prod and txdata->tx_db.raw. 

So, no reordering.

I can argue that barrier() here is useless in fact.

Anyhow, I'll spin this piece out of this patch so that we pay special
attention with a better description.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
