From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Jan 2014 11:24:32 -0800
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <20140127181836.GH26766@pengutronix.de>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127181836.GH26766@pengutronix.de>
Message-ID: <52E6B270.4000702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/27/2014 10:18 AM, Uwe Kleine-K?nig wrote:
> On Mon, Jan 27, 2014 at 09:52:57AM -0800, Laura Abbott wrote:
>> The dma_mask for a device structure is a pointer. This pointer
>> needs to be set up before the dma mask can actually be set. Most
>> frameworks in the kernel take care of setting this up properly but
>> platform devices that don't follow a regular bus structure may not
>> ever have this set. As a result, checks such as dma_capable will
>> always return false on a raw platform device and dma_set_mask will
>> always return -EIO. Fix this by adding a dma_mask in the
>> platform_device archdata and setting it to be the dma_mask. Devices
>> used in other frameworks can change this as needed.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Suggested-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> Hello,
>
> there is another non-platform dependant approach available, that might
> be worth to evaluate:
>
> 	http://mid.gmane.org/1390817152-30898-1-git-send-email-ydroneaud at opteya.com
>

That covers dynamically allocated devices but it doesn't look like it 
covers devices setup with just platform_device_register like 
arch_setup_pdev_archdata does.

>> ---
>>   arch/arm64/include/asm/device.h |    1 +
>>   arch/arm64/kernel/setup.c       |    7 +++++++
>>   2 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
>> index cf98b36..209d40c 100644
>> --- a/arch/arm64/include/asm/device.h
>> +++ b/arch/arm64/include/asm/device.h
>> @@ -24,6 +24,7 @@ struct dev_archdata {
>>   };
>>
>>   struct pdev_archdata {
>> +	u64 dma_mask;
>>   };
>>
>>   #endif
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index bd9bbd0..f164347 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/dma-mapping.h>
>>
>>   #include <asm/cputype.h>
>>   #include <asm/elf.h>
>> @@ -337,3 +338,9 @@ const struct seq_operations cpuinfo_op = {
>>   	.stop	= c_stop,
>>   	.show	= c_show
>>   };
>> +
>> +void arch_setup_pdev_archdata(struct platform_device *pdev)
>> +{
>> +	pdev->archdata.dma_mask = DMA_BIT_MASK(32);
>> +	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
>> +}
> Is it save to assume a default of DMA_BIT_MASK(32)?
>

This seemed like a reasonable default and matches what powerpc does. Any 
device who wants to really guarantee a DMA mask should be setting the 
dma mask explicitly and not relying on a default.

> Best regards
> Uwe
>

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
