From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 24 Feb 2017 10:30:51 +0530
Subject: [PATCH v4 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <09177a6f-0612-1e17-a12e-0b1969f5b2e1@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
 <CABb+yY0rmAFutskhVkQ926QfsvtJ-WnXrQc=+PQNg=7NZEXC+Q@mail.gmail.com>
 <09177a6f-0612-1e17-a12e-0b1969f5b2e1@broadcom.com>
Message-ID: <CABb+yY1o7QTYLm3HGWNeFDPnfpL7AAJ6+R91Stn-gNvO7afxoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 12:29 AM, Jonathan Richardson
<jonathan.richardson@broadcom.com> wrote:
>
>
> On 17-02-16 10:20 PM, Jassi Brar wrote:
>> On Fri, Jan 27, 2017 at 2:08 AM, Jonathan Richardson
>> <jonathan.richardson@broadcom.com> wrote:
>>
>>> +static int iproc_mbox_send_data_m0(struct mbox_chan *chan, void *data)
>>> +{
>>> +       struct iproc_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
>>> +       struct iproc_mbox_msg *msg = (struct iproc_mbox_msg *)data;
>>> +               unsigned long flags;
>>> +       int err = 0;
>>> +       const int poll_period_us = 5;
>>> +       const int max_retries = (MAX_M0_TIMEOUT_MS * 1000) / poll_period_us;
>>> +
>>> +       if (!msg)
>>> +               return -EINVAL;
>>> +
>>> +       spin_lock_irqsave(&mbox->lock, flags);
>>> +
>>> +       dev_dbg(mbox->dev, "Send msg to M0: cmd=0x%x, param=0x%x, wait_ack=%d\n",
>>> +               msg->cmd, msg->param, msg->wait_ack);
>>> +
>> prints should be outside the spinlocks.
>>
>>> +       writel(msg->cmd, mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
>>> +       writel(msg->param, mbox->base + IPROC_CRMU_MAILBOX1_OFFSET);
>>> +
>>> +       if (msg->wait_ack) {
>>> +               int retries;
>>> +
>> move poll_period_us and max_retries in here or just define' them
>>
>>> +               err = msg->reply_code = -ETIMEDOUT;
>>> +               for (retries = 0; retries < max_retries; retries++) {
>>> +                       u32 val = readl(
>>> +                               mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
>>> +                       if (val & M0_IPC_CMD_DONE_MASK) {
>>> +                               /*
>>> +                                * M0 replied - save reply code and
>>> +                                * clear error.
>>> +                                */
>>> +                               msg->reply_code = (val &
>>> +                                       M0_IPC_CMD_REPLY_MASK) >>
>>> +                                       M0_IPC_CMD_REPLY_SHIFT;
>>> +                               err = 0;
>>> +                               break;
>>> +                       }
>>> +                       udelay(poll_period_us);
>>>
>> potentially 2ms inside spin_lock_irqsave. Alternative is to implement
>> a simple 'peek_data' and call it for requests with 'wait_ack'
> Hi Jassi. The M0 response is normally 25-30 us.
>
You hardcode the behaviour of your protocol in the controller driver.
What if your next platform/protocol has commands that the remote/M0
takes upto 10ms to respond (because they are not critical/trivial)?

If you don't have some h/w indicator (like irq or bit-flag) for
tx-done and data-rx , you have to use ack-by-client and peek method.
Commands that don't get a response will be immediately followed by
mbox_client_txdone(), while others would need to call peek_data() to
poll for data-rx. Please note, if you implement the tx_prepare
callback, you will know when to start peeking for incoming data.

> We have one message that takes 280us but we can get rid of it if necessary.
>
No. Please don't kill some needed feature just to make the driver simpler.

> Regarding your suggestion of peek_data. I don't see how it can be used
> without the spinlock to serialize multiple clients/channels over a single
> mailbox channel. peek_data is going to allow the client to poll for data.
> But the spinlock is there to prevent other clients from accessing the
> mailbox channel until any pending transaction is complete. last_tx_done
> looks like an option but even that will not prevent another client from
> clobbering a pending transaction. A shared channel among all clients
> with a blocking model would probably work, but not pretty.
>
Mailbox api provides exclusive access to its clients, just like dma-engine.
Please have a look at how other platforms do it.

Thanks.
