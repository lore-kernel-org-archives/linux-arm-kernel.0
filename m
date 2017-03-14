From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 14 Mar 2017 11:45:05 -0700
Subject: [PATCH v4 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <22d07bb1-9e93-4ae5-7215-923bde9ebfe5@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
 <CABb+yY0rmAFutskhVkQ926QfsvtJ-WnXrQc=+PQNg=7NZEXC+Q@mail.gmail.com>
 <09177a6f-0612-1e17-a12e-0b1969f5b2e1@broadcom.com>
 <CABb+yY1o7QTYLm3HGWNeFDPnfpL7AAJ6+R91Stn-gNvO7afxoA@mail.gmail.com>
 <22d07bb1-9e93-4ae5-7215-923bde9ebfe5@broadcom.com>
Message-ID: <2b43d09f-277a-9c32-feea-0ea7b83ce1d3@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17-03-02 01:03 PM, Jonathan Richardson wrote:
>
> On 17-02-23 09:00 PM, Jassi Brar wrote:
>> On Fri, Feb 24, 2017 at 12:29 AM, Jonathan Richardson
>> <jonathan.richardson@broadcom.com> wrote:
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
>> If you don't have some h/w indicator (like irq or bit-flag) for
>> tx-done and data-rx , you have to use ack-by-client and peek method.
> There isn't any functionality not in the driver. We write the message to two registers and poll another to know when it's complete. Nothing can touch the registers again until the operation is complete. We can't even pass data back to the controller. We pass pointers to the M0 and it can write to the memory. The only data we sent back to the client is that status code from the polled register. When complete, data will already be written into the clients memory from the M0.
>> Commands that don't get a response will be immediately followed by
>> mbox_client_txdone(), while others would need to call peek_data() to
>> poll for data-rx. Please note, if you implement the tx_prepare
>> callback, you will know when to start peeking for incoming data.
> The driver will need to block access to the registers if we remove the spinlock. If a client sends a message that doesn't get a response and another client has already sent a message that does which is pending, it still needs to be blocked.
>
> The framework queues messages on a per channel basis. We have several clients for various drivers each with their own mbox channel. send_data in the controller could return EBUSY if the channel is being used by another channel (ie- transaction pending). If channel A sends a message, then client B sends one before A is complete, the controller's send_data must return an error. The message remains in the queue until tx_tick is called to re-submit it again. Client A polls the controller until complete then calls mbox_client_txdone. Client B can poll the controller but first needs a way of submitting the queued message again (via tx_tick->msg_submit). Using the ACK model I see no way client B can know when to start polling (ie- when client A's message was completed) or even kick off the msg_submit again. The submitting of messages from the queue to controller's send_data relies on knowing when sending a prior message on the channel was complete. It doesn't know when another
> channel's message has been sent. The only way I can see this working is using one channel shared among clients. We don't want to add any additional queuing of messages in the controller when the framework already does it (per channel). Hope this makes sense. Thanks.
Jassi, any further comment on this? We can leave the driver as is or agree on a way to remove the spinlock. Either works for me.

To give you an idea when we're using the mailbox driver: to reset, to unmask an aon gpio interrupt from the crmu interrupt handler (that was removed from the mailbox driver), to set aon gpio's as a wake source from the pinctrl gpio driver, and to read a persistent clock from the M0 on suspend.

Please let me know so we can proceed.
>>> We have one message that takes 280us but we can get rid of it if necessary.
>>>
>> No. Please don't kill some needed feature just to make the driver simpler.
>>
>>> Regarding your suggestion of peek_data. I don't see how it can be used
>>> without the spinlock to serialize multiple clients/channels over a single
>>> mailbox channel. peek_data is going to allow the client to poll for data.
>>> But the spinlock is there to prevent other clients from accessing the
>>> mailbox channel until any pending transaction is complete. last_tx_done
>>> looks like an option but even that will not prevent another client from
>>> clobbering a pending transaction. A shared channel among all clients
>>> with a blocking model would probably work, but not pretty.
>>>
>> Mailbox api provides exclusive access to its clients, just like dma-engine.
>> Please have a look at how other platforms do it.
>> Thanks.
