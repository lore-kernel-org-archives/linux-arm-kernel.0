From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Jun 2013 22:45:49 +0300
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <CADApbejTBAv0+XxkGLXuMVrLatbNurR0XBkK2gt6eQnXr+5yEA@mail.gmail.com>
References: <20130620121749.GF9817@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
 <CADApbejTBAv0+XxkGLXuMVrLatbNurR0XBkK2gt6eQnXr+5yEA@mail.gmail.com>
Message-ID: <20130624194549.GD11815@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 21, 2013 at 09:07:59AM +0800, Chao Xie wrote:
> On Fri, Jun 21, 2013 at 1:25 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 20 Jun 2013, Felipe Balbi wrote:
> >
> >> > In fact, the PHY setting and handling is related to platform or SOC,
> >> > and for different SOC they can
> >> > have same EHCI HCD but they PHY handling can be different.
> >> > Omap'a case is the example, and i think some other vendors may have
> >> > silimar cases.
> >> > From above point, It is better to leave the PHY initialization and
> >> > shutdown to be done by each echi-xxx driver.
> >> >
> >> > So Alan and Felipe
> >> > What are your ideas about it?
> >>
> >> If we have so many exceptions, then sure. But eventually, the common
> >> case should be added generically with a flag so that non-generic cases
> >> (like OMAP) can request to handle the PHY by themselves.
> >>
> >> Alan ?
> >
> > I don't have very strong feelings about this; Felipe has much more
> > experience with these things.
> >
> > However, when the common case is added into the core, the simplest way
> > to indicate that the HCD wants to handle the PHY(s) by itself will be
> > to leave hcd->phy set to NULL or an ERR_PTR value.
> >
> > One important thing that hasn't been pointed out yet: When we move
> > these calls into the core, the same patch must also remove those calls
> > from the glue drivers that currently do set hcd->phy.  And it must make
> > sure that the glue drivers which handle the PHY by themselves do not
> > set hcd->phy.
> >
> 
> From device point of view, EHCI is a standlone component. It has the
> standard sepcification, so each
> SOC vendor has EHCI HCD need to follow the standards. Then we have
> common EHCI HCD driver.
> The PHY is outside of EHCI component, each SOC vendor may have
> different PHY implementation. Then
> we have PHY driver.
> The EHCI glue driver ehci-xxx works like a SOC depended driver. It is
> its duty to handle the'
> relationship between the EHCI HCD driver and PHY driver.

that's not entirely true. We build abstractions layers so that the
commonalities can be written generically. Just look at the amount of
code I removed on v3.10 merge window by moving all other UDC drivers to
use generic constructs I introduced earlier.

It just so happens that OMAP's EHCI has two different working modes
which mandates different ways to handle the PHY, one is pretty much the
generic way (power up EHCI, then power up PHY) the other is inverted
(PHY, then EHCI), that's the only reason (as of today) we're having this
thread.

> It is same as clk, irq requested by ehci-xxx driver.

clocks could be handled generically in some cases, we have pm_clk_add()
for a reason ;-)

Also, clock handling can be hidden under pm_runtime callbacks (say,
clk_enable() on ->runtime_resume(), clk_disable() on
->runtime_suspend()). IRQ is actually handled by usbcore, you just pass
a handler which, in most cases, is the normal ehci_irq() handler.

But we'll get to those later, let's focus on PHY for now.

> So i think add a flag and use usb_get_phy() is not very good.

Alan was talking about use hcd->phy as that flag, no flag would be
added. But why isn't it very good ? you didn't mention your resoning.

> It is bette to make ehci-xxx to do the phy getting and EHCI HCD
> initialize it and shut down as the patch did, or let ehci-xxx to
> handle the PHY as Roger said.

right, so this is what Alan suggested:

ehci-xxx.c does usb_get_phy() (or any of those variants) and sets the
returned pointer to hcd->phy. From that point on, ehci-hcd will play
with the phy, resuming and suspending at the proper locations, asking
the phy to enable wakeup capabilities and the like.

In fact, because of that, I was just considering if I should protect
usb_phy* against NULL pointers, just to make EHCI's life easier, I mean:

static inline int usb_phy_set_suspend(struct usb_phy *phy, int suspend)
{
	if (!phy)
		return 0;

	return phy->suspend(phy, suspend);
}

> Based on the generic work is not too much, and does not look so
> meaningful. I suggest that let to echi-xxx
> do it.

we'll end up with a boilerplate code in every single ehci-xxx doing
exactly the same thing. By building the common case in ehci-hcd, we can
make sure to focus efforts wrt power consumption, proper use of the phy
layer, etc in a single location which (almost) everybody shares.

The other bits which are non-generic, can use ehci-hcd as a reference to
build their own stuff.

my 2 cents

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/0af29905/attachment-0001.sig>
