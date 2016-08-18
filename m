From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 18 Aug 2016 09:55:55 -0700
Subject: [PATCH 1/1] ARM: dma: fix dma_max_pfn()
In-Reply-To: <20160818142459.GX1041@n2100.armlinux.org.uk>
References: <1471435517-7840-1-git-send-email-rogerq@ti.com>
 <1471435517-7840-2-git-send-email-rogerq@ti.com>
 <20160818142459.GX1041@n2100.armlinux.org.uk>
Message-ID: <8003b6ed-6071-9384-1b88-0b84604bdce8@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 8/18/2016 7:24 AM, Russell King - ARM Linux wrote:
> On Wed, Aug 17, 2016 at 03:05:17PM +0300, Roger Quadros wrote:
>> Since commit 6ce0d2001692 ("ARM: dma: Use dma_pfn_offset for dma address translation"),
>> dma_to_pfn() already returns the PFN with the physical memory start offset
>> so we don't need to add it again.
>>
>> This fixes USB mass storage lock-up problem on systems that can't do DMA
>> over the entire physical memory range (e.g.) Keystone 2 systems with 4GB RAM
>> can only do DMA over the first 2GB. [K2E-EVM].
>>
>> What happens there is that without this patch SCSI layer sets a wrong
>> bounce buffer limit in scsi_calculate_bounce_limit() for the USB mass
>> storage device. dma_max_pfn() evaluates to 0x8fffff and bounce_limit
>> is set to 0x8fffff000 whereas maximum DMA'ble physical memory on Keystone 2
>> is 0x87fffffff. This results in non DMA'ble pages being given to the
>> USB controller and hence the lock-up.
>>
>> NOTE: in the above case, USB-SCSI-device's dma_pfn_offset was showing as 0.
>> This should have really been 0x780000 as on K2e, LOWMEM_START is 0x80000000
>> and HIGHMEM_START is 0x800000000. DMA zone is 2GB so dma_max_pfn should be
>> 0x87ffff. The incorrect dma_pfn_offset for the USB storage device is because
>> USB devices are not correctly inheriting the dma_pfn_offset from the
>> USB host controller. This will be fixed by a separate patch.
>
> I'd like to hear from Santosh, as the author of the original change.
> The original commit doesn't mention which platform it was intended for
> or what the problem was, which would've been helpful.
>
 From what I recollect, we did these changes to make the max pfn behave
same on ARM arch as other archs. This patch was evolved as part of
fixing the max*pfn assumption.

commit 26ba47b18318abe7dadbe9294a611c0e932651d8
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Thu Aug 1 03:12:01 2013 +0100

     ARM: 7805/1: mm: change max*pfn to include the physical offset of 
memory

     Most of the kernel code assumes that max*pfn is maximum pfns because
     the physical start of memory is expected to be PFN0. Since this
     assumption is not true on ARM architectures, the meaning of max*pfn
     is number of memory pages. This is done to keep drivers happy which
     are making use of of these variable to calculate the dma bounce limit
     using dma_mask.

     Now since we have a architecture override possibility for DMAable
     maximum pfns, lets make meaning of max*pfns as maximum pnfs on ARM
     as well.

>>
>> Fixes: 6ce0d2001692 ("ARM: dma: Use dma_pfn_offset for dma address translation")
>> Cc: stable at vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/include/asm/dma-mapping.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index d009f79..bf02dbd 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -111,7 +111,7 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>>  /* The ARM override for dma_max_pfn() */
>>  static inline unsigned long dma_max_pfn(struct device *dev)
>>  {
>> -	return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);
>> +	return dma_to_pfn(dev, *dev->dma_mask);
>>  }
>>  #define dma_max_pfn(dev) dma_max_pfn(dev)
By doing this change I hope we don't break other drivers on Keystone so
am not sure about the change.
