From: tfiga@google.com (Tomasz Figa)
Date: Fri, 27 Mar 2015 18:41:09 +0900
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1426677749.22581.38.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
 <1426677749.22581.38.camel@mhfsdcap03>
Message-ID: <CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong Wu,

Sorry for long delay, I had to figure out some time to look at this again.

On Wed, Mar 18, 2015 at 8:22 PM, Yong Wu <yong.wu@mediatek.com> wrote:
>>
>> > +               imudev = piommu->dev;
>> > +
>> > +       spin_lock_irqsave(&priv->portlock, flags);
>>
>> What is protected by this spinlock?
>         We will write a register of the local arbiter while config port. If
> some modules are in the same local arbiter, it may be overwrite. so I
> add it here.
>>

OK. Maybe it could be called larb_lock then? It would be good to have
structures or code that should be running under this spinlock
annotated with proper comments. And purpose of the lock documented in
a comment as well (probably in a kerneldoc-style documentation of
priv).

>> > +static void mtk_iommu_detach_device(struct iommu_domain *domain,
>> > +                                   struct device *dev)
>> > +{
>>
>> No hardware (de)configuration or clean-up necessary?
> I will add it. Actually we design like this:If a device have attached to
> iommu domain, it won't detach from it.

Isn't proper clean-up required for module removal? Some drivers might
be required to be loadable modules, which should be unloadable.

>>
>> > +
>> > +       piommu->protect_va = devm_kmalloc(piommu->dev, MTK_PROTECT_PA_ALIGN*2,
>>
>> style: Operators like * should have space on both sides.
>>
>> > +                                         GFP_KERNEL);
>>
>> Shouldn't dma_alloc_coherent() be used for this?
>      We don't care the data in it. I think they are the same. Could you
> help tell me why dma_alloc_coherent may be better.

Can you guarantee that at the time you allocate the memory using
devm_kmalloc() the memory is not dirty (i.e. some write back data are
stored in CPU cache) and is not going to be written back in some time,
overwriting data put there by IOMMU hardware?

>> > +
>> > +       iommu_set_fault_handler(domain, mtk_iommu_fault_handler, piommu);
>>
>> I don't see any other drivers doing this. Isn't this for upper layers,
>> so that they can set their own generic fault handlers?
>      I think that this function is related with the iommu domain, we
> have only one multimedia iommu domain. so I add it after the iommu
> domain are created.

No, this function is for drivers of IOMMU clients (i.e. master IP
blocks) which want to subscribe to page fault to do things like paging
on demand and so on. It shouldn't be called by IOMMU driver. Please
see other IOMMU drivers, for example rockchip-iommmu.c.

Best regards,
Tomasz
