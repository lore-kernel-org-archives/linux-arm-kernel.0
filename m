From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Oct 2017 13:58:49 +0100
Subject: [PATCH v2 1/3] iommu/arm-smmu-v3: put off the execution of TLBI*
 to reduce lock confliction
In-Reply-To: <1505221238-9428-2-git-send-email-thunder.leizhen@huawei.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
 <1505221238-9428-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20171018125849.GD4077@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thunder,

On Tue, Sep 12, 2017 at 09:00:36PM +0800, Zhen Lei wrote:
> Because all TLBI commands should be followed by a SYNC command, to make
> sure that it has been completely finished. So we can just add the TLBI
> commands into the queue, and put off the execution until meet SYNC or
> other commands. To prevent the followed SYNC command waiting for a long
> time because of too many commands have been delayed, restrict the max
> delayed number.
> 
> According to my test, I got the same performance data as I replaced writel
> with writel_relaxed in queue_inc_prod.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)

If we want to go down the route of explicit command batching, I'd much
rather do it by implementing the iotlb_range_add callback in the driver,
and have a fixed-length array of batched ranges on the domain. We could
potentially toggle this function pointer based on the compatible string too,
if it shows only to benefit some systems.

Will
