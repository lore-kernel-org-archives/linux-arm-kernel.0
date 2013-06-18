From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 18 Jun 2013 10:33:07 +0800
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <201306172258.08185.arnd@arndb.de>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306172258.08185.arnd@arndb.de>
Message-ID: <CAMj5Bkh8=zc=RYoS9T_9ORYFuJeswQP2hfZ5GH_vywa_qM2DRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 4:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 June 2013, Zhangfei Gao wrote:
>> Add dmaengine driver for hisilicon k3 platform based on virt_dma
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Kai Yang <jean.yangkai@huawei.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd


> I'd like to make sure the "dma-channels" property is right though:
> You specify that number in DT but ...
>
>> +#define DRIVER_NAME          "k3-dma"
>> +#define NR_PHY_CHAN          16
>> +#define DMA_ALIGN            3
>
> ... you also hardcode the number to 16. Shouldn't the channels be
> allocated dynamically based on the dma-channels property?
>
> You do allocate "virtual channels" based on the "dma-channels"
> later. Wouldn't that be request line numbers, i.e. "dma-requests"
> rather than "dma-channels"?

Ya, I made misunderstood, thanks for point out.

- dma-channels:         Number of DMA channels supported by the controller.
- dma-requests:         Number of DMA requests signals supported by the
                        controller.
So dma-channels is physical channel num, while dma-requests is virtual
channel num.
Will update.

>
>> +static struct of_dma_filter_info k3_dma_filter;
>> +static bool k3_dma_filter_fn(struct dma_chan *chan, void *param)
>> +{
>> +     return  (*(int *)param == chan->chan_id);
>> +}
>
> This filter function works only as long as there is no more than
> one DMA engine in the system, which is something that needs to
> be documented better. Unfortunately, providing a filter
> function to be called by .xlate is currently the only way that
> the dma-engine API supports, but we should really get over that.
>
> Vinod: I think we need to add a way for a dmaengine driver to
> just return one of its channels to the xlate function. The
> current method is getting very silly, and it adds run-time and
> code complexity without any need.
>
> How about something like
>
> int dma_get_slave_channel(struct dma_chan *chan)
> {
>         /* lock against __dma_request_channel */
>         mutex_lock(&dma_list_mutex);
>
>         if (chan->client_count == 0)
>                 ret = dma_chan_get(chan);
>         else
>                 ret = -EBUSY;
>
>         mutex_unlock(&dma_list_mutex);
>
>         return ret;
> }
> EXPORT_SYMBOL_GPL(dma_get_slave_channel);

Want to double check here.
Device need specific channel via request line, the requirement still
can be met, right?

>
>> +     /* init virtual channel */
>> +     for (i = 0; i < dma_channels; i++) {
>> +             struct k3_dma_chan *c;
>> +
>> +             c = devm_kzalloc(&op->dev,
>> +                             sizeof(struct k3_dma_chan), GFP_KERNEL);
>> +             if (c == NULL)
>> +                     return -ENOMEM;
>> +
>> +             INIT_LIST_HEAD(&c->node);
>> +             c->vc.desc_free = k3_dma_free_desc;
>> +             vchan_init(&c->vc, &d->slave);
>> +     }
>
> Note that a single devm_kzalloc would be slightly more space efficient
> here.
Got it.

Thanks
