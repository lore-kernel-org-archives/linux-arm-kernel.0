From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 3 Dec 2015 10:35:36 +0530
Subject: [PATCHv7 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <CAAtXAHe_7vR71wZPbEw1so_40OEHiNN38mnTuqoX7SCwqEpfcw@mail.gmail.com>
References: <1436922022-17564-1-git-send-email-moritz.fischer@ettus.com>
 <1436922022-17564-3-git-send-email-moritz.fischer@ettus.com>
 <CABb+yY3tpepdO=s9nb9kAE241sYVTTXB-ci_4ihuthHTekedNg@mail.gmail.com>
 <CAAtXAHe_7vR71wZPbEw1so_40OEHiNN38mnTuqoX7SCwqEpfcw@mail.gmail.com>
Message-ID: <CAJe_ZhexWxTOYTLKH0-NPQ-XVARFUatHVT_XGYcDe_Vhx8ncOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2015 at 22:56, Moritz Fischer <moritz.fischer@ettus.com> wrote:
> Hi Jassi,
>
> thanks for your feedback.
>
> On Mon, Aug 10, 2015 at 1:05 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Wed, Jul 15, 2015 at 6:30 AM, Moritz Fischer
>> <moritz.fischer@ettus.com> wrote:
>>
>>> +
>>> +static void xilinx_mbox_rx_data(struct mbox_chan *chan)
>>> +{
>>> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
>>> +       u32 data;
>>> +
>>> +       if (xilinx_mbox_pending(mbox)) {
>>> +               data = readl_relaxed(mbox->mbox_base + MAILBOX_REG_RDDATA);
>>> +               mbox_chan_received_data(chan, (void *)data);
>>>
>> If RDDATA is a FIFO, then above seems wrong - you are assuming
>> messages are always going to be exactly 32-bits for every protocol.
>> Ideally you should empty the fifo fully, at least when RX has an
>> interrupt.
>
> From my understanding it's hard to tell how much actually is in the fifo,
> you can tell if it's full for send direction, or empty for read direction.
>
Simply read the whole FIFO and leave it to the client driver to parse
that data according to the protocol it drives.

> Maybe the STI / RTI can be setup in a smart way to work with multiple message
> sizes.
>>
>>> +
>>> +static int xilinx_mbox_irq_send_data(struct mbox_chan *chan, void *data)
>>> +{
>>> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
>>> +       u32 *udata = data;
>>> +
>>> +       if (xilinx_mbox_full(mbox))
>>> +               return -EBUSY;
>>>
>> This check is redundant. last_tx_done already makes sure this is always true.
>
> Good to know. I'll fix it.
>>
>>> +       /* enable interrupt before send */
>>> +       xilinx_mbox_tx_intmask(mbox, true);
>>> +
>>> +       writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
>>> +
>> From status EMPTY and FULL, it seems WRDATA is a FIFO. So here also
>> you should expect messages to be <= fifo depth. And not assume exactly
>> 32bit messages always.
>
> How do I determine the message size?
>
Always expect any write request is exactly the size of FIFO depth.

> Doesn't
> drivers/mailbox/bcm2835-mailbox.c or
>
Well I did point it out
http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-June/001902.html
 ... but developer assumes there will _never_ be need to pass a
message bigger than 32-bits. Sadly overlooking the possibility that
some protocol might have simple, say, 64-bits wide commands and
responses that could avoid using any Shared-Memory at all.

> mailbox-altera.c make the same assumption?
>
There are 2 registers, for CMD and PRT each, that make up 1 message.
It doesn't seem like a fifo.

>>
>>> +
>>> +static bool xilinx_mbox_last_tx_done(struct mbox_chan *chan)
>>> +{
>>> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
>>> +
>>> +       /* return false if mailbox is full */
>>> +       return !xilinx_mbox_full(mbox);
>>>
>> Instead of FULL, I think it should check for stricter EMPTY status ...
>> mbox api submits only 1 message at a time.
>
> The EMPTY status applies to the receive direction only, I could check
> the STI status
> bit though I suppose.
>
I don't know the h/w but you get my idea. So whatever is in the next revision.

> [...]
>>> +
>>> +       mbox->irq = platform_get_irq(pdev, 0);
>>> +       /* if irq is present, we can use it, otherwise, poll */
>>> +       if (mbox->irq > 0) {
>>> +               mbox->controller.txdone_irq = true;
>>> +               mbox->controller.ops = &xilinx_mbox_irq_ops;
>>> +       } else {
>>> +               dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
>>> +               mbox->controller.txdone_poll = true;
>>> +               mbox->controller.txpoll_period = MBOX_POLLING_MS;
>>> +               mbox->controller.ops = &xilinx_mbox_poll_ops;
>>> +
>>> +               setup_timer(&mbox->rxpoll_timer, xilinx_mbox_poll_rx,
>>> +                           (unsigned long)&mbox->chan);
>>>
>> I believe there is indeed some platform that doesn't have RX-Interrupt?
>>  If no, please remove this.
>>  If yes, you may want to get some hint from platform about the size of
>> messages and do mbox_chan_received_data() only upon reading those many
>> bytes.
>
> I'd be fine to drop the polling use case for the moment, on my
> platform I can wire up the IRQ.
> We can always add it back in in a follow up use case.
>

Thanks.
