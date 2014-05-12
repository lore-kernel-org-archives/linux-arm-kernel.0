From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 12 May 2014 09:27:27 -0700
Subject: Questions regarding DMA buffer sharing using IOMMU
In-Reply-To: <BAY169-W1156E6803829CAB545274BCEF350@phx.gbl>
References: <BAY169-W12541AD089785F8BFBD4E26EF350@phx.gbl>,
 <5218408.5YRJXjS4BX@wuerfel>
 <BAY169-W1156E6803829CAB545274BCEF350@phx.gbl>
Message-ID: <5370F66F.7060204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/12/2014 7:37 AM, Pintu Kumar wrote:
> Hi,
> Thanks for the reply.
> 
> ----------------------------------------
>> From: arnd at arndb.de
>> To: linux-arm-kernel at lists.infradead.org
>> CC: pintu.k at outlook.com; linux-mm at kvack.org; linux-kernel at vger.kernel.org; linaro-mm-sig at lists.linaro.org
>> Subject: Re: Questions regarding DMA buffer sharing using IOMMU
>> Date: Mon, 12 May 2014 14:00:57 +0200
>>
>> On Monday 12 May 2014 15:12:41 Pintu Kumar wrote:
>>> Hi,
>>> I have some queries regarding IOMMU and CMA buffer sharing.
>>> We have an embedded linux device (kernel 3.10, RAM: 256Mb) in
>>> which camera and codec supports IOMMU but the display does not support IOMMU.
>>> Thus for camera capture we are using iommu buffers using
>>> ION/DMABUF. But for all display rendering we are using CMA buffers.
>>> So, the question is how to achieve buffer sharing (zero-copy)
>>> between Camera and Display using only IOMMU?
>>> Currently we are achieving zero-copy using CMA. And we are
>>> exploring options to use IOMMU.
>>> Now we wanted to know which option is better? To use IOMMU or CMA?
>>> If anybody have come across these design please share your thoughts and results.
>>
>> There is a slight performance overhead in using the IOMMU in general,
>> because the IOMMU has to fetch the page table entries from memory
>> at least some of the time.
> 
> Ok, we need to check performance later
> 
>>
>> If that overhead is within the constraints you have for transfers between
>> camera and codec, you are always better off using IOMMU since that
>> means you don't have to do memory migration.
> 
> Transfer between camera is codec is fine. But our major concern is single buffer 
> sharing between camera & display. Here camera supports iommu but display does not support iommu.
> Is it possible to render camera preview (iommu buffers) on display (not iommu and required physical contiguous overlay memory)?
> 

I'm pretty sure the answer is no for zero copy IOMMU buffers if one of your
devices does not support IOMMU. If the data is coming in as individual pages
and the hardware does not support scattered pages there isn't much you can
do except copy to a contiguous buffer. At least with Ion, the heap types can
be set up in a particular way such that the client need never know about the
existence of an IOMMU or not. 

> Also is it possible to buffer sharing between 2 iommu supported devices?
> 

I don't see why not but there isn't a lot of information to go on here.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
