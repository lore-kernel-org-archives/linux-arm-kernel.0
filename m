From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Jun 2018 13:17:36 +0300
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <DM6PR02MB43612FF66323449C7D2B4FDCC76C0@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
 <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
 <20180424035548.GA6014@localhost>
 <ee1dc551-7c11-6d10-651d-01bf6520f049@ti.com>
 <MWHPR02MB3293486390485A6FCCEA7DECC7910@MWHPR02MB3293.namprd02.prod.outlook.com>
 <99581088-7ef8-6fac-c934-91eadddfb04e@ti.com>
 <DM6PR02MB43612FF66323449C7D2B4FDCC76C0@DM6PR02MB4361.namprd02.prod.outlook.com>
Message-ID: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radhey,

On 2018-05-30 20:29, Radhey Shyam Pandey wrote:
>> In couple of days I can update the metadata patches I have atm and send
>> as RFC.
>>
>> Is there anything from your side I should take into account when doing that?
> I think a generic interface to attach/share metadata buffer b/w client and the
> dmaengine driver is good enough. Is metadata patchset (early version) 
> available in TI external repos? 

I don't have it in public repository, but now that the TRM is public I
can start preparing things for upstream.

I have attached the patch I ended up with, but I need to add the
documentation part.

Since the 'metadata' is part of the DMA descriptor itself I thought that
it might be better to reflect that -> the metadata_ops is part of the
dma_async_tx_descriptor struct.

DMA drivers can initialize it when it is supported by the channel or
setup. In my case it is optional, many peripherals did not use it at all.

I have two modes to deal with the metadata:
1. attach mode
Client drivers are giving a buffer and a size to the DMA driver and in
case of TX the data is copied to the descriptor's metadata part. In case
of RX when the transfer is completed the DMA driver will copy the data
from the DMA descriptor to the client provided buffer.
Here we need one memcpy for each descriptor.

2. pointer mode
If we have high throughput peripheral, the per descriptor memcpy can be
an obstacle for performance.

TX: The client dmaengine_desc_get_metadata_ptr() to get the pointer to
the metadata section of the descriptor, it will receive back the max
size and the currently used size (important for RX). This is done before
issue_pending().
The client can update the metadata directly and when it is done calls
the dmaengine_desc_set_metadata_len() to tell the DMA driver the size of
the metadata it has configured.

RX: in the DMA callback the client calls
dmaengine_desc_get_metadata_ptr() to get the pointer and the size of the
metadata we have received and can process the information w/o memcpy.

I think it might be better to rename these from metadata to client_data
or something. It is part of the DMA descriptor, passed along with the
DMA descriptor, but it is owned by the client driver.

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-dmaengine-Add-metadat_ops-for-dma_async_tx_descripto.patch
Type: text/x-patch
Size: 3092 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180601/d3c18cb2/attachment-0001.bin>
