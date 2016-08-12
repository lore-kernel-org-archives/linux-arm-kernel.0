From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 12 Aug 2016 11:28:22 -0600
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
In-Reply-To: <57ABB31E.1070802@osg.samsung.com>
References: <CGME20160810214111epcas1p4dd2a581353b550a1992fc7695e846da7@epcas1p4.samsung.com>
 <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
 <57ABB1ED.1080301@samsung.com> <57ABB31E.1070802@osg.samsung.com>
Message-ID: <57AE0736.6020705@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 05:05 PM, Shuah Khan wrote:
> On 08/10/2016 04:59 PM, Inki Dae wrote:
>> Hi Shuah,
>>
>> 2016? 08? 11? 02:30? Shuah Khan ?(?) ? ?:
>>> Fix exynos_drm_gem_create_ioctl() attempts to allocate non-contiguous GEM
>>> memory without IOMMU. In this case, there is no point in attempting to
>>
>> DRM gem can be used for Non-DRM drivers such as GPU, V4L2 based Multimedia device and other DMA devices.
>> Even though IOMMU support is disabled, other framework based DMA drivers can use IOMMU - i.e., GPU driver -
>> and they can use non-contiguous GEM buffer through UMM. (DMABUF) 
>>
>> So GEM allocation type is not dependent on IOMMU.
> 
> Hi Inki,
> 
> I am seeing the following failure without IOMMU and light dm fails
> to start:
> 
> [drm:exynos_drm_framebuffer_init] *ERROR* Non-continguous GEM memory is not supported.
> 
> The change I made fixed that problem and light dm starts without IOMMU.
> Is there a better way to fix this problem? Currently without IOMMU,
> light dm doesn't start.
> 
> This is on linux_next

Hi Inki,

I am looking into this further and I am finding inconsistent
commits with regards to GEM contiguous and non-contiguous
buffers.

Okay what you said is that:

exymod-drm should support non-continguous and contiguous GEM memory
type with or without IOMMU

However, the code currently isn't doing that. The following
commit allocates non-contiguous buffers when IOMMU is enabled
to handle contiguous allocation failures.

There are other commits that removed checks for non-contig type.
Let's look at the following cases to see what should be the driver
behavior in these cases:

IOMMU is disabled:

exynos_drm_gem_create_ioctl() gets called with NONCONTIG
- driver should try to allocate non-contig
- if it can't allocate non-contig, allocate contig
  ( this will allow avoid failure like the one I am seeing)

exynos_drm_gem_create_ioctl() gets called with CONTIG
- driver should try to allocate contig
- if it can't allocate contig, allocate non-contig

What is confusing is there are several code paths in the
GEN allocation and checking memory types are enforcing
non-contig with IOMMU. Check this routine:

exynos_drm_framebuffer_init() will reject non-contig
memory type when check_fb_gem_memory_type() rejects
non-contig GEM memory type without IOMMU.

So there is inconsistency in the non-contig vs. contig
GEM support in exynos-drm. I think this needs to be cleaned
up to get the desired behavior.

The following commit allocates non-contiguous buffers when IOMMU is
enabled to handle contiguous allocation failures.

There are other commits that removed checks for non-contig type.
Let's look at the following cases to see what should be the driver
behavior in these cases:

commit 122beea84bb90236b1ae545f08267af58591c21b
Author: Rahul Sharma <Rahul.Sharma@samsung.com>
Date:   Wed May 7 17:21:29 2014 +0530

    drm/exynos: allocate non-contigous buffers when iommu is enabled
    
    Allow to allocate non-contigous buffers when iommu is enabled.
    Currently, it tries to allocates contigous buffer which consistently
    fail for large buffers and then fall back to non contigous. Apart
    from being slow, this implementation is also very noisy and fills
    the screen with alloc fail logs.
    
    Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
    Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
    Signed-off-by: Inki Dae <inki.dae@samsung.com>


commit ea6d66c3a797376d21b23dc8261733ce35970014
Author: Inki Dae <inki.dae@samsung.com>
Date:   Fri Nov 2 16:10:39 2012 +0900

    drm/exynos: remove EXYNOS_BO_NONCONTIG type checking.
    
    With iommu support, non-continuous buffer also is supported so
    this patch removes these checking from exynos_drm_gem_get/put_dma_addr
    funciton.
    
    This patch is based on the below patch set, "drm/exynos: add
    iommu support for -next".
        http://www.spinics.net/lists/dri-devel/msg29041.html
    
    Signed-off-by: Inki Dae <inki.dae@samsung.com>
    Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

commit 2b35892e9da672df40ce890bffc4f9f6119c57e0
Author: Inki Dae <inki.dae@samsung.com>
Date:   Fri Mar 16 18:47:05 2012 +0900

    drm/exynos: update gem and buffer framework.
    
    with this patch, we can allocate physically continuous or non-continuous
    memory and also it creates scatterlist for iommu support so allocated
    memory region can be mapped to iommu page table using scatterlist.
    
    Signed-off-by: Inki Dae <inki.dae@samsung.com>
    Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

-- Shuah
