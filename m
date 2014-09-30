From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Sep 2014 14:29:54 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140930085429.GB4059@ulmo>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140930052110.GC29874@ulmo>
 <20140930075258.GH4081@lukather> <20140930085429.GB4059@ulmo>
Message-ID: <20140930122954.GJ4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
> On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
> > On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
> > > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
> > > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
> [...]
> > > > > What happened in the Snow example is that regulators that were
> > > > > previously on would all of a sudden be automatically disabled on boot
> > > > > because there was now a driver that registered them with a generic
> > > > > framework.
> > > > > 
> > > > > The same thing is going to happen with simplefb for your device. If you
> > > > > later realize that you need a regulator to keep the panel going, you'll
> > > > > have to add code to your firmware to populate the corresponding
> > > > > properties, otherwise the regulator will end up unused and will be
> > > > > automatically disabled. At the same time you're going to break upstream
> > > > > for all users of your old firmware because it doesn't add that property
> > > > > yet.
> > > > >
> > > > > And the same will continue to happen for every new type of resource
> > > > > you're going to add.
> > > > 
> > > > Sure, we can add any resources we will need. Regulators, reset lines,
> > > > pm domains, allocated memory, but I'm not really sure this is what you
> > > > want, right?
> > > 
> > > No it's not what I want. *You* want to add resource management to this
> > > driver. What I'm saying is that if we start adding clocks then we can no
> > > longer say no to resets or regulators or power domains either.
> > 
> > Yes, because resource management can be more than just "keep the thing
> > enabled". It might also be about not modifying anything, just like we
> > saw for the clocks, but that might also apply to regulators voltage.
> 
> We've already determined that simplefb can't do anything meaningful with
> the resources other than keep them in the status quo. It simply doesn't
> have enough knowledge to do so. It doesn't know the exact pixel clock or
> what voltage the attached panel needs.

We do agree that it doesn't care, doesn't need to know it, or doesn't
need to do anything about it, but what it needs is that they stay the
same. That means both keeping a clock or a regulator enabled, but also
preventing any other user (direct, as in a shared regulator, or
indirect, as in two clocks sharing the same parent) to change that
voltage or pixel clock.

You were trying to address the former in your patch, but you
completely ignore the second one, which is just as important.

> > And the only way I can think of to deal with that properly is to have
> > resources management in the driver.
> 
> My point is that if we had a proper way to tell the kernel not to do
> anything with resources owned by firmware, then the driver wouldn't
> have to do anything with the resources.

Yes, but at least for the clocks, and I guess it might be true in some
sick way for regulators too, the fact that it's a tree doesn't make
this easy at all. If they were completely independant clocks, yeah,
sure, we could do that. But it's almost never the case, and all clocks
share parents with other at some degree.

I guess you could do it using clock flags of some sort, but that would
require traversing the clock tree for almost any operation, which
doesn't look very reasonable.

> > > > I really start to consider adding a sunxi-uboot-fb, that would just
> > > > duplicate the source code of simplefb but also taking the
> > > > clocks. Somehow, I feel like it will be easier (and definitely less of
> > > > a hack than using the generic common clock API).
> > > 
> > > You're not getting it are you? What makes you think sunxi-uboot-fb is
> > > going to be any different? This isn't about a name.
> > 
> > At least, we would get to do any binding and resource management we
> > want. And that's a big win.
> 
> So instead of trying to understand the concerns that I've expressed and
> constructively contribute to finding a solution that works for everybody
> you'd rather go and write a driver from scratch. Way to go.

Hey, you haven't really contributed either to finding a solution to
the fact that we need not only to prevent the clocks from being
touched during the framework initcall, but also from other related
users.

> I've already said that I'm not saying strictly no to these patches, but
> what I want to see happen is some constructive discussion about whether
> we can find better ways to do it. If we can't then I'm all for merging
> these patches. Fortunately other (sub)threads have been somewhat more
> constructive and actually come up with alternatives that should make
> everyone happier.

I didn't see where you said that you were not strictly against
them. But ok.

I guess your concerns all boil down to 1) do not break DT backward
compatibility, 2) do not break what the firmware has set up, even on
older firmwares.

We got 1 covered already, but in order to cover 2, I guess we would
need both our solutions, that I don't really see as orthogonal.

How would something like adding optional clocks property, and if
found, doing the regular clk_* calls, and if not found, relying on
your solution work for you?

> If you're going to do SoC-specific bindings and resource management
> you are in fact implementing what Grant suggested in a
> subthread. You're implementing a dummy driver only for resource
> management, which isn't really a bad thing. It can serve as a
> placeholder for now until you add the real driver. And you can also
> use the simplefb driver to provide the framebuffer.

That could be an option too, but I'd rather avoid it if possible.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/b0ed6518/attachment.sig>
