From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Jul 2015 10:36:38 +0100
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <CABb+yY0iKAU6aa99muVrkHyp-Ywpf1BoMRna91L6fbR7e89XZQ@mail.gmail.com>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150723082934.GW3061@x1>
 <CABb+yY0iKAU6aa99muVrkHyp-Ywpf1BoMRna91L6fbR7e89XZQ@mail.gmail.com>
Message-ID: <20150724093638.GA3436@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jul 2015, Jassi Brar wrote:

> On Thu, Jul 23, 2015 at 1:59 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >> On Fri, Jul 17, 2015 at 5:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> >> > +static void sti_mbox_enable_channel(struct mbox_chan *chan)
> >> > +{
> >> > +       struct sti_channel *chan_info = chan->con_priv;
> >> > +       struct sti_mbox_device *mdev = chan_info->mdev;
> >> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> >> > +       unsigned int instance = chan_info->instance;
> >> > +       unsigned int channel = chan_info->channel;
> >> > +       unsigned long flags;
> >> > +       void __iomem *base;
> >> > +
> >> > +       base = mdev->base + (instance * sizeof(u32));
> >> > +
> >> Maybe have something simpler like MBOX_BASE(instance)? Or some inline
> >> function to avoid this 5-lines ritual?
> >
> > I've checked and we can't do this, as the we need most (all?) of the
> > intermediary variables too.  No ritual just to get the final variable
> > for instance.
> >
> OK. How about ?
>   #define MBOX_BASE(m, n)   ((m)->base + (n) * 4)
>   void __iomem *base = MBOX_BASE(mdev, instance);

Oh, those 5 lines.  I thought you meant:

       struct sti_channel *chan_info = chan->con_priv;
       struct sti_mbox_device *mdev = chan_info->mdev;
       unsigned int instance = chan_info->instance;
       base = mdev->base + (instance * sizeof(u32));

... which is why I said that the intermediary variables are required.

Well, I 'can' do that, but it seems to be unnecessarily obfuscating
what's going on and doesn't actually save any lines.

It's not a point that I consider arguing over though, so if you want
me to do it, I will.  You have the final say here.
 
> >> > +       spin_lock_irqsave(&sti_mbox_chan_lock, flags);
> >> > +       mdev->enabled[instance] |= BIT(channel);
> >> > +       writel_relaxed(BIT(channel), base + pdata->ena_set);
> >> > +       spin_unlock_irqrestore(&sti_mbox_chan_lock, flags);
> >> >
> >> You don't need locking for SET/CLR type registers which are meant for
> >> when they could be accessed by processors that can not share a lock.
> >> So maybe drop the lock here and elsewhere.
> >
> > From what I can gather, I think we need this locking.  What happens if
> > we get scheduled between setting the enabled bit in our cache and
> > actually setting the ena_set bit?  We would be out of sync.
> >
> IIU what you mean... can't that still happen because of the  _relaxed()?

Not sure what you mean.  The _relaxed variant merely omit some IO
barriers.

> Anyways my point was about set/clr type regs. And you may look at if
> channel really needs disabling while interrupts are handled? I think
> it shouldn't because either it is going to be a to-fro communication
> or random broadcasts without any guarantee of reception. But of course
> you would know better your platform.

I'd certainly feel more comfortable if we kept this part of the
semantics, as it's how the platform experts at ST originally wrote the
driver, and they know a lot more about the protocols used than I.

> BTW  sti_mbox_channel_is_enabled() also needs to have locking around
> enabled[] if you want to keep it.

Done.

> And maybe embed sti_mbox_chan_lock inside sti_mbox_device.

Not sure this is required.  I can find >600 instances of others using
spinlocks as static globals.

> >> Doesn't mbox->chans[i].con_priv need some locking here?
> >
> > Not that I can see.  Would you mind explaining further please?
> >
> Not anymore, after the clarification that we don't need a 'break' statement.

Great, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
