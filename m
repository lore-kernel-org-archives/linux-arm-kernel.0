From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Sep 2014 10:54:32 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140930075258.GH4081@lukather>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140930052110.GC29874@ulmo>
 <20140930075258.GH4081@lukather>
Message-ID: <20140930085429.GB4059@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
> On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
> > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
[...]
> > > > What happened in the Snow example is that regulators that were
> > > > previously on would all of a sudden be automatically disabled on boot
> > > > because there was now a driver that registered them with a generic
> > > > framework.
> > > > 
> > > > The same thing is going to happen with simplefb for your device. If you
> > > > later realize that you need a regulator to keep the panel going, you'll
> > > > have to add code to your firmware to populate the corresponding
> > > > properties, otherwise the regulator will end up unused and will be
> > > > automatically disabled. At the same time you're going to break upstream
> > > > for all users of your old firmware because it doesn't add that property
> > > > yet.
> > > >
> > > > And the same will continue to happen for every new type of resource
> > > > you're going to add.
> > > 
> > > Sure, we can add any resources we will need. Regulators, reset lines,
> > > pm domains, allocated memory, but I'm not really sure this is what you
> > > want, right?
> > 
> > No it's not what I want. *You* want to add resource management to this
> > driver. What I'm saying is that if we start adding clocks then we can no
> > longer say no to resets or regulators or power domains either.
> 
> Yes, because resource management can be more than just "keep the thing
> enabled". It might also be about not modifying anything, just like we
> saw for the clocks, but that might also apply to regulators voltage.

We've already determined that simplefb can't do anything meaningful with
the resources other than keep them in the status quo. It simply doesn't
have enough knowledge to do so. It doesn't know the exact pixel clock or
what voltage the attached panel needs.

> And the only way I can think of to deal with that properly is to have
> resources management in the driver.

My point is that if we had a proper way to tell the kernel not to do
anything with resources owned by firmware, then the driver wouldn't
have to do anything with the resources.

> > > I really start to consider adding a sunxi-uboot-fb, that would just
> > > duplicate the source code of simplefb but also taking the
> > > clocks. Somehow, I feel like it will be easier (and definitely less of
> > > a hack than using the generic common clock API).
> > 
> > You're not getting it are you? What makes you think sunxi-uboot-fb is
> > going to be any different? This isn't about a name.
> 
> At least, we would get to do any binding and resource management we
> want. And that's a big win.

So instead of trying to understand the concerns that I've expressed and
constructively contribute to finding a solution that works for everybody
you'd rather go and write a driver from scratch. Way to go.

I've already said that I'm not saying strictly no to these patches, but
what I want to see happen is some constructive discussion about whether
we can find better ways to do it. If we can't then I'm all for merging
these patches. Fortunately other (sub)threads have been somewhat more
constructive and actually come up with alternatives that should make
everyone happier.

If you're going to do SoC-specific bindings and resource management you
are in fact implementing what Grant suggested in a subthread. You're
implementing a dummy driver only for resource management, which isn't
really a bad thing. It can serve as a placeholder for now until you add
the real driver. And you can also use the simplefb driver to provide
the framebuffer.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/3d87c500/attachment.sig>
