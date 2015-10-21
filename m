From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 16:53:35 +0200
Subject: [PATCH v6 1/5] clk: Add a basic multiplier clock
In-Reply-To: <20151020162939.20687.32769@quantum>
References: <1445326609-6314-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445326609-6314-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151020134343.20687.16333@quantum>
 <20151020144047.GA10947@lukather>
 <20151020162939.20687.32769@quantum>
Message-ID: <20151021145335.GF10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 09:29:39AM -0700, Michael Turquette wrote:
> Quoting Maxime Ripard (2015-10-20 07:40:47)
> > Hi Mike,
> > 
> > On Tue, Oct 20, 2015 at 06:43:43AM -0700, Michael Turquette wrote:
> > > Hi Maxime,
> > > 
> > > Quoting Maxime Ripard (2015-10-20 00:36:45)
> > > > +struct clk *clk_register_multiplier(struct device *dev, const char *name,
> > > > +                                   const char *parent_name,
> > > > +                                   unsigned long flags,
> > > > +                                   void __iomem *reg, u8 shift, u8 width,
> > > > +                                   u8 clk_mult_flags, spinlock_t *lock)
> > > > +{
> > > 
> > > Patch looks good in general. However this is a good opportunity to stop
> > > the madness around the registration functions in these basic clock
> > > types.
> > > 
> > > clk_register is really all that we need since we've had struct
> > > clk_init_data for a while. Initializing a multiplier should be as simple
> > > as:
> > > 
> > >       struct clk_multiplier clk_foo = {
> > >               .hw.init = &(struct clk_init_data){
> > >                       .name = "foo",
> > >                       .parent_names = (const char *[]){
> > >                               "bar",
> > >                       },
> > >                       .num_parents = 1;
> > >                       .ops = &clk_multiplier_ops,
> > >               },
> > >               .reg = 0xd34db33f,
> > >               .shift = 1,
> > >               .width = 2,
> > >       };
> > > 
> > >       clk_register(dev, &clk_foo.hw);
> > > 
> > > This is nice since it turns these basic clocks into even more of a
> > > library and less of a poor mans driver.
> > > 
> > > (I really hope the above works. I did not test it)
> > > 
> > > Is it possible you can convert to using this method, and if it is
> > > correct for you then just remove clk_multiplier_register altogether? (In
> > > fact you might not use the registration function at all since you use
> > > the composite clock...)
> > 
> > This chunk of code has been here since v2, which has been first posted
> > in May, two and half kernel releases ago.
> > 
> > In the meantime, we had a full-blown DMA driver and a quite unusual
> > ASoC driver merged. For some reason, this is the only piece of the
> > audio support that is missing for us, while at the same time it's the
> > most trivial.
> > 
> > If that's the only issue you have with this patch, I'm fine with
> > sending a subsequent patch this week. But I'd be really unhappy with
> > sending yet another version for a single change, while you had 5
> > monthes to review it, and we discussed it several times on IRC and
> > face to face.
> 
> The change can go in later. It's not a prerequisite. I had a feeling
> you'd be grumpy about me asking but I thought I'd try anyways. I won't
> even ask if you got sign-off from Jim on whether this works for his
> platforms ;-)

I asked several times, he never replied... :/

> The copy/paste nature of these basic clock types really sucks and it is
> one of many reasons that I am hesitant to accept them and slow to merge
> them...

I guess we cover all cases now? So it shouldn't grow that much.

> Anyways it seems that you are not using the registration function at all
> so I might just follow up with a patch to remove it.
> 
> I can pick these 5 patches directly, or do you plan to send a PR?

I have a pull request coming for you with a single patch, I can apply
them on that branch and send you the PR later today if it's okay?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/6d5be779/attachment.sig>
