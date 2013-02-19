From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Feb 2013 10:17:12 +0200
Subject: [PATCH v7 1/2] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C1431209537@DFLE08.ent.ti.com>
References: <cover.1359684780.git.rtivy@ti.com>
 <d9e1adbe6b12aab495f0292c4553c5c8f61c70b5.1359684780.git.rtivy@ti.com>
 <CAK=WgbafX++Nj62w7w0UP-eQdFDWq_NGgTWVmnVxUUbe+WycEA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C1431209537@DFLE08.ent.ti.com>
Message-ID: <CAK=WgbbYQf9jKB-HvdUsGJJAj_Q+qiMEDC1msWJAs2dWocu5zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Feb 19, 2013 at 1:02 AM, Tivy, Robert <rtivy@ti.com> wrote:
>> It looks like this patch squashes:
>> 1. A fix to drivers/remoteproc/Kconfig
>> 2. New functionality in remoteproc_core.c
>> 3. A new da8xx driver
>>
>> These are independent changes, so we better split them up to separate
>> patches.
>
> Ok, I will submit separate patches for these.  In doing so, I will have a stand-alone patch for the drivers/remoteproc/Kconfig fix, as well as the driver-related addition to that file in the driver patch.  PCMIIW.

We should have one patch for the Kconfig fix, another one for the new
firmware-name functionality in rproc_alloc() and then a patch adding
this new driver.

>> > +static irqreturn_t handle_event(int irq, void *p)
>> > +{
>> > +       struct rproc *rproc = (struct rproc *)p;
>> > +
>> > +       /* Process incoming buffers on our vring */
>> > +       while (IRQ_HANDLED == rproc_vq_interrupt(rproc, 0))
>> > +               ;
>> > +
>> > +       /* Must allow wakeup of potenitally blocking senders */
>> > +       rproc_vq_interrupt(rproc, 1);
>>
>> IIRC we agreed on removing this part, and instead adding it to the
>> generic remoteproc framework (i.e. Cyril's patch).
>
> I didn't like the idea of having extra overhead when calling the "all virtqueues" version.
>
> We know that we want to call rproc_vq_interrupt(rproc, 1) just once, and don't care about its return value.  If we did
>       /* Process incoming buffers on our vring */
>       while (IRQ_HANDLED == rproc_vq_interrupt(rproc, -1))
>               ;
> then that would essentially turn into:
>         do {
>                 ret = IRQ_NONE;
>                 if (rproc_vq_interrupt(rproc, 0) == IRQ_HANDLED)
>                         ret = IRQ_HANDLED;
>                 if (rproc_vq_interrupt(rproc, 1) == IRQ_HANDLED)
>                         ret = IRQ_HANDLED;
>         } while (ret == IRQ_HANDLED);
> which will end up calling rproc_vq_interrupt(rproc, 1) too many times.
>
> We have a benchmark goal to keep wrt/ the whole round-trip time of messages and we're currently not even achieving that, so more overhead than today can't be tolerated.

Have you checked whether it really affects performance? I'd expect
this to be very negligible. We can probably also maintain a bitmap
with bits set for every IRQ_HANDLED vring, and stop processing vrings
that has this bit cleared.

But it actually looks like there's a different problem here.
rproc_vq_interrupt() may also return IRQ_HANDLED on the unlikely event
that vq->broken is set. With the current approach taken by this patch,
this may lock the system in a busy loop.

I took a brief look at the other virtio drivers, and it seems they
process all pending messages available when kicked, so we should
probably add this to rpmsg_recv_done() too. This way we don't have to
manually do it in the remoteproc layer, and all platforms will benefit
from it.

We should then only have to allow the option of asking the core to
process all available vrings, as we discussed, and we're done.

Thanks,
Ohad.
