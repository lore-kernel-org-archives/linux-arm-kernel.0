From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Nov 2013 10:40:05 -0500
Subject: [PATCH 3/6] ARM: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <20131115142014.GN16735@n2100.arm.linux.org.uk>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
 <20131115142014.GN16735@n2100.arm.linux.org.uk>
Message-ID: <52864055.4010200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013 09:20 AM, Russell King - ARM Linux wrote:
> On Thu, Nov 14, 2013 at 02:37:43PM -0500, Santosh Shilimkar wrote:
>> Slab allocator can allocate memory beyond the lowmem watermark
>> which can lead to false failure of virt_addr_valid().
> 
> This is definitely going to cause problems.
> 
>> So drop the check. The issue was seen with percpu_alloc()
>> in KVM code which was allocating memory beyond lowmem watermark.
>>
>> Am not completly sure whether this is the right fix and if it could
>> impact any other user of virt_addr_valid(). Without this fix as
>> pointed out the KVM init was failing in my testing.
> 
> virt_addr_valid() gets used in some places to check whether the virtual
> address is part of the lowmem mapping and explicitly not part of vmalloc()
> or DMA coherent space:
> 
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> drivers/net/wireless/ath/ath6kl/sdio.c
> 
> It opens up the checks in include/linux/scatterlist.h to start accepting
> non-streaming DMA capable buffers as well.
> 
> It also bypasses a check in the slab code to ensure that it's a potentially
> valid pointer that was handed out by slab.
> 
Thanks for the additional information Russell. We are going with an alternate
approach from Marc so this patch will be dropped any ways.

Regards,
Santosh
