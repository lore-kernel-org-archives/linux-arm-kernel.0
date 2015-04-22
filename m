From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 22 Apr 2015 09:13:15 +0900
Subject: [PATCH 1/3] mailbox: add support for APM X-Gene platform mailbox
 driver
In-Reply-To: <CAL85gmC-rSPqmQ2nqs=MDQCjUUh30vSfo7vEMGOcijBia31q8g@mail.gmail.com>
References: <1424216448-28665-1-git-send-email-fkan@apm.com>
 <CABb+yY31bGbQ4xipyW9pe+J6QV3con=QFuasEfmpgNNfkKKPVA@mail.gmail.com>
 <CAL85gmC-rSPqmQ2nqs=MDQCjUUh30vSfo7vEMGOcijBia31q8g@mail.gmail.com>
Message-ID: <CAJe_ZhdpZWhowO17VUNA=EKzXXD-F68Bqmi_6=eOGNnJUNEHHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2015 at 06:14, Feng Kan <fkan@apm.com> wrote:
> On Tue, Apr 21, 2015 at 12:42 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>
>>> +/* Configuration and Status Registers */
>>> +struct slimpro_mbox_reg {
>>> +       u32 in;
>>> +       u32 din0;
>>> +       u32 din1;
>>> +       u32 rsvd1;
>>> +       u32 out;
>>> +       u32 dout0;
>>> +       u32 dout1;
>>> +       u32 rsvd2;
>>> +       u32 status;
>>> +       u32 statusmask;
>>> +};
>>> +
>> Why not the normal way of defining offset macros, like most drivers do?
> I personally don't prefer one way over another, let me know if you want me
> to change to use defines.
>
Yes please.

>>
>>> +               mbox_chan_received_data(mb_chan->chan, mb_chan->rx_msg);
>>> +       }
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
>>> +{
>>> +       struct slimpro_mbox_chan *mb_chan = to_slimpro_mbox_chan(chan);
>>> +
>>> +       mb_chan_send_msg(mb_chan, msg);
>>> +       return 0;
>>> +}
>>> +
>>> +static int slimpro_mbox_startup(struct mbox_chan *chan)
>>> +{
>>> +       struct slimpro_mbox_chan *mb_chan = to_slimpro_mbox_chan(chan);
>>> +       int rc;
>>> +
>>> +       rc = devm_request_irq(mb_chan->dev, mb_chan->irq, slimpro_mbox_irq, 0,
>>> +                             MBOX_CON_NAME, mb_chan);
>>>
>> You may want to use IRQF_SHARED flag here and make slimpro_mbox_irq()
>> aware of that -- some platforms tie together irq lines of all
>> instances of a resource, like dma, mbox, so they may share the same
>> irq line.
> this is an internal dedicated irq line.
>
Yes on this platform/soc it is. But some future platform that uses the
same mbox controller might choose to tie all irqs together at the cost
of slightly increased latency. However I am OK if you are. So as you
wish for now.
