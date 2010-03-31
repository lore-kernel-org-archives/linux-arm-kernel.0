From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 31 Mar 2010 10:40:57 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <20100331010744.GK31126@trinity.fluff.org>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003251908w299806cbm1443728ea08cfb72@mail.gmail.com>
	<20100331010744.GK31126@trinity.fluff.org>
Message-ID: <t2r1b68c6791003301840n8b3f94b7xdbf8ddc1fe0165ff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 10:07 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Mar 26, 2010 at 11:08:06AM +0900, jassi brar wrote:
>> On Thu, Mar 25, 2010 at 12:17 PM, Joonyoung Shim
>> <jy0922.shim@samsung.com> wrote:
>> > +static struct pl330_desc *
>> > +pl330_alloc_descriptor(struct pl330_chan *pl330_ch, gfp_t flags)
>> > +{
>> > + ? ? ? struct device *dev = pl330_ch->pl330_dev->common.dev;
>> > + ? ? ? struct pl330_desc *desc;
>> > + ? ? ? dma_addr_t phys;
>> > +
>> > + ? ? ? desc = kzalloc(sizeof(*desc), flags);
>> > + ? ? ? if (!desc)
>> > + ? ? ? ? ? ? ? return NULL;
>> > +
>> > + ? ? ? desc->desc_pool_virt = dma_alloc_coherent(dev, PL330_POOL_SIZE, &phys,
>> > + ? ? ? ? ? ? ? ? ? ? ? flags);
>> These allocations are inefficient and don't need to be done so often.
>> My implementation allocates a pool of such buffers(size specified by
>> DMA API driver)
>> and manage them by simple pointer manipulation.
>> Though the xfer requests for DMA API has to be managed in the DMA API driver.
>
> There's a dma pool implementation too in the kernel.
I meant during 'probe' of the DMAC a chunk of dma consistent memory is allocated
for MicroCode for each channel.
We use the same chunk during xfers, since we can generate MC in a way that 256
bytes are enough to do xfer of 2.5MB at burst size of 1 byte and for
bulkier requests
the DMA API driver can either break the bigger request or allocate
bigger chunk for
the channels.
