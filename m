From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 6 Jun 2017 17:16:28 +0100
Subject: [PATCH] arm64: dts: juno: Enable some SMMUs
In-Reply-To: <398bc8d4-f307-740b-435c-7822bec4f8e1@arm.com>
References: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
 <5e24adfa-3342-f331-1ed3-ed32ebf164cb@arm.com>
 <398bc8d4-f307-740b-435c-7822bec4f8e1@arm.com>
Message-ID: <2ab6930b-6afe-2cc5-1b73-b3b6bf341466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/17 16:59, Robin Murphy wrote:
> On 06/06/17 16:45, Jean-Philippe Brucker wrote:
>> Hello,
>>
>> On 18/05/17 13:23, Robin Murphy wrote:
>>> The IOMMU-backed DMA API support has now been in place for a while and
>>> proven stable, so there's no real need to keep most of Juno's SMMUs
>>> disabled. The USB, HDLCDs, and CoreSight ETR all just need to map RAM
>>> buffers for DMA - enabling their SMMUs obviates CPU bounce buffering for
>>> USB's streaming DMA to the upper memory bank, and lets the other two
>>> allocate their relatively large coherent buffers without pressuring CMA.
>>>
>>> Some more software work is still needed for the DMA-330 and PCIe before
>>> those can accommodate SMMU translation correctly in all cases, so we
>>> leave those alone for now.
>>
>> Out of curiosity, what is missing for DMA-330? I can use dmatest over SMMU
>> on my juno-r1 by enabling the node, but I don't have any complex workload
>> yet. Guest pass-through is really unreliable and I'm trying to figure out why.
> 
> Yes, dmatest has always been fine* since both ends get mapped for DMA
> appropriately by the client. The missing bit is, or should I say was,
> 4d6d74e22096 currently in linux-next.
> 
> Robin.
> 
> * For certain values of fine, anyway. There are a number of catastrophic
> races in the driver that make it generally a bad idea to use more than 1
> thread per channel.

Ah I see, thanks. The issue I was seeing was mismatched dma-coherency,
which I fixed. But my guest does sometimes hang when running 1024
threads/chan in dmatest, so that might be it.

Thanks,
Jean
