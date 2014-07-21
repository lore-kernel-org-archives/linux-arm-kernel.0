From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 21 Jul 2014 12:33:48 -0700
Subject: [PATCHv4 3/5] common: dma-mapping: Introduce common remapping
 functions
In-Reply-To: <20140718135349.GB4608@arm.com>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
 <20140718135349.GB4608@arm.com>
Message-ID: <53CD6B1C.2010801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2014 6:53 AM, Catalin Marinas wrote:
> On Wed, Jul 02, 2014 at 07:03:36PM +0100, Laura Abbott wrote:
>> +void *dma_common_pages_remap(struct page **pages, size_t size,
>> +			unsigned long vm_flags, pgprot_t prot,
>> +			const void *caller)
>> +{
>> +	struct vm_struct *area;
>> +
>> +	area = get_vm_area_caller(size, vm_flags, caller);
>> +	if (!area)
>> +		return NULL;
>> +
>> +	if (map_vm_area(area, prot, &pages)) {
>> +		vunmap(area->addr);
>> +		return NULL;
>> +	}
>> +
>> +	return area->addr;
>> +}
> 
> Why not just replace this function with vmap()? It is nearly identical.
> 

With this version, the caller stored and printed via /proc/vmallocinfo
is the actual caller of the DMA API whereas if we just call vmap we
don't get any useful caller information. Going to vmap would change
the existing behavior on ARM so it seems unwise to switch. Another
option is to move this into vmalloc.c and add vmap_caller.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
