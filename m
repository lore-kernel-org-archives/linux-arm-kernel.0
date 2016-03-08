From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 8 Mar 2016 14:10:24 +0700
Subject: [PATCH V2 2/2] mailbox: Introduce TI message manager driver
In-Reply-To: <56DDD41E.2050409@ti.com>
References: <1456525452-30638-1-git-send-email-nm@ti.com>
 <1456525452-30638-3-git-send-email-nm@ti.com>
 <CABb+yY1hK4T6KAQcqNKF3D_pkLCcDVN=+T18ueV35jXbpLR+kg@mail.gmail.com>
 <56D987FF.1040607@ti.com>
 <CABb+yY1a-6V=9C+di7ZdQHDQG_M_jbYshoLqxaLiCZTqM4TfHg@mail.gmail.com>
 <56DDD41E.2050409@ti.com>
Message-ID: <CABb+yY2A35=uG9dk_VHVHbEBUsguw6414KeyQJxxp-Jnsq-0dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 2:18 AM, Nishanth Menon <nm@ti.com> wrote:
> On 03/07/2016 12:31 PM, Jassi Brar wrote:
>> On Fri, Mar 4, 2016 at 8:05 PM, Nishanth Menon <nm@ti.com> wrote:
>>>>
>>>>> +static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
>>>>> +{
>>>>> +       struct device *dev = chan->mbox->dev;
>>>>> +       struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
>>>>> +       const struct ti_msgmgr_desc *desc;
>>>>> +       struct ti_queue_inst *qinst = chan->con_priv;
>>>>> +       int msg_count, num_words, trail_bytes;
>>>>> +       struct ti_msgmgr_message *message = data;
>>>>> +       void __iomem *data_reg;
>>>>> +       u32 *word_data;
>>>>> +
>>>>> +       if (WARN_ON(!inst)) {
>>>>> +               dev_err(dev, "no platform drv data??\n");
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +       desc = inst->desc;
>>>>> +
>>>>> +       if (desc->max_message_size < message->len) {
>>>>> +               dev_err(dev, "Queue %s message length %d > max %d\n",
>>>>> +                       qinst->name, message->len, desc->max_message_size);
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +
>>>>> +       /* Are we able to send this or not? */
>>>>> +       msg_count = ti_msgmgr_queue_get_num_messages(qinst);
>>>>> +       if (msg_count >= desc->max_messages) {
>>>>> +               dev_warn(dev, "Queue %s is full (%d messages)\n", qinst->name,
>>>>> +                        msg_count);
>>>>> +               return -EBUSY;
>>>>> +       }
>>>> This seems fishy. mailbox api always submit 1 'complete' message to be
>>>> sent and checks for completion by last_tx_done() before calling
>>>> send_data() again. Controller drivers are not supposed to queue
>>>> messages - mailbox core does. So you should never be unable to send a
>>>> message.
>>>
>>>
>>> OK-> to explain this, few reasons: (queue messages check and usage of
>>> last_tx_done are kind of intertwined answer..
>>> a) we need to remember that the message manager has a shared RAM.
>>> multiple transmitter over other queues can be sharing the same.
>>> unfortunately, we dont get a threshold kind of interrupt or status that
>>> I am able to exploit in the current incarnation of the solution. The
>>> best we can do in the full system is to constrain the number of messages
>>> that are max pending simultaneously in each of the queue from various
>>> transmitters in the SoC.
>>> b) last_tx_done() is checked if TXDONE_BY_POLL, not if TXDONE_BY_ACK
>>> right? which is how this'd work since txdone_poll is false -> that is
>>> how we want this mechanism to work once the far end is ready for next
>>> message, it acks. I do see your point about being tied to protocol - I
>>> dont like it either.. in fact, I'd prefer that client registration
>>> mention what kind of handshaking is necessary, but: a) that is not how
>>> mailbox framework is constructed at the moment(we state txdone_poll at
>>> mailbox registration, not at client usage) and b) I have no real need
>>> for multiple clients to users of message manager who actually need
>>> non-ACK usage - even for the foreseeable future (at least 1 next
>>> generation of SoC) - if such a need does arise in the future, I will
>>> have to rework framework and make this capability at the registration
>>> time of the client - allowing each client path to use different
>>> mechanisms on hardware such as these that need it.
>>> c) message manager can actually queue more than one message(depending on
>>> client capability). Even though, at this point, we are not really
>>> capable of doing it(again from what I can see for immediate future),
>>> mailbox framework by checking last_tx_done forces a single message
>>> sequencing - which is not really exploiting the capability of the
>>> hardware - in theory, we should be able to queue max num messages, hit
>>> cpuidle and snooze away while the remote entity chomp away data at it's
>>> own pace and finally give us a notification back - but again, we can
>>> argue it is indeed protocol dependent, so setting txdone_poll to false
>>> actually enables that to be done in user. Again - i have no immediate
>>> need for any queued multiple transfer needs yet.. even if i need to, in
>>> the future, it can easily be done by the client by maintaining code as
>>> is - txdone_poll is false.
>>>
>> All I suggest is that the controller does not queue more than 1
>> message at a time, which means the controller driver allows for
>> maximum possible resources taken by a message.
>> The buffering is already done by the core, and if for your 'batch
>> dispatch' thing the client could simply flush them to remote by
>> pretending it got the ack (which is no worse than simply sending all
>> messages to remote without caring if the first was successful or not).
>
> Are you suggesting to set txdone_poll is true?
No.

> the controller is quite
> capable of queueing more than 1 message at a time. This the reason for
> letting the client choose the mode of operation - use ack mechanism for
> operation. client can choose to ignore the buffering in the controller,
> as you mentioned, but then, why force txdone_poll to true and deny the
> usage of the queue capability of the hardware?
>
irq/poll/ack whatever you use, there is no valid reason to buffer
messages in the controller driver. Please let me know what usecase you
have in mind that must have messages buffered in controller driver and
not core.

Thanks.
