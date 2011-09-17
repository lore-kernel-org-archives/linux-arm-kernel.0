From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 17 Sep 2011 22:57:53 +0800
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CABb+yY13Xum=nU2eD+DJ7Uv_8ppE+UKFUA6KD_4CP+eDG5rAaQ@mail.gmail.com>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
	<CABb+yY13Xum=nU2eD+DJ7Uv_8ppE+UKFUA6KD_4CP+eDG5rAaQ@mail.gmail.com>
Message-ID: <CAGsJ_4za8HZ6hoyRyU=NR8TXhN+iFOQvfOeA1F_GTH6h6Zs+=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/17 Jassi Brar <jassisinghbrar@gmail.com>:
> On Fri, Sep 16, 2011 at 3:26 PM, Barry Song <Baohua.Song@csr.com> wrote:
>
>> +static int sirfsoc_dma_slave_config(struct sirfsoc_dma_chan *schan,
>> + ? ? ? struct dma_slave_config *config)
>> +{
>> + ? ? ? u32 addr, direction;
>> + ? ? ? unsigned long flags;
>> +
>> + ? ? ? switch (config->direction) {
>> + ? ? ? case DMA_FROM_DEVICE:
>> + ? ? ? ? ? ? ? direction = 0;
>> + ? ? ? ? ? ? ? addr = config->dst_addr;
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? case DMA_TO_DEVICE:
>> + ? ? ? ? ? ? ? direction = 1;
>> + ? ? ? ? ? ? ? addr = config->src_addr;
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? default:
>> + ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? }
>> +
>> + ? ? ? if ((config->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>> + ? ? ? ? ? ? ? (config->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES))
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? spin_lock_irqsave(&schan->lock, flags);
>> + ? ? ? schan->addr = addr;
>> + ? ? ? schan->direction = direction;
>> + ? ? ? schan->mode = (config->src_maxburst == 4 ? 1 : 0);
>> + ? ? ? spin_unlock_irqrestore(&schan->lock, flags);
>> +
>> + ? ? ? return 0;
>> +}
> You don't need to pass as much info via dma_slave_config as you do here.
>
> dmaxfer_template.src_inc ?&& !dmaxfer_template.dst_inc ?=> DMA_TO_DEVICE
> !dmaxfer_template.src_inc ?&& dmaxfer_template.dst_inc ?=> DMA_FROM_DEVICE

it seems direct DMA_TO_DEVICE/DMA_FROM_DEVICE is more feasible and
explict to me. "dmaxfer_template.src_inc  &&
!dmaxfer_template.dst_inc" is probably DMA_TO_DEVICE, but it is not
always true for all scenerios to all kinds of devices. anyway, for my
case, they are always true. so i can use them.

>
> Pass addresses using dmaxfer_template.src_start and dmaxfer_template.dst_start
> instead of dma_slave_config.dst_addr and dma_slave_config.src_addr
>
> So, currently you need dma_slave_config only to pass src_addr_width,
> dst_addr_width and src_maxburst to the dmac driver.

i agree that can decrease the calling of config. let the genxfer
decide the address of every transfer should be more flexible.

>
>
>> +
>> +static struct dma_async_tx_descriptor *sirfsoc_dma_prep_slave_sg(
>> + ? ? ? struct dma_chan *chan, struct scatterlist *sgl,
>> + ? ? ? unsigned int sg_len, enum dma_data_direction direction,
>> + ? ? ? unsigned long flags)
>> +{
>> + ? ? ? return NULL;
>> +}
>> +
> In v3 I'll remove the BUG_ON check that requires every SLAVE channel
> provides device_prep_slave_sg, so you should be able to simply discard
> this stub.

ok, that is going to make the api better.

-barry
