From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 16 Sep 2011 17:06:34 +0800
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
Message-ID: <CAGsJ_4yJyF+zba0J+36dUkfbrXMKd3PKSGtJj1iOsOzDJEk_1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> +/* Interrupt handler */
>>> +static irqreturn_t sirfsoc_dma_irq(int irq, void *data)
>>> +{
>>> + ? ? struct sirfsoc_dma *sdma = data;
>>> + ? ? struct sirfsoc_dma_chan *schan;
>>> + ? ? u32 is;
>>> + ? ? int ch;
>>> +
>>> + ? ? is = readl_relaxed(sdma->regs + SIRFSOC_DMA_CH_INT);
>>> + ? ? while ((ch = fls(is) - 1) >= 0) {
>>> + ? ? ? ? ? ? is &= ~(1 << ch);
>>> + ? ? ? ? ? ? writel_relaxed(1 << ch, sdma->regs + SIRFSOC_DMA_CH_INT);
>>> + ? ? ? ? ? ? schan = &sdma->channels[ch];
>>> +
>>> + ? ? ? ? ? ? spin_lock(&schan->lock);
>>> +
>>> + ? ? ? ? ? ? /* Execute queued descriptors */
>>> + ? ? ? ? ? ? list_splice_tail_init(&schan->active, &schan->completed);
>>> + ? ? ? ? ? ? if (!list_empty(&schan->queued))
>>> + ? ? ? ? ? ? ? ? ? ? sirfsoc_dma_execute(schan);
>>> +
>>> + ? ? ? ? ? ? spin_unlock(&schan->lock);
>>> + ? ? }
>> Here you know which channel has triggered interrupt and you may pass
>> this info to your tasklet and avoid scanning again there
>
> ok. let me see.

we really know what channels have been trigger in irq. but we lose a
good way to transfer that to tasklet actually. if we place a flag in
schan data.
1. there can be more 1 channels triggers, then tasklet still need a for(...)
2. we actually need a lock between irq and tasklet. otherwise, new irq
coming in tasklet might change the flag.

so i think current way should be better.

>
>>
>>> +
>>> + ? ? /* Schedule tasklet */
>>> + ? ? tasklet_schedule(&sdma->tasklet);
>>> +
>>> + ? ? return IRQ_HANDLED;
>>> +}
>>> +
>>> +/* process completed descriptors */
>>> +static void sirfsoc_dma_process_completed(struct sirfsoc_dma *sdma)
>>> +{
>>> + ? ? dma_cookie_t last_cookie = 0;
>>> + ? ? struct sirfsoc_dma_chan *schan;
>>> + ? ? struct sirfsoc_dma_desc *mdesc;
>>> + ? ? struct dma_async_tx_descriptor *desc;
>>> + ? ? unsigned long flags;
>>> + ? ? LIST_HEAD(list);
>>> + ? ? int i;
>>> +
>>> + ? ? for (i = 0; i < sdma->dma.chancnt; i++) {
>>> + ? ? ? ? ? ? schan = &sdma->channels[i];
>>> +
>>> + ? ? ? ? ? ? /* Get all completed descriptors */
>>> + ? ? ? ? ? ? spin_lock_irqsave(&schan->lock, flags);
>> this will block interrupts, i dont see a reason why this should be used
>> here??
>
> ok. no irq is accessing completed list.

sorry. after reading more carefully, we actually need this lock since
irq will move finished active node to completed list. we need to keep
the completed safe.

i have fixed other issues and used jassi's v1 patch (generic xfer) and
will send v2.

Thanks
barry
