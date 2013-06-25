From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 06:33:26 +0300
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <CADApbej4QRQBdZC9gGNy2_CfZjwM5wVhg89R0XA4Jp3vYivQsg@mail.gmail.com>
References: <20130620121749.GF9817@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
 <CADApbejTBAv0+XxkGLXuMVrLatbNurR0XBkK2gt6eQnXr+5yEA@mail.gmail.com>
 <20130624194549.GD11815@arwen.pp.htv.fi>
 <CADApbej4QRQBdZC9gGNy2_CfZjwM5wVhg89R0XA4Jp3vYivQsg@mail.gmail.com>
Message-ID: <20130625033326.GC15407@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 09:25:30AM +0800, Chao Xie wrote:
> >> It is same as clk, irq requested by ehci-xxx driver.
> >
> > clocks could be handled generically in some cases, we have pm_clk_add()
> > for a reason ;-)
> >
> > Also, clock handling can be hidden under pm_runtime callbacks (say,
> > clk_enable() on ->runtime_resume(), clk_disable() on
> > ->runtime_suspend()). IRQ is actually handled by usbcore, you just pass
> > a handler which, in most cases, is the normal ehci_irq() handler.
> >
> > But we'll get to those later, let's focus on PHY for now.
> >
> clock is another story, and i know that OMAP has full system to handle
> the clock with PM runtime,
> i would like to discuss it when one day you want to do it.

sure, anytime.

> >> So i think add a flag and use usb_get_phy() is not very good.
> >
> > Alan was talking about use hcd->phy as that flag, no flag would be
> > added. But why isn't it very good ? you didn't mention your resoning.
> >
> I maybe understand something wrong.
> Using hcd->phy as a flag to indicates whether the gule driver need
> EHCI HCD to help
> phy operation, such as initialization and shutdown, i think it is fine.
> If add another member as a flag in EHCI HCD to indicates the PHY
> differences of each echi-xxx.c driver,
> and handle them in EHCI HCD, i think that is not very good. Because as

no argument there :-)

> you said that make
> common part into EHCI HCD is the target, but this member will import
> all the differences to EHCI HCD.

oh no, by 'flag' I meant something to tell ehci-hcd that we want to
handle PHY by ourselves, but as Alan pointed out, we don't need a
separate flag.

IOW, I didn't mean to cater for OMAP's peculiarities in the generic code
:-)

> It is better to let the ehci-xxx.c driver to handle the differences if
> it does not fit EHCI HCD's requirment
> for common PHY handling just as this patch did.

right :-)

> >> It is bette to make ehci-xxx to do the phy getting and EHCI HCD
> >> initialize it and shut down as the patch did, or let ehci-xxx to
> >> handle the PHY as Roger said.
> >
> > right, so this is what Alan suggested:
> >
> > ehci-xxx.c does usb_get_phy() (or any of those variants) and sets the
> > returned pointer to hcd->phy. From that point on, ehci-hcd will play
> > with the phy, resuming and suspending at the proper locations, asking
> > the phy to enable wakeup capabilities and the like.
> >
> > In fact, because of that, I was just considering if I should protect
> > usb_phy* against NULL pointers, just to make EHCI's life easier, I mean:
> >
> > static inline int usb_phy_set_suspend(struct usb_phy *phy, int suspend)
> > {
> >         if (!phy)
> >                 return 0;
> >
> >         return phy->suspend(phy, suspend);
> > }
> >
> This patch does not include the suspending/resumeing. It is great that you are
> woking at it.

yeah, I'll add that part so that ehci-hcd doesn't have to add if
(hcd->phy) all over the place.

> >> Based on the generic work is not too much, and does not look so
> >> meaningful. I suggest that let to echi-xxx
> >> do it.
> >
> > we'll end up with a boilerplate code in every single ehci-xxx doing
> > exactly the same thing. By building the common case in ehci-hcd, we can
> > make sure to focus efforts wrt power consumption, proper use of the phy
> > layer, etc in a single location which (almost) everybody shares.
> >
> > The other bits which are non-generic, can use ehci-hcd as a reference to
> > build their own stuff.
> >
> > my 2 cents
> >
> OK. I understand. I am not very fimilar with PHY suspending/resuming.
> I hope that i can see the patch move all PHY handling to EHCI HCD
> including suspending/resuming, so
> i can change our ehci driver to fit it and continuing to push the USB
> patches ;-)

suspend/resume is usually very tricky, so I'd rather leave it for later.

For now, let's just build enough ground-work as to make it easier to
think about suspend/resume later :-)

Meaning that we can just add the bare minimum (init on probe and
shutdown on remove) and add more support as we go :-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/e95c52bb/attachment.sig>
