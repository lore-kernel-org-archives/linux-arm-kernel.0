From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 6 Mar 2017 12:46:16 +0000
Subject: [PATCH 1/4] net: thunderx: Fix IOMMU translation faults
In-Reply-To: <CA+sq2CcFxk=LuqYhR-sFaVVSu3rMaZUcytx-3tC9kEiRFNwREg@mail.gmail.com>
References: <1488538070-12549-1-git-send-email-sunil.kovvuri@gmail.com>
 <1488538070-12549-2-git-send-email-sunil.kovvuri@gmail.com>
 <20170303.095635.355325147613813698.davem@davemloft.net>
 <CA+sq2CcFxk=LuqYhR-sFaVVSu3rMaZUcytx-3tC9kEiRFNwREg@mail.gmail.com>
Message-ID: <cad7da5d-fce7-cef2-d0db-9585c31f0575@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/17 05:54, Sunil Kovvuri wrote:
> On Fri, Mar 3, 2017 at 11:26 PM, David Miller <davem@davemloft.net> wrote:
>> From: sunil.kovvuri at gmail.com
>> Date: Fri,  3 Mar 2017 16:17:47 +0530
>>
>>> @@ -1643,6 +1650,9 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>       if (!pass1_silicon(nic->pdev))
>>>               nic->hw_tso = true;
>>>
>>> +     /* Check if we are attached to IOMMU */
>>> +     nic->iommu_domain = iommu_get_domain_for_dev(dev);
>>
>> This function is not universally available.
> 
> Even if CONFIG_IOMMU_API is not enabled, it will return NULL and will be okay.
> http://lxr.free-electrons.com/source/include/linux/iommu.h#L400
> 
>>
>> This looks very hackish to me anyways, how all of this stuff is supposed
>> to work is that you simply use the DMA interfaces unconditionally and
>> whatever is behind the operations takes care of everything.
>>
>> Doing it conditionally in the driver with all of this special IOMMU
>> domain et al. knowledge makes no sense to me at all.
>>
>> I don't see other drivers doing stuff like this at all, so if you're
>> going to handle this in a unique way like this you better write
>> several paragraphs in your commit message explaining why this weird
>> crap is necessary.
> 
> I already tried to explain in the commit message that HW anyway takes care
> of data coherency, so calling DMA interfaces when there is no IOMMU will
> only result in performance drop.
> 
> We are seeing a 0.75Mpps drop with IP forwarding rate due to that.
> Hence I have restricted calling DMA interfaces to only when IOMMU is enabled.

What's 0.07Mpps as a percentage of baseline? On a correctly configured
coherent arm64 system, in the absence of an IOMMU, dma_map_*() is
essentially just virt_to_phys() behind a function call or two, so I'd be
interested to know where any non-trivial overhead might be coming from.

Robin.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
