From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 6 Feb 2017 22:26:26 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
 <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
 <HE1PR0401MB2636FF4D977DDA6888616A26864B0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
Message-ID: <HE1PR0401MB2636B14B4F1637A5A7D5432386400@HE1PR0401MB2636.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2017 8:03 AM, Robin Murphy wrote:
>
>> My understanding is that the dma_declare_coherent_memory() API sets up a
>> region of memory that will be managed by dma_alloc_coherent() and
>> friends.  This is useful if the driver needs to manage a region of on
>> device memory but that isn't what this specific region is used for.
> It's a bit more general than that - dma_alloc_coherent() can essentially
> be considered "give me some memory for this device to use". We already
> have use-cases where such buffers are only ever accessed by the device
> (e.g. some display controllers, and future NVMe devices), hence
> DMA_ATTR_NO_KERNEL_MAPPING on ARM to save the vmalloc space.
>
> A DMA allocation also inherently guarantees appropriate alignment,
> regardless of whether you're using a per-device reservation or just
> regular CMA, and will also zero the underlying memory (and for a
> non-coherent device perform whatever cache maintenance is necessary, if
> the clearing isn't already done via a non-cacheable mapping).
>
> All you need to do in the driver is allocate your buffer and hand the
> resulting address off to the device at probe (after optionally checking
> for a reservation in DT and declaring it), then free it at remove, which
> also ends up far more self-documenting (IMO) than a bunch of open-coded
> remapping and #ifdef'ed architecture-private cache shenanigans.
I found some time to work on this but the dma_declare_coherent_memory()
API does not allow me to pass normal memory for the device to use.

Depending on which flag is used I get one of two behaviors. If I pass
DMA_MEMORY_MAP the path attempts to do a memremap() which fails with the
message "memremap attempted on ram". If I use DMA_MEMORY_IO then it
attempts to use ioremap() on the memory which fails for a similar reason
(Not allowed to map ram).  Using dma_alloc_coherent() fails in our basic
use case because it is unable to obtain 8 megabytes of RAM.

Why don't I simplify this and use dma_sync_single_for_device() to flush
the cache? This seems to me to be portable and the simplest solution to
this problem. The device reports non-coherent when queried using 
is_device_dma_coherent() and my very quick walk through the code seems
to indicate that the call will do the right thing.

Roy

Roy
