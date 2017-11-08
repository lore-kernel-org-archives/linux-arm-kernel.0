From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 8 Nov 2017 10:50:56 +0000
Subject: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
In-Reply-To: <79f3610e-e522-29ad-8a93-be7e05df2973@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
 <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
 <79f3610e-e522-29ad-8a93-be7e05df2973@huawei.com>
Message-ID: <8734355c-d0c8-a02a-ab47-46803700c467@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liubo,

On 08/11/17 01:21, Bob Liu wrote:
> Hi Jean,
> 
> On 2017/10/12 20:55, Jean-Philippe Brucker wrote:
>> On 12/10/17 13:05, Yisheng Xie wrote:
>> [...]
>>>>>> * An iommu_process can be bound to multiple domains, and a domain can have
>>>>>>   multiple iommu_process.
>>>>> when bind a task to device, can we create a single domain for it? I am thinking
>>>>> about process management without shared PT(for some device only support PASID
>>>>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
>>>>> Do you have any idea about this?
>>>>
>>>> A device always has to be in a domain, as far as I know. Not supporting
>>>> PRI forces you to pin down all user mappings (or just the ones you use for
>>>> DMA) but you should sill be able to share PT. Now if you don't support
>>>> shared PT either, but only PASID, then you'll have to use io-pgtable and a
>>>> new map/unmap API on an iommu_process. I don't understand your concern
>>>> though, how would the link between process and domains prevent this use-case?
>>>>
>>> So you mean that if an iommu_process bind to multiple devices it should create
>>> multiple io-pgtables? or just share the same io-pgtable?
>>
>> I don't know to be honest, I haven't thought much about the io-pgtable
>> case, I'm all about sharing the mm :)
>>
> 
> Sorry to get back to this thread, but traditional DMA_MAP use case may also want to
> enable Substreamid/PASID.
> As a general framework, you may also consider SubStreamid/Pasid support for dma map/io-pgtable.
> 
> We're considering make io-pgtables per SubStreamid/Pasid, but haven't decide put all 
> io-pgtables into a single domain or iommu_process.

Yes they should be in a single domain, see also my other reply here:
http://www.spinics.net/lists/arm-kernel/msg613586.html

I've only been thinking about the IOMMU API for the moment, but I guess
the VFIO API would use this extension? I suppose it would be a new PASID
field to DMA_MAP along with a flag. The PASID would probably be allocated
with BIND + some special flag.

Thanks,
Jean
