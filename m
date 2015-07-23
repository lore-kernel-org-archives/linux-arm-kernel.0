From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 23 Jul 2015 22:01:06 +0530
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150723082934.GW3061@x1>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150723082934.GW3061@x1>
Message-ID: <CABb+yY0iKAU6aa99muVrkHyp-Ywpf1BoMRna91L6fbR7e89XZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 1:59 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Fri, Jul 17, 2015 at 5:34 PM, Lee Jones <lee.jones@linaro.org> wrote:

>> > +static void sti_mbox_enable_channel(struct mbox_chan *chan)
>> > +{
>> > +       struct sti_channel *chan_info = chan->con_priv;
>> > +       struct sti_mbox_device *mdev = chan_info->mdev;
>> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
>> > +       unsigned int instance = chan_info->instance;
>> > +       unsigned int channel = chan_info->channel;
>> > +       unsigned long flags;
>> > +       void __iomem *base;
>> > +
>> > +       base = mdev->base + (instance * sizeof(u32));
>> > +
>> Maybe have something simpler like MBOX_BASE(instance)? Or some inline
>> function to avoid this 5-lines ritual?
>
> I've checked and we can't do this, as the we need most (all?) of the
> intermediary variables too.  No ritual just to get the final variable
> for instance.
>
OK. How about ?
  #define MBOX_BASE(m, n)   ((m)->base + (n) * 4)
  void __iomem *base = MBOX_BASE(mdev, instance);


>> > +       spin_lock_irqsave(&sti_mbox_chan_lock, flags);
>> > +       mdev->enabled[instance] |= BIT(channel);
>> > +       writel_relaxed(BIT(channel), base + pdata->ena_set);
>> > +       spin_unlock_irqrestore(&sti_mbox_chan_lock, flags);
>> >
>> You don't need locking for SET/CLR type registers which are meant for
>> when they could be accessed by processors that can not share a lock.
>> So maybe drop the lock here and elsewhere.
>
> From what I can gather, I think we need this locking.  What happens if
> we get scheduled between setting the enabled bit in our cache and
> actually setting the ena_set bit?  We would be out of sync.
>
IIU what you mean... can't that still happen because of the  _relaxed()?
Anyways my point was about set/clr type regs. And you may look at if
channel really needs disabling while interrupts are handled? I think
it shouldn't because either it is going to be a to-fro communication
or random broadcasts without any guarantee of reception. But of course
you would know better your platform.
BTW  sti_mbox_channel_is_enabled() also needs to have locking around
enabled[] if you want to keep it.  And maybe embed sti_mbox_chan_lock
inside sti_mbox_device.

>> However, you need some mechanism to check if you succeeded 'owning'
>> the channel by reading back what you write to own the channel (not
>> sure which is that register here). Usually we need that action and
>> verification when we assign a channel to some user.
>
> I don't think we need to do that with this driver.  All of the
> allocation is controlled from within this code base.  The channels are
> pre-allocated and written into the co-proc's Firmware.
>
OK

>> > +       }
>> > +
>> Doesn't mbox->chans[i].con_priv need some locking here?
>
> Not that I can see.  Would you mind explaining further please?
>
Not anymore, after the clarification that we don't need a 'break' statement.

cheers.
