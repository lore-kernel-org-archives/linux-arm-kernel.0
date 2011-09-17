From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 17 Sep 2011 23:33:31 +0800
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <20110917150246.GH16381@n2100.arm.linux.org.uk>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
	<20110917150246.GH16381@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4ySwfuaa1tbMcQkYHQQw61+-ajXwhxr_5xOxxKmn+aDog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Sep 16, 2011 at 02:56:00AM -0700, Barry Song wrote:
>> +static int sirfsoc_dma_slave_config(struct sirfsoc_dma_chan *schan,
>> + ? ? struct dma_slave_config *config)
>> +{
>> + ? ? u32 addr, direction;
>> + ? ? unsigned long flags;
>> +
>> + ? ? switch (config->direction) {
>
> config->direction is deprecated, please don't use it.

ok.

>
>> + ? ? case DMA_FROM_DEVICE:
>> + ? ? ? ? ? ? direction = 0;
>> + ? ? ? ? ? ? addr = config->dst_addr;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case DMA_TO_DEVICE:
>> + ? ? ? ? ? ? direction = 1;
>> + ? ? ? ? ? ? addr = config->src_addr;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? default:
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> +
>> + ? ? if ((config->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>> + ? ? ? ? ? ? (config->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? spin_lock_irqsave(&schan->lock, flags);
>> + ? ? schan->addr = addr;
>> + ? ? schan->direction = direction;
>> + ? ? schan->mode = (config->src_maxburst == 4 ? 1 : 0);
>
> Please store the source address, destination address, and mode separately
> for each direction. ?You should then select from that at prepare time.

the dmac has fixed route. every channel has fixed function. one
channel is for one device and one direction. for example, spi0 can
have two fixed channel: spi0-tx, spi0-rx.
then for every schan, device address is always fixed and we don't care
it at all. we only need to write the memory address to dmac address
register.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-barry
