From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 9 Nov 2018 16:37:54 +0000
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <20181109074955.GA27489@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
Message-ID: <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 07:49, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>
>> Any suggestions for how to further debug what might be going wrong
>> would be appreciated!
> 
> Very odd.  In the end map_sg and map_page are defined to do the same
> things to start with.  The only real issue we had in this area was:
> 
> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
> 
> so with current mainline + that you still see a problem, and if you
> rever the commit we are replying to it still goes away?

OK, after quite a bit of trying I have managed to provoke a 
similar-looking problem with straight 4.20-rc1 on my Juno board - so far 
my "reproducer" is to decompress a ~10GB .tar.xz off an external USB 
hard disk, wherein after somewhere between 5 minutes and half an hour or 
so it tends to falls over with xz choking on corrupt data and/or a USB 
error.

 From the presentation, this really smells like there's some corner in 
which we're either missing cache maintenance or doing it to the wrong 
address - I've not seen any issues with Juno's main PCIe-attached I/O, 
but the EHCI here is non-coherent (and 32-bit, so the bus_dma_mask thing 
doesn't matter) as are the HiKey UFS and SD controller.

I'll keep digging...

Robin.
