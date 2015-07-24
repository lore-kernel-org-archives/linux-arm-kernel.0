From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 24 Jul 2015 23:04:52 +0530
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150724093638.GA3436@x1>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150723082934.GW3061@x1>
 <CABb+yY0iKAU6aa99muVrkHyp-Ywpf1BoMRna91L6fbR7e89XZQ@mail.gmail.com>
 <20150724093638.GA3436@x1>
Message-ID: <CABb+yY0Er-FBPoxx0E134bz49JzE=wxOUuoSRNuPCqV1TSE7Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 23 Jul 2015, Jassi Brar wrote:
>
>> >> > +static void sti_mbox_enable_channel(struct mbox_chan *chan)
>> >> > +{
>> >> > +       struct sti_channel *chan_info = chan->con_priv;
>> >> > +       struct sti_mbox_device *mdev = chan_info->mdev;
>> >> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
>> >> > +       unsigned int instance = chan_info->instance;
>> >> > +       unsigned int channel = chan_info->channel;
>> >> > +       unsigned long flags;
>> >> > +       void __iomem *base;
>> >> > +
>> >> > +       base = mdev->base + (instance * sizeof(u32));
>> >> > +
>> >> Maybe have something simpler like MBOX_BASE(instance)? Or some inline
>> >> function to avoid this 5-lines ritual?
>> >
>> > I've checked and we can't do this, as the we need most (all?) of the
>> > intermediary variables too.  No ritual just to get the final variable
>> > for instance.
>> >
>> OK. How about ?
>>   #define MBOX_BASE(m, n)   ((m)->base + (n) * 4)
>>   void __iomem *base = MBOX_BASE(mdev, instance);
>
> Oh, those 5 lines.  I thought you meant:
>
>        struct sti_channel *chan_info = chan->con_priv;
>        struct sti_mbox_device *mdev = chan_info->mdev;
>        unsigned int instance = chan_info->instance;
>        base = mdev->base + (instance * sizeof(u32));
>
> ... which is why I said that the intermediary variables are required.
>
> Well, I 'can' do that, but it seems to be unnecessarily obfuscating
> what's going on and doesn't actually save any lines.
>
> It's not a point that I consider arguing over though, so if you want
> me to do it, I will.  You have the final say here.
>
The macro seems tidier. Just a nit.

>> >> > +       spin_lock_irqsave(&sti_mbox_chan_lock, flags);
>> >> > +       mdev->enabled[instance] |= BIT(channel);
>> >> > +       writel_relaxed(BIT(channel), base + pdata->ena_set);
>> >> > +       spin_unlock_irqrestore(&sti_mbox_chan_lock, flags);
>> >> >
>> >> You don't need locking for SET/CLR type registers which are meant for
>> >> when they could be accessed by processors that can not share a lock.
>> >> So maybe drop the lock here and elsewhere.
>> >
>> > From what I can gather, I think we need this locking.  What happens if
>> > we get scheduled between setting the enabled bit in our cache and
>> > actually setting the ena_set bit?  We would be out of sync.
>> >
>> IIU what you mean... can't that still happen because of the  _relaxed()?
>
> Not sure what you mean.  The _relaxed variant merely omit some IO
> barriers.
>
By the time you exit the spinlock the write may still haven't been
effected. Maybe use writel() there.

>> And maybe embed sti_mbox_chan_lock inside sti_mbox_device.
>
> Not sure this is required.  I can find >600 instances of others using
> spinlocks as static globals.
>
And there should be >600 instances of *static* globals that are
protected by some static spinlock  ;)

Here the static sti_mbox_chan_lock protects sti_mbox_device which is
allocated during probe. I hope you agree that the standard practice is
to make the lock a member of the same structure that it protects.
Otherwise it gives the wrong impression that the same lock will be
used for any number of allocated mailbox instances.

cheers.
