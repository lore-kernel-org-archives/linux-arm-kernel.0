From: tfiga@google.com (Tomasz Figa)
Date: Wed, 15 Apr 2015 16:41:17 +0900
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1429081567.16400.16.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
 <1426677749.22581.38.camel@mhfsdcap03>
 <CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A@mail.gmail.com>
 <1428993067.13552.14.camel@mhfsdcap03>
 <CAAFQd5Db+DacQYa1pdr=w5JpU76AYa-Xhd20wHBF=F6m=Efokw@mail.gmail.com>
 <1429081567.16400.16.camel@mhfsdcap03>
Message-ID: <CAAFQd5A2FgsbusEbxVVqSeC7hY=Ewe-YbJ7bbvk-SjpSC==xDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 4:06 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> On Wed, 2015-04-15 at 11:20 +0900, Tomasz Figa wrote:
>> On Tue, Apr 14, 2015 at 3:31 PM, Yong Wu <yong.wu@mediatek.com> wrote:
>> >> >>
>> >> >> > +
>> >> >> > +       piommu->protect_va = devm_kmalloc(piommu->dev, MTK_PROTECT_PA_ALIGN*2,
>> >> >>
>> >> >> style: Operators like * should have space on both sides.
>> >> >>
>> >> >> > +                                         GFP_KERNEL);
>> >> >>
>> >> >> Shouldn't dma_alloc_coherent() be used for this?
>> >> >      We don't care the data in it. I think they are the same. Could you
>> >> > help tell me why dma_alloc_coherent may be better.
>> >>
>> >> Can you guarantee that at the time you allocate the memory using
>> >> devm_kmalloc() the memory is not dirty (i.e. some write back data are
>> >> stored in CPU cache) and is not going to be written back in some time,
>> >> overwriting data put there by IOMMU hardware?
>> >>
>> > As I noted in the function "mtk_iommu_hw_init":
>> >
>> >        /* protect memory,HW will write here while translation fault */
>> >        protectpa = __virt_to_phys(piommu->protect_va);
>> >
>> >      We don?t care the content of this buffer, It is ok even though its
>> > data is dirty.
>> >     It seem to be a the protect memory. While a translation fault
>> > happened, The iommu HW will overwrite here instead of writing to the
>> > fault physical address which may be 0 or some random address.
>> >
>>
>> Do you mean that it's just a dummy page for hardware behind the IOMMU
>> to access when the mapping is not available? How would that work with
>> potential on demand paging when the hardware needs to be blocked until
>> the mapping is created?
>>
>> Best regards,
>> Tomasz
>  1. YES
>  2. Sorry. Our iommu HW can not support this right now. The HW can not
> be blocked until the mapping is created.

OK, that explains it. Well, then I guess this is necessary and
contents of that memory don't matter that much. (Although, this might
be a minor security issue, because the faulting hardware would get
access to some data previously stored by kernel code. Not sure how
much of a threat would that be, though.)

>     If the page is not ready, we can not get the physical address, then
> How to fill the pagetable for that memory. I think the dma&iommu may
> guaranty it?

If your hardware can't block until the mapping is created then what
you do currently seems to be the only option. (+/- the missing cache
maintenance at initialization)

Best regards,
Tomasz
