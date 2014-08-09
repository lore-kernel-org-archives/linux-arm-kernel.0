From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sat, 9 Aug 2014 11:11:59 -0400
Subject: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <53E3D56C.5030204@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
 <20140805200042.GO3952@lukather> <53E3D56C.5030204@elopez.com.ar>
Message-ID: <CAKON4Oz6c44SZ5tdQ2xi7ZKHX-GR_MRvyQJOBKuJEyg+hOYeKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 3:37 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi,
>
> El 05/08/14 a las 17:00, Maxime Ripard escibi?:
>
>> Hi,
>>
>> Overall it looks very nice, thanks.
>>
>> On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L?pez wrote:
>>>
>>> +static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev
>>> *priv,
>>> +                                                 struct sun4i_dma_vchan
>>> *vchan)
>>> +{
>>> +       struct sun4i_dma_pchan *pchan = NULL, *pchans = priv->pchans;
>>> +       unsigned long flags;
>>> +       int i, max;
>>> +
>>> +       /*
>>> +        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
>>> +        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
>>> +        */
>>> +       if (vchan->is_dedicated) {
>>> +               i = NDMA_NR_MAX_CHANNELS;
>>> +               max = DMA_NR_MAX_CHANNELS;
>>> +       } else {
>>> +               i = 0;
>>> +               max = NDMA_NR_MAX_CHANNELS;
>>> +       }
>>> +
>>> +       spin_lock_irqsave(&priv->lock, flags);
>>> +       for_each_clear_bit_from(i, &priv->pchans_used, max) {
>>> +               pchan = &pchans[i];
>>> +               pchan->vchan = vchan;
>>> +               set_bit(i, priv->pchans_used);
>>> +               break;
>>
>>
>> ffz instead?
>
>
> I think it'd look way more messy with ffz, as it only works on unsigned
> longs and it's undefined on the all-1s case.
>
> We could have something like this, but I don't see much point in what's
> basically expanding the macro
>
>         spin_lock_irqsave(&priv->lock, flags);
>         i = find_next_zero_bit(&priv->pchans_used, max, i);
>         if (i < max) {
>                 pchan = &pchans[i];
>                 pchan->vchan = vchan;
>                 set_bit(i, priv->pchans_used);
>         }
>         spin_unlock_irqrestore(&priv->lock, flags);
>
>
>>> +static int execute_vchan_pending(struct sun4i_dma_dev *priv,
>>> +                                struct sun4i_dma_vchan *vchan)
>>> +{
>>> +       struct sun4i_dma_promise *promise = NULL;
>>> +       struct sun4i_dma_contract *contract = NULL;
>>> +       struct sun4i_dma_pchan *pchan;
>>> +       struct virt_dma_desc *vd;
>>> +       int ret;
>>> +
>>> +       lockdep_assert_held(&vchan->vc.lock);
>>
>>
>> So this has to be called with a lock taken?
>>
>> You should mention that somewhere.
>> Usually, such fonctions are also prefixed by "__"
>
>
> Ok, I added a comment and the prefix now.
>
>
>>> +/**
>>> + * Generate a promise, to be used in a normal DMA contract.
>>> + *
>>> + * A NDMA promise contains all the information required to program the
>>> + * normal part of the DMA Engine and get data copied. A non-executed
>>> + * promise will live in the demands list on a contract. Once it has been
>>> + * completed, it will be moved to the completed demands list for later
>>> freeing.
>>> + * All linked promises will be freed when the corresponding contract is
>>> freed
>>> + */
>>> +static struct sun4i_dma_promise *
>>> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t
>>> dest,
>>> +                     size_t len, struct dma_slave_config *sconfig)
>>> +{
>>> +       struct sun4i_dma_promise *promise;
>>> +       int ret;
>>> +
>>> +       promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
>>> +       if (!promise)
>>> +               return NULL;
>>> +
>>> +       promise->src = src;
>>> +       promise->dst = dest;
>>> +       promise->len = len;
>>> +       promise->cfg = NDMA_CFG_LOADING |
>>> NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
>>> +
>>> +       /* Use sensible default values if client is using undefined ones
>>> */
>>> +       if (sconfig->src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
>>> +               sconfig->src_addr_width = sconfig->dst_addr_width;
>>> +       if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
>>> +               sconfig->dst_addr_width = sconfig->src_addr_width;
>>> +       if (sconfig->src_maxburst == 0)
>>> +               sconfig->src_maxburst = sconfig->dst_maxburst;
>>> +       if (sconfig->dst_maxburst == 0)
>>> +               sconfig->dst_maxburst = sconfig->src_maxburst;
>>
>>
>> I'm not sure what's the default policy on that. Vinod?
>>
>>> +static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
>>> +{
>>> +       struct sun4i_dma_dev *priv = dev_id;
>>> +       struct sun4i_dma_vchan *vchan;
>>> +       unsigned long flags;
>>> +       int i;
>>> +
>>> +       for (i = 0; i < DMA_NR_MAX_VCHANS; i++) {
>>> +               vchan = &priv->vchans[i];
>>> +               spin_lock_irqsave(&vchan->vc.lock, flags);
>>> +               execute_vchan_pending(priv, vchan);
>>> +               spin_unlock_irqrestore(&vchan->vc.lock, flags);
>>> +       }
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>
>>
>> Judging from Russell's comment here, that should be in the interrupt
>> handler
>>
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277737.html
>
>
> Wouldn't that make the interrupt handler quite big time wise? I was under
> the impression they should remain as short as possible. LDD3 says "The
> programmer should be careful to write a routine that executes in a minimum
> amount of time (...)" on chapter 10
>
> I did try something mid-way a bit ago; I added code to see if we could issue
> the next DMA operation from the current set, but it was just extra
> complexity for a noop in performance, as they're sets of one on all cases I
> tried.
>
> It's worth noting that the very latency sensitive DMA users we will have
> (ie, audio) are already completely managed in the IRQ handler thanks to the
> less flexible concept of cyclic transfers.

Other things are latency sensitive like ADC inputs. Plus adding
latency lowers the throughput of SPI and whoever else is using the
channels.

Running that code is probably just a few microseconds, not enough to
mess up overall system latency. Things that mess up system latency are
in the millisecond range.

Another thing I do in my IRQ handlers is re-read the interrupt status
register right before returning.  Then loop if any new IRQs have
asserted.   The network drivers all do this, they call it IRQ
mitigation.  Consider multiple Gbe interfaces getting hit by billions
of tiny packets. But doing IRQ mitigation you can eliminate millions
of pointless interrupts.


>
> Cheers,
>
> Emilio
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Jon Smirl
jonsmirl at gmail.com
