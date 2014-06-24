From: maarten.lankhorst@canonical.com (Maarten Lankhorst)
Date: Tue, 24 Jun 2014 14:27:49 +0200
Subject: [Nouveau] [PATCH v2 2/3] drm/ttm: introduce dma cache sync helpers
In-Reply-To: <CAAVeFu+rbCViC87kYCLfxGV18iYq=Pa0ABb+L=iNiYPLn+mR8Q@mail.gmail.com>
References: <1403603667-11302-1-git-send-email-acourbot@nvidia.com>
 <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
 <20140624100220.GK32514@n2100.arm.linux.org.uk> <53A953E6.2030503@nvidia.com>
 <53A95910.20104@nvidia.com>
 <CAAVeFu+rbCViC87kYCLfxGV18iYq=Pa0ABb+L=iNiYPLn+mR8Q@mail.gmail.com>
Message-ID: <53A96EC5.3030701@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

op 24-06-14 14:23, Alexandre Courbot schreef:
> On Tue, Jun 24, 2014 at 7:55 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> On 06/24/2014 07:33 PM, Alexandre Courbot wrote:
>>> On 06/24/2014 07:02 PM, Russell King - ARM Linux wrote:
>>>> On Tue, Jun 24, 2014 at 06:54:26PM +0900, Alexandre Courbot wrote:
>>>>> From: Lucas Stach <dev@lynxeye.de>
>>>>>
>>>>> On architectures for which access to GPU memory is non-coherent,
>>>>> caches need to be flushed and invalidated explicitly at the
>>>>> appropriate places. Introduce two small helpers to make things
>>>>> easy for TTM-based drivers.
>>>>
>>>> Have you run this with DMA API debugging enabled?  I suspect you haven't,
>>>> and I recommend that you do.
>>>
>>> # cat /sys/kernel/debug/dma-api/error_count
>>> 162621
>>>
>>> (??????? ???)
>>
>> *puts table back on its feet*
>>
>> So, yeah - TTM memory is not allocated using the DMA API, hence we cannot
>> use the DMA API to sync it. Thanks Russell for pointing it out.
>>
>> The only alternative I see here is to flush the CPU caches when syncing for
>> the device, and invalidate them for the other direction. Of course if the
>> device has caches on its side as well the opposite operation must also be
>> done for it. Guess the only way is to handle it all by ourselves here. :/
> ... and it really sucks. Basically if we cannot use the DMA API here
> we will lose the convenience of having a portable API that does just
> the right thing for the underlying platform. Without it we would have
> to duplicate arm_iommu_sync_single_for_cpu/device() and we would only
> have support for ARM.
>
> The usage of the DMA API that we are doing might be illegal, but in
> essence it does exactly what we need - at least for ARM. What are the
> alternatives?
Convert TTM to use the dma api? :-)

~Maarten
