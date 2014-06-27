From: robdclark@gmail.com (Rob Clark)
Date: Fri, 27 Jun 2014 08:08:22 -0400
Subject: [Nouveau] [PATCH v2 2/3] drm/ttm: introduce dma cache sync helpers
In-Reply-To: <CAAVeFuK5L9+nCP=KZTBSG9OifJrFKcfQdCYuBEQbZ2+s9FmFdQ@mail.gmail.com>
References: <1403603667-11302-1-git-send-email-acourbot@nvidia.com>
 <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
 <20140624100220.GK32514@n2100.arm.linux.org.uk>
 <53A953E6.2030503@nvidia.com> <53A95910.20104@nvidia.com>
 <CAAVeFu+rbCViC87kYCLfxGV18iYq=Pa0ABb+L=iNiYPLn+mR8Q@mail.gmail.com>
 <53A96EC5.3030701@canonical.com>
 <1403616338.4230.8.camel@weser.hi.pengutronix.de>
 <CACP_E+KECMyusuZd6hpzthL-RpfUOJpWh0EABf1DGAeaXc00aA@mail.gmail.com>
 <CAAVeFuLU04rk1DWMhVJV=ktVCpq4js38p1ipCr1jh1x72b=GZw@mail.gmail.com>
 <20140626161055.GX32514@n2100.arm.linux.org.uk>
 <CAAVeFuK5L9+nCP=KZTBSG9OifJrFKcfQdCYuBEQbZ2+s9FmFdQ@mail.gmail.com>
Message-ID: <CAF6AEGv+aBJSsHAPiz4b4CP7=hvKhXwzywVQyighxnj-Lo=QTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 7:17 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Jun 27, 2014 at 1:10 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Jun 26, 2014 at 11:53:20PM +0900, Alexandre Courbot wrote:
>>> We don't plan to rely on CMA for too long. IOMMU support is on the way
>>> and should make our life easier, although no matter the source of
>>> memory, we will still have the issue of the lowmem mappings.
>>
>> When it comes to DMA memory, talking about lowmem vs highmem is utterly
>> meaningless.
>>
>> The lowmem/highmem split is entirely a software concept and is completely
>> adjustable.  An extreme example is that you can boot any platform with
>> more than 32MB of memory with 32MB of lowmem and the remainder as
>> highmem.
>
> True, but isn't it also the case that all lowmem is already mapped in
> the kernel address space, and that re-mapping this memory with
> different cache settings (e.g. by creating a WC mapping for user-space
> to write into) is undefined on ARM and must be avoided? That is the
> issue I was referring to.
>

dma memory should be removed from the kernel linear map (if needed)..
assuming it is allocated w/ dma api's.

btw, something I've been wondering for a little while, but haven't had
time to investigate.  Not sure if this applies to you as well.  But
seems like I have IOMMU's which can be outer-coherent (snoop L2), but
I *think* they are not inner-coherent (L1).  No idea if current dma
memory code can grok this and only do inner-cache op's..

BR,
-R

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
