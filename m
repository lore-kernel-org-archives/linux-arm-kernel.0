From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 11 Apr 2016 16:22:28 +0900
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <5707FC9F.50905@arm.com>
References: <57064992.1060509@arm.com> <570737F5.30105@nvidia.com>
 <5707FC9F.50905@arm.com>
Message-ID: <570B50B4.4020304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 04/09/2016 03:46 AM, Robin Murphy wrote:
> Hi Alex,
>
> On 08/04/16 05:47, Alexandre Courbot wrote:
>> Hi Robin,
>>
>> On 04/07/2016 08:50 PM, Robin Murphy wrote:
>>> Hello,
>>>
>>> With 4.6-rc2 (and -rc1) I'm seeing Nouveau blowing up at boot, from the
>>> look of it by dereferencing some offset from NULL inside
>>> nouveau_fbcon_imageblit(). My setup is an old XFX 7600GT card plugged
>>> into an ARM Juno r1 board, which works fine with 4.5 and earlier.
>>>
>>> Attached are a couple of logs from booting arm64 defconfig plus DRM and
>>> Nouveau enabled - the second also has framebuffer console rotation
>>> turned on, which interestingly seems to move the point of failure, and
>>> the display does eventually come up to show the tail end of the panic in
>>> that case.
>>>
>>> I might be able to find time for a full bisection next week if isn't
>>> something sufficiently obvious to anyone who knows this driver.
>>
>> Looking at the log it is not clear to me what could be causing this. I
>> can boot 4.6-rc2 with a GM206 card without any issue. A bisect would
>> indeed be useful here.
>
> OK, turns out the lure of writing something to remotely drive a Juno and
> parse kernel bootlogs through an automatic bisection was too great to
> resist on a Friday afternoon :D
>
> Bisection came down to 1733a2ad3674("drm/nouveau/device/pci: set as
> non-CPU-coherent on ARM64"), and sure enough reverting that removes the
> crash.

Thanks for taking the time to bisect this. And apologies as it seems my 
commit is the reason for your troubles.

The CPU coherency flag is used for two things: explicitly sync buffers 
pages when required, and allocating buffers that are not explicitly 
synced (like fences or pushbuffers) using the DMA API. For this latter 
use, it also accesses the buffer's content using the mapping provided by 
dma_alloc_coherent() instead of creating a new one. All nouveau_bos are 
supposed to be written using nouveau_bo_rd32(), and this function 
handles the case of an DMA-API allocated object by detecting that the 
result of ttm_kmap_obj_virtual() is NULL.

But as it turns out, OUT_RINGp() also calls ttm_kmap_obj_virtual() in 
order to perform a memcpy and uses its result directly - which means we 
are doing memcpy on a NULL pointer. We never caught this because we 
typically do not use Nouveau's fbcon with an ARM setup.

I don't really like this special access for coherent objects, and 
actually had a patch in my tree to attempt to remove it (attached). 
Although it is not the whole solution (see below), the issue should at 
least not be visible with it applied - could you confirm?

> I have to say, that commit looks pretty bogus anyway - since
> de335bb49269("PCI: Update DMA configuration from DT") in 4.1, PCI
> devices should correctly inherit the coherency property from their host
> controller's DT node and get the appropriate DMA ops assigned. From a
> brief look at the Nouveau code, I guess it could possibly be the
> assumptions the TTM stuff going awry in the presence of coherent DMA
> ops. Regardless of how the code goes wrong, though, it's trivially
> incorrect to have a blanket statement that PCI devices are non-coherent
> on arm64, so whatever the original issue was this isn't the right way to
> fix it.

You are absolutely right and this needs to be fixed. We still need to 
know about the bus coherency to avoid calling the page sync functions 
when they are not needed though. Is there a way for us to query the bus 
at runtime and know whether it is cpu-coherent or not?

... or maybe we could just unconditionally sync all buffers and let the 
DMA API abstract this away. My concern is that on coherent architectures 
we would still need to loop over all the pages for nothing, as I don't 
think the loop (see e.g. nouveau_bo_sync_for_cpu in nouveau_bo.c) can be 
optimized away by the compiler.

Thanks,
Alex.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-WIP-no-dma-api-for-coherent-gpuobjs.patch
Type: text/x-patch
Size: 3801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160411/46428d08/attachment.bin>
