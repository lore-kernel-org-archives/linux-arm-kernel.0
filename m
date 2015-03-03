From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 03 Mar 2015 13:10:34 +0000
Subject: [RFC PATCH v2 3/3] arm64: hook up IOMMU dma_ops
In-Reply-To: <54F59565.7000807@huawei.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
 <482b3b109a3d4818b1b1e693f488a919cf1bb707.1423226542.git.robin.murphy@arm.com>
 <54F59565.7000807@huawei.com>
Message-ID: <54F5B2CA.9050907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 11:05, leizhen wrote:
> On 2015/2/6 22:55, Robin Murphy wrote:
>> With iommu_dma_ops in place, hook them up to the configuration code, so
>> IOMMU-fronted devices will get them automatically.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   arch/arm64/Kconfig                   |  1 +
>>   arch/arm64/include/asm/dma-mapping.h | 11 ++++++-----
>>   arch/arm64/mm/dma-mapping.c          | 15 +++++++++++++++
>>   3 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b1f9a20..e2abcdc 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -66,6 +66,7 @@ config ARM64
>>   	select HAVE_PERF_USER_STACK_DUMP
>>   	select HAVE_RCU_TABLE_FREE
>>   	select HAVE_SYSCALL_TRACEPOINTS
>> +	select IOMMU_DMA if IOMMU_SUPPORT
>
> IOMMU_SUPPORT is selected above, so "if IOMMU_SUPPORT" can be omitted.
> And I suggest putting "select IOMMU_DMA" next to "select IOMMU_SUPPORT".

Not in this patch set it isn't ;)

Omitting the "if IOMMU_SUPPORT" at this point results in this for me:

*** Default configuration is based on 'defconfig'
warning: (ARM64) selects IOMMU_DMA which has unmet direct dependencies 
(IOMMU_SUPPORT && NEED_SG_DMA_LENGTH)

Furthermore, if IOMMU_SUPPORT is selected anywhere I think it should be 
in defconfig, rather than here - if the user wants to leave out all the 
IOMMU drivers, then they should be able to turn off IOMMU_SUPPORT as 
well (since it makes no sense on its own), at which point the 
architecture then needs to make sure that IOMMU_DMA is deselected. 
Unless there's a more elegant way to enforce that, I think this 
"select...if..." needs to stay as it is.

Robin.
