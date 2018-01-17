From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 16:38:17 +0900
Subject: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
In-Reply-To: <5A5EFAB2.7040001@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-13-jeffy.chen@rock-chips.com>
 <CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com>
 <5A5EFAB2.7040001@rock-chips.com>
Message-ID: <CAAFQd5ATRh5hdJhVxDoXjFz72cBmv-yNaW7v-eUxkVRYA3=uJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:26 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 01/17/2018 02:20 PM, Tomasz Figa wrote:
>>
>> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com>
>> [snip]
>>>
>>> +static int rk_iommu_startup(struct rk_iommu *iommu)
>>>   {
>>> -       struct rk_iommu *iommu;
>>> +       struct iommu_domain *domain = iommu->domain;
>>>          struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>>> -       unsigned long flags;
>>>          int ret, i;
>>>
>>> -       /*
>>> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
>>> -        * Such a device does not belong to an iommu group.
>>> -        */
>>> -       iommu = rk_iommu_from_dev(dev);
>>> -       if (!iommu)
>>> -               return 0;
>>> -
>>> -       if (iommu->domain)
>>> -               rk_iommu_detach_device(iommu->domain, dev);
>>> -
>>>          ret = rk_iommu_enable_clocks(iommu);
>>>          if (ret)
>>>                  return ret;
>>>
>>
>> Don't we need to check here (and in _shutdown() too) if we have a
>> domain attached?
>
> hmmm, right, the startup might been called by resume, so should check
> iommu->domain here.
>
> but the shutdown would be called at the end of detach or suspend, it could
> be not attached or attached.

If startup might be called by resume, without domain attached, what
prevents shutdown from being called by suspend after that resume,
still without domain attached? Is it guaranteed that if resume is
called, someone will attach a domain before suspend is called?

Best regards,
Tomasz
