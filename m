From: subashrp@gmail.com (Subash Patel)
Date: Wed, 22 Jun 2011 10:23:13 +0530
Subject: [Linaro-mm-sig] [PATCH/RFC 0/8] ARM: DMA-mapping framework
	redesign
In-Reply-To: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4E017539.30505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 06/20/2011 01:20 PM, Marek Szyprowski wrote:
> Hello,
>
> This patch series is a continuation of my works on implementing generic
> IOMMU support in DMA mapping framework for ARM architecture. Now I
> focused on the DMA mapping framework itself. It turned out that adding
> support for common dma_map_ops structure was not that hard as I initally
> thought. After some modification most of the code fits really well to
> the generic dma_map_ops methods.
>
> The only change required to dma_map_ops is a new alloc function. During
> the discussion on Linaro Memory Management meeting in Budapest we got
> the idea that we can have only one alloc/free/mmap function with
> additional attributes argument. This way all different kinds of
> architecture specific buffer mappings can be hidden behind the
> attributes without the need of creating several versions of dma_alloc_
> function. I also noticed that the dma_alloc_noncoherent() function can
> be also implemented this way with DMA_ATTRIB_NON_COHERENT attribute.
> Systems that just defines dma_alloc_noncoherent as dma_alloc_coherent
> will just ignore such attribute.
>
> Another good use case for alloc methods with attributes is the
> possibility to allocate buffer without a valid kernel mapping. There are
> a number of drivers (mainly V4L2 and ALSA) that only exports the DMA
> buffers to user space. Such drivers don't touch the buffer data at all.
> For such buffers we can avoid the creation of a mapping in kernel
> virtual address space, saving precious vmalloc area. Such buffers might
> be allocated once a new attribute DMA_ATTRIB_NO_KERNEL_MAPPING.

Are you trying to say here, that the buffer would be allocated in the 
user space, and we just use it to map it to the device in DMA+IOMMU 
framework?

>
> All the changes introduced in this patch series are intended to prepare
> a good ground for upcoming generic IOMMU integration to DMA mapping
> framework on ARM architecture.
>
> For more information about proof-of-concept IOMMU implementation in DMA
> mapping framework, please refer to my previous set of patches:
> http://www.spinics.net/lists/linux-mm/msg19856.html
>
> I've tried to split the redesign into a set of single-step changes for
> easier review and understanding. If there is anything that needs further
> clarification, please don't hesitate to ask.
>
> The patches are prepared on top of Linux Kernel v3.0-rc3.
>
> The proposed changes have been tested on Samsung Exynos4 platform. I've
> also tested dmabounce code (by manually registering support for DMA
> bounce for some of the devices available on my board), although my
> hardware have no such strict requirements. Would be great if one could
> test my patches on different ARM architectures to check if I didn't
> break anything.
>
> Best regards

Regards,
Subash
SISO-SLG
