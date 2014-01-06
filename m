From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 6 Jan 2014 18:42:13 -0500
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <20140106223906.GH27432@n2100.arm.linux.org.uk>
References: <m38uv1uuzr.fsf@t19.piap.pl> <m3ha9gx63v.fsf@t19.piap.pl>
 <20140106223906.GH27432@n2100.arm.linux.org.uk>
Message-ID: <52CB3F55.1050404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014 05:39 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 06, 2014 at 08:28:20PM +0100, Krzysztof Ha?asa wrote:
>> Russell, Santosh,
>>
>> the unneeded commit causing regression is still in place. Please try to
>> compile an ARM kernel without CONFIG_ARM_PATCH_PHYS_VIRT and with
>> CONFIG_ZONE_DMA and see for yourself, if you don't believe me.
>>
>> Please be aware that this commit fixes nothing, its only function is
>> causing the regression - so we don't lose anything by reverting it.
>>
>> If the attached wasn't clear, what the defective commit presently does
>> is changing a perfectly valid code into a code referencing a variable
>> which (without CONFIG_ARM_PATCH_PHYS_VIRT set) doesn't at all exist.
>>
>> With CONFIG_ARM_PATCH_PHYS_VIRT set, this commit does precisely nothing.
> 
> Right, so, with Assabet, which has CONFIG_DMA_ZONE=y and
> CONFIG_ARM_PATCH_PHYS_VIRT=y:
> 
> $ make O=../build/assabet arch/arm/mm/init.i
> 
> gives:
>   arm_dma_limit = __pv_phys_offset + arm_dma_zone_size - 1;
> 
> with or without Santosh's patch.  So, with V2P patching in place, there's
> absolutely no functional difference.
> 
> With CONFIG_ARM_PATCH_PHYS_VIRT=n, before Santosh's patch:
> 
>   arm_dma_limit = (0xc0000000UL) + arm_dma_zone_size - 1;
> 
> After:
> 
>   arm_dma_limit = __pv_phys_offset + arm_dma_zone_size - 1;
> 
> and this breaks the build because there is no __pv_phys_offset symbol.
> 
> Now, the case which matters for Santosh is the first case - the one
> where CONFIG_ARM_PATCH_PHYS_VIRT=y.  We can clearly see that after
> preprocessing, the results are 100% identical.
> 
> Therefore, I find myself agreeing with Krzysztof that the commit is
> bad, has no functional change for the case it was proposed to solve,
> and needs to be reverted.
> 
May be I missed your point but I ended up creating the patch because
the CMA reservation was failing on Keystone since the arm_dma_limit
wasn't right since it wasn't considering the actual __pv_phys_offset.

Isn't that an issue ?

Regards,
Santosh
