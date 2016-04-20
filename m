From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Apr 2016 11:51:06 +0100
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <57175DA7.3000505@arm.com>
References: <57064992.1060509@arm.com> <570737F5.30105@nvidia.com>
 <5707FC9F.50905@arm.com> <570B50B4.4020304@nvidia.com>
 <571706FF.1010300@nvidia.com> <57175DA7.3000505@arm.com>
Message-ID: <57175F1A.5060708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/16 11:44, Robin Murphy wrote:
> Hi Alex,
>
> On 20/04/16 05:35, Alexandre Courbot wrote:
> [...]
>>>> Bisection came down to 1733a2ad3674("drm/nouveau/device/pci: set as
>>>> non-CPU-coherent on ARM64"), and sure enough reverting that removes the
>>>> crash.
>>>
>>> Thanks for taking the time to bisect this. And apologies as it seems my
>>> commit is the reason for your troubles.
>>>
>>> The CPU coherency flag is used for two things: explicitly sync buffers
>>> pages when required, and allocating buffers that are not explicitly
>>> synced (like fences or pushbuffers) using the DMA API. For this latter
>>> use, it also accesses the buffer's content using the mapping provided by
>>> dma_alloc_coherent() instead of creating a new one. All nouveau_bos are
>>> supposed to be written using nouveau_bo_rd32(), and this function
>>> handles the case of an DMA-API allocated object by detecting that the
>>> result of ttm_kmap_obj_virtual() is NULL.
>>>
>>> But as it turns out, OUT_RINGp() also calls ttm_kmap_obj_virtual() in
>>> order to perform a memcpy and uses its result directly - which means we
>>> are doing memcpy on a NULL pointer. We never caught this because we
>>> typically do not use Nouveau's fbcon with an ARM setup.
>>>
>>> I don't really like this special access for coherent objects, and
>>> actually had a patch in my tree to attempt to remove it (attached).
>>> Although it is not the whole solution (see below), the issue should at
>>> least not be visible with it applied - could you confirm?
>>
>> Hi Robin, could you confirm whether the attached patch in my previous
>> mail helps with your problem?
>
> With that patch on top of -rc4, it's conjuring up something that looks
> somewhat more like a real address on top of the offset, as it now
> crashes with "Unable to handle kernel paging request at virtual address
> ffffff8008f841ac", rather than the previous "Unable to handle kernel
> NULL pointer dereference at virtual address 000001ac".
>
> That does of course mean it still crashes in the same place, though :(
>
> Robin.
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy
> the information in any medium. Thank you.

And since I intentionally sent this to the lists, anyone reading that 
_is_ an intended recipient, so it's all good, I promise!

[sorry, SMTP server mixup on my end... *berates self*]

Robin.

>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
