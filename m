From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 11 Aug 2014 08:36:00 -0400
Subject: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <20140811114014.GH15297@lukather>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
 <20140805200042.GO3952@lukather> <53E3D56C.5030204@elopez.com.ar>
 <20140811114014.GH15297@lukather>
Message-ID: <CAKON4Oyu=+KxHsa-_jV7mdc+DKr3PfTSF+X-hCjZDu=mAe0sxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 7:40 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Aug 07, 2014 at 04:37:16PM -0300, Emilio L?pez wrote:
>> Hi,
>>
>> El 05/08/14 a las 17:00, Maxime Ripard escibi?:
>> >Hi,
>> >
>> >Overall it looks very nice, thanks.
>> >
>> >On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L?pez wrote:
>> >>+static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
>> >>+                                                 struct sun4i_dma_vchan *vchan)
>> >>+{
>> >>+       struct sun4i_dma_pchan *pchan = NULL, *pchans = priv->pchans;
>> >>+       unsigned long flags;
>> >>+       int i, max;
>> >>+
>> >>+       /*
>> >>+        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
>> >>+        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
>> >>+        */
>> >>+       if (vchan->is_dedicated) {
>> >>+               i = NDMA_NR_MAX_CHANNELS;
>> >>+               max = DMA_NR_MAX_CHANNELS;
>> >>+       } else {
>> >>+               i = 0;
>> >>+               max = NDMA_NR_MAX_CHANNELS;
>> >>+       }
>> >>+
>> >>+       spin_lock_irqsave(&priv->lock, flags);
>> >>+       for_each_clear_bit_from(i, &priv->pchans_used, max) {
>> >>+               pchan = &pchans[i];
>> >>+               pchan->vchan = vchan;
>> >>+               set_bit(i, priv->pchans_used);
>> >>+               break;
>> >
>> >ffz instead?
>>
>> I think it'd look way more messy with ffz, as it only works on
>> unsigned longs and it's undefined on the all-1s case.
>>
>> We could have something like this, but I don't see much point in
>> what's basically expanding the macro
>>
>>       spin_lock_irqsave(&priv->lock, flags);
>>       i = find_next_zero_bit(&priv->pchans_used, max, i);
>>       if (i < max) {
>>               pchan = &pchans[i];
>>               pchan->vchan = vchan;
>>               set_bit(i, priv->pchans_used);
>>       }
>>       spin_unlock_irqrestore(&priv->lock, flags);
>
> What about
>
> spin_lock_irqsave(&priv->lock, flags);
> i = ffz(&priv->pchans_used);
> if (!i)
>    return NULL;
>
> pchan = &pchans[i];
> pchan->vchan = vchan;
> set_bit(i, priv->pchans_used);
>
> spin_unlock_irqrestore(&priv->lock, flags);
>
> It looks quite clean to me.
>
>> >>+static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
>> >>+{
>> >>+   struct sun4i_dma_dev *priv = dev_id;
>> >>+   struct sun4i_dma_vchan *vchan;
>> >>+   unsigned long flags;
>> >>+   int i;
>> >>+
>> >>+   for (i = 0; i < DMA_NR_MAX_VCHANS; i++) {
>> >>+           vchan = &priv->vchans[i];
>> >>+           spin_lock_irqsave(&vchan->vc.lock, flags);
>> >>+           execute_vchan_pending(priv, vchan);
>> >>+           spin_unlock_irqrestore(&vchan->vc.lock, flags);
>> >>+   }
>> >>+
>> >>+   return IRQ_HANDLED;
>> >>+}
>> >
>> >Judging from Russell's comment here, that should be in the interrupt
>> >handler
>> >
>> >http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277737.html
>>
>> Wouldn't that make the interrupt handler quite big time wise? I was
>> under the impression they should remain as short as possible. LDD3
>> says "The programmer should be careful to write a routine that
>> executes in a minimum amount of time (...)" on chapter 10
>
> Yeah, but if that involves delaying a lot a task that should have been
> performed asap, it would make sense.
>
> Plus, besides the loop in the contract's demands,
> execute_vchan_pending is actually rather small. Did you timed it to
> have such concerns?
>
>> I did try something mid-way a bit ago; I added code to see if we
>> could issue the next DMA operation from the current set, but it was
>> just extra complexity for a noop in performance, as they're sets of
>> one on all cases I tried.
>>
>> It's worth noting that the very latency sensitive DMA users we will
>> have (ie, audio) are already completely managed in the IRQ handler
>> thanks to the less flexible concept of cyclic transfers.
>
> It's not just a matter of latency, but also of throughput. If you wait
> for the tasklet softirq to be executed to schedule a new vchan, you
> aren't going to do anything during that time, while you could have.

This throughput issue is an important point. It can be so important
that I have worked on some CPUs that address it in hardware by having
shadow DMA registers.  You pre-load the shadow register set and then
the DMA engine can instantly go onto the next request in hardware.

For example if the transport stream (video input) hardware on this CPU
is turned on it is going to need high throughput DMA.


>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Jon Smirl
jonsmirl at gmail.com
