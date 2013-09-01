From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 1 Sep 2013 21:02:01 +0800
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <20130826085607.GN2748@intel.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
Message-ID: <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/26 Vinod Koul <vinod.koul@intel.com>:
> On Sun, Aug 25, 2013 at 08:57:13PM +0800, Barry Song wrote:
>> the dma engine of sirfsoc supports interleaved mode, but if we set
>> xlen=width instead xlen<width, it will work as non-interleaved. as
>> most clients of sirf dma driver still don't need interleaved mode,
>> so here we still need to implement prep_slave_sg entry so that users
>> like uart, spi can use these APIs instead of interleaved API.
> Well in that case why dont you just create a wrapper on top of interleaved API
> to make this work without driver changes

Vinod, do you mean using interleaved API to provide sg/single API if
specific drivers implement interleaved_dma but not implement sg_dma?

the problem is that is difficult to set right legal sgl[i].size,
sgl[i].icg and numf for all dmaengines as that depends on specific dma
hardware limitation.

>
>> the dma engine of sirfsoc doesn't support hardware s/g, so here we
>> are using the list of desc nodes to do SW s/g. when dma operations
>> finish, driver will re-start the next desc automatically.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/dma/sirf-dma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
>> index 6aec3ad..c226c79 100644
>> --- a/drivers/dma/sirf-dma.c
>> +++ b/drivers/dma/sirf-dma.c
>> @@ -577,6 +577,62 @@ err_dir:
>>  }
>>
>>  static struct dma_async_tx_descriptor *
>> +sirfsoc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +     unsigned int sg_len, enum dma_transfer_direction direction,
>> +     unsigned long flags, void *context)
>> +{
>> +     struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
>> +     struct sirfsoc_dma_desc *first_sdesc;
>> +     struct sirfsoc_dma_desc *sdesc;
>> +     struct list_head *l;
>> +     unsigned long iflags;
>> +     struct scatterlist *sg;
>> +     int desc_cnt = 0;
>> +     int i;
>> +     int ret;
>> +
>> +     /*
>> +      * the hardware doesn't support sg, here we use software list
>> +      * to simulate sg, so make sure we have enough desc nodes
>> +      */
>> +     spin_lock_irqsave(&schan->lock, iflags);
>> +     list_for_each(l, &schan->free)
>> +             desc_cnt++;
> why dont you allocate descriptors here. That will remove this limitation..

i understand. here sirf user scenerios will never be over the
limitation of SIRFSOC_DMA_DESCRIPTORS = 16. so i don't want to make it
too complex.

>
> ~Vinod

-barry
