From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 09:07:36 -0500
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <4041362.9GKaSPm9gs@wuerfel>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-2-git-send-email-okaya@codeaurora.org>
 <564046B3.8090505@suse.de> <4041362.9GKaSPm9gs@wuerfel>
Message-ID: <5640A8A8.90203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 3:59 AM, Arnd Bergmann wrote:
> On Monday 09 November 2015 08:09:39 Hannes Reinecke wrote:
>> On 11/09/2015 02:57 AM, Sinan Kaya wrote:
>>> Current code gives up when 32 bit DMA is not supported.
>>> This problem has been observed on systems without any
>>> memory below 4 gig.
>>>
>>> This patch tests 64 bit support before bailing out to find
>>> a working combination.
>>>
>> That feels decidedly odd.
>>
>> Why do you probe for 64bit if 32bit fails?
>
> 32-bit DMA mask on PCI cannot fail, we rely on that in all sorts
> of places. If the machine has all of its RAM visible above 4GB
> PCI bus addresses, it must use an IOMMU.

Can you be specific? PCIe does not have this limitation. It supports 32 
bit and 64 bit TLPs.

I have not seen any limitation so far in the OS either.

Using IOMMU is fine but not required if the endpoint is a true 64 bit 
supporting endpoint. This endpoint supports 64bit too.

>
>> Typically it's the other way round, on the grounds that 64bit DMA
>> should be preferred over 32bit.
>> Can you explain why it needs to be done the other way round here?
>
> Something else is odd here, the driver already checks for
> dma_get_required_mask(), which will return the smallest mask
> that fits all of RAM. If the machine has any memory above 4GB,
> it already uses the 64-bit mask, and only falls back to
> the 32-bit mask if that fails or if all memory fits within the
> first 4GB.
>

I'll add some prints in the code to get to the bottom of it. I think the 
code is checking more than just the required mask and failing in one of 
the other conditions. At least that DMA comparison code was more than 
what I have ever seen.


> So both the description and the patch are wrong. :(
>
> 	Arnd
>

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
