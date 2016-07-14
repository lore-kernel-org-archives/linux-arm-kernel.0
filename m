From: nwatters@codeaurora.org (nwatters at codeaurora.org)
Date: Thu, 14 Jul 2016 13:33:50 -0400
Subject: [PATCH v2] iommu/arm-smmu-v3: limit use of 2-level stream tables
In-Reply-To: <20160714133107.GK29455@arm.com>
References: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
 <1468347560-29924-1-git-send-email-nwatters@codeaurora.org>
 <20160714133107.GK29455@arm.com>
Message-ID: <103772215d30a7c862f66200bbcc16ea@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-07-14 09:31, Will Deacon wrote:
> On Tue, Jul 12, 2016 at 02:19:20PM -0400, Nate Watterson wrote:
>> In the current arm-smmu-v3 driver, all smmus that support 2-level
>> stream tables are being forced to use them. This is suboptimal for
>> smmus that support fewer stream id bits than would fill in a single
>> second level table. This patch limits the use of 2-level tables to
>> smmus that both support the feature and whose first level table can
>> possibly contain more than a single entry.
> 
> Just to be clear, what exactly are you seeing as being suboptimal here?
> Is it the memory wastage from overallocating the L2 table, or something
> more?

Disregarding the config cache, fetching an STE when 2-level tables are
being used will require the hw to perform more memory accesses than it
would have to with a linear table since the L1 descriptor must also be
fetched. Presumably this is why the spec states, "ARM recommends that
a more efficient linear table is used instead of programming SPLIT >
LOG2SIZE".

My understanding is that the only benefit to using 2-level tables is
that it can save space when stream ids are sparsely distributed. Are
there any other compelling reasons to use them?

> 
> if it's just the memory allocation, I'd sooner restrict the span field
> in the L1 desc.

Although I am not especially concerned about the memory allocation, even
if the span was reduced, we would still be wasting a page for the L1
table unless L1 and L2 tables were allocated in a single 
dmam_alloc_coherent
call.

> 
> Will

Nate

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
