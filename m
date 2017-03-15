From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 15 Mar 2017 23:00:50 +0530
Subject: [PATCH v4 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <22d07bb1-9e93-4ae5-7215-923bde9ebfe5@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
 <CABb+yY0rmAFutskhVkQ926QfsvtJ-WnXrQc=+PQNg=7NZEXC+Q@mail.gmail.com>
 <09177a6f-0612-1e17-a12e-0b1969f5b2e1@broadcom.com>
 <CABb+yY1o7QTYLm3HGWNeFDPnfpL7AAJ6+R91Stn-gNvO7afxoA@mail.gmail.com>
 <22d07bb1-9e93-4ae5-7215-923bde9ebfe5@broadcom.com>
Message-ID: <CABb+yY1kbFOKJPO95SRw995zt=fCoA+SkXgECOj774i_hJUCNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 3, 2017 at 2:33 AM, Jonathan Richardson
<jonathan.richardson@broadcom.com> wrote:
>
>
> On 17-02-23 09:00 PM, Jassi Brar wrote:
>> On Fri, Feb 24, 2017 at 12:29 AM, Jonathan Richardson
>> <jonathan.richardson@broadcom.com> wrote:
>>>
>>> On 17-02-16 10:20 PM, Jassi Brar wrote:
>>>> On Fri, Jan 27, 2017 at 2:08 AM, Jonathan Richardson
>>>> <jonathan.richardson@broadcom.com> wrote:
>>>>
>>>>> +static int iproc_mbox_send_data_m0(struct mbox_chan *chan, void *data)
>>>>> +{
>>>>> +       struct iproc_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
>>>>> +       struct iproc_mbox_msg *msg = (struct iproc_mbox_msg *)data;
>>>>> +               unsigned long flags;
>>>>> +       int err = 0;
>>>>> +       const int poll_period_us = 5;
>>>>> +       const int max_retries = (MAX_M0_TIMEOUT_MS * 1000) / poll_period_us;
>>>>> +
>>>>> +       if (!msg)
>>>>> +               return -EINVAL;
>>>>> +
>>>>> +       spin_lock_irqsave(&mbox->lock, flags);
>>>>> +
>>>>> +       dev_dbg(mbox->dev, "Send msg to M0: cmd=0x%x, param=0x%x, wait_ack=%d\n",
>>>>> +               msg->cmd, msg->param, msg->wait_ack);
>>>>> +
>>>> prints should be outside the spinlocks.
>>>>
>>>>> +       writel(msg->cmd, mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
>>>>> +       writel(msg->param, mbox->base + IPROC_CRMU_MAILBOX1_OFFSET);
>>>>> +
>>>>> +       if (msg->wait_ack) {
>>>>> +               int retries;
>>>>> +
>>>> move poll_period_us and max_retries in here or just define' them
>>>>
>>>>> +               err = msg->reply_code = -ETIMEDOUT;
>>>>> +               for (retries = 0; retries < max_retries; retries++) {
>>>>> +                       u32 val = readl(
>>>>> +                               mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
>>>>> +                       if (val & M0_IPC_CMD_DONE_MASK) {
>>>>> +                               /*
>>>>> +                                * M0 replied - save reply code and
>>>>> +                                * clear error.
>>>>> +                                */
>>>>> +                               msg->reply_code = (val &
>>>>> +                                       M0_IPC_CMD_REPLY_MASK) >>
>>>>> +                                       M0_IPC_CMD_REPLY_SHIFT;
>>>>> +                               err = 0;
>>>>> +                               break;
>>>>> +                       }
>>>>> +                       udelay(poll_period_us);
>>>>>
>>>> potentially 2ms inside spin_lock_irqsave. Alternative is to implement
>>>> a simple 'peek_data' and call it for requests with 'wait_ack'
>>> Hi Jassi. The M0 response is normally 25-30 us.
>>>
>> You hardcode the behaviour of your protocol in the controller driver.
>> What if your next platform/protocol has commands that the remote/M0
>> takes upto 10ms to respond (because they are not critical/trivial)?
>>
You overlooked this concern?

>> If you don't have some h/w indicator (like irq or bit-flag) for
>> tx-done and data-rx , you have to use ack-by-client and peek method.
> There isn't any functionality not in the driver. We write the message to two registers and poll another to know when it's complete. Nothing can touch the registers again until the operation is complete. We can't even pass data back to the controller. We pass pointers to the M0 and it can write to the memory. The only data we sent back to the client is that status code from the polled register. When complete, data will already be written into the clients memory from the M0.
>> Commands that don't get a response will be immediately followed by
>> mbox_client_txdone(), while others would need to call peek_data() to
>> poll for data-rx. Please note, if you implement the tx_prepare
>> callback, you will know when to start peeking for incoming data.
> The driver will need to block access to the registers if we remove the spinlock.
> If a client sends a message that doesn't get a response and another client has
> already sent a message that does which is pending, it still needs to be blocked.
>
> The framework queues messages on a per channel basis. We have several clients for
> various drivers each with their own mbox channel. send_data in the controller could
> return EBUSY if the channel is being used by another channel (ie- transaction pending).
> If channel A sends a message, then client B sends one before A is complete, the
> controller's send_data must return an error.
>
Many platforms have clients sharing channels.
The right way to do is have a 'server/owner' client that accepts
requests from various clients and serially queue them to mailbox. That
way you can keep the controller driver free from quirks (like max wait
time of 30us) of your present platform.

thanks
