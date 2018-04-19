From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 19 Apr 2018 14:40:26 +0300
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
Message-ID: <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2018-04-18 16:06, Lars-Peter Clausen wrote:
>> Hrm, true, but it is hardly the metadata use case. It is more like
>> different DMA transfer type.
> 
> When I look at this with my astronaut architect view from high high up above
> I do not see a difference between metadata and multi-planar data.

I tend to disagree.

> Both split the data that is sent to the peripheral into multiple
> sub-streams, each carrying part of the data. I'm sure there are peripherals
> that interleave data and metadata on the same data stream. Similar to how we
> have left and right channel interleaved in a audio stream.

Slimbus, S/PDIF?

> What about metadata that is not contiguous and split into multiple segments.
> How do you handle passing a sgl to the metadata interface? And then it
> suddenly looks quite similar to the normal DMA descriptor interface.

Well, the metadata is for the descriptor. The descriptor describe the
data transfer _and_ can convey additional information. Nothing is
interleaved, the data and the descriptor are different things. It is
more like TCP headers detached from the data (but pointing to it).

> But maybe that's just one abstraction level to high.

I understand your point, but at the end the metadata needs to end up in
the descriptor which is describing the data that is going to be moved.

The descriptor is not sent as a separate DMA trasnfer, it is part of the
DMA transfer, it is handled internally by the DMA.

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
