From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Sep 2014 22:46:00 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140929125716.GE26008@ulmo>
References: <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <CACxGe6u=QkGTKGfaE_jJ5VFMhdVKQNggp3qVBUgNP7rDbZss_A@mail.gmail.com>
 <20140929125716.GE26008@ulmo>
Message-ID: <20140929204600.GF4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 02:57:19PM +0200, Thierry Reding wrote:
> On Wed, Sep 10, 2014 at 03:56:16PM +0100, Grant Likely wrote:
> > On Wed, Sep 10, 2014 at 3:31 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, Sep 10, 2014 at 06:06:46AM -0700, Olof Johansson wrote:
> > >> On Mon, Sep 8, 2014 at 12:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > >
> > >> > Well, lets see... We've got a real user complaining about a platform
> > >> > that used to work on mainline, and no longer does. The only loophole
> > >> > for ignoring breakage is if there nobody cares that it is broken. That
> > >> > currently isn't the case. So even though it's based on a patch that
> > >> > has "DO NOT SUBMIT" in large friendly letters on the front cover, it
> > >> > doesn't change the situation that mainline has a regression.
> > >
> > >> Yeah, I'm with you on this Grant, it doesn't matter what the patch is
> > >> labelled as.
> > >
> > >> One way to deal with this could be to add a quirk at boot time --
> > >> looking for the simplefb and if found, modifies the regulators to keep
> > >> them on. That'd go in the kernel, not in firmware.
> > >
> > > Well, we should also be fixing simplefb to manage the resources it uses
> > > though that doesn't clean up after the broken DTs that are currently
> > > deployed.
> > >
> > > As well as the regulators we'll also need to fix the clocks.  If we're
> > > going to start adding these fixups perhaps we want to consider having a
> > > wrapper stage that deals with rewriting DTs prior to trying to use them?
> > > I'm not sure if it makes much difference but there's overlap with other
> > > tools like the ATAGs conversion wrapper and building separately would
> > > let the fixup code run early without directly going into the early init
> > > code (which seems a bit scary).
> > >
> > >> Much better would have been if the DRM changes worked when they
> > >> landed, so that the migration form simplefb to drm was invisible to
> > >> the user. Or at least, to get them working ASAP since they're still
> > >> broken. :(
> > >
> > > As far as I can tell the problem here is coming from the decision to
> > > have simplefb use resources without knowing about them - can we agree
> > > that this is a bad idea?
> > 
> > No, I don't think we can... there is a certain amount of "firmware got
> > things working for us, and we're going to use it for a while" that is
> > absolutely reasonable. simplefb is a good example, but there are
> > certainly others.
> > 
> > I /do/ think it would be better for the simplefb data to get embedded
> > or linked into the node of the graphics controller so that it can be
> > torn down appropriately, and we need a rule for how long boot-state
> > can be considered valid so that a proper driver can either reserve the
> > resources for a given SoC, or do a full handoff from the simplefb.
> > Even without that though, we need to be able to handle the case of an
> > anonymous simplefb node with no regulator information. If that means
> > the default simplefb behaviour is to inhibit runtime pm on all
> > resources until a real driver show up, then that might just be what we
> > need to do.
> > 
> > Two things should probably be changed from the current setup. 1)
> > simplefb shouldn't be a platform driver. It is a boot thing that
> > handles initial state from the graphics chip. By implementing it as a
> > platform driver, it prevents the real driver from binding to the real
> > device if the simplefb data embedded into it. 2) make sure that an SoC
> > driver can protect the needed resources before they are automatically
> > disabled. Either by putting them in an earlier initcall, or handling
> > it in the subsystem code. I don't know enough about the regulator and
> > clock runtime PM to know what the best way to do this is.
> 
> I posted a patch[0] earlier to do this for the clock framework in "that
> other thread". The idea is that shim drivers for these types of firmware
> devices can tell the various subsystems that they might need resources
> that aren't explicitly requested. The current implementation simply uses
> the existing infrastructure already present for the clk_ignore_unused
> command-line argument and allows drivers to declare this requirement. It
> also allows these drivers to retire the request once they've properly
> handed off to the real driver.
> 
> Something similar could be done other frameworks.
> 
> One of the objections to that in the other thread is that it won't
> prevent clocks from being disabled if some other driver was using those
> same clocks and doing a clk_enable()/clk_disable() on them. But quite
> frankly I don't think that's something we need to worry about.

That's not what has been said.

What might happen is this.

parent (gate)
  |
  +------> clock A (sound)
  |
  +------> clock B (display)

So. Let's say that at boot, we have parent enabled, and display
enabled, and that the display have been setup.

We have a sound driver that is going to probe. If at *any* point in
time, the sound driver is to disable its clock, the clock framework,
since there's no registered user left of the parent clock, will
disable the parent clock as well, effectively disabling the display
clock.

This can happen for various reason: failed probe, PM, whatever, or
even if the sound clock is to be reparented.

Quite frankly, I think that's definitely something we need to worry
about.

> Though there are two cases: one is to use simplefb as a means to have
> early boot messages on a graphical display (and optionally hand off to a
> real driver). The other is to use simplefb as the only framebuffer
> driver until a proper driver has been implemented. The latter would have
> the disadvantage of not allowing unused resources from being garbage
> collected at all. Then again, I don't think power consumption is going
> to be a very big issue on hardware where no proper display driver is
> available.

Two use cases, one single driver, and a proper way to prevent all the
issues your solution doesn't address, like the one we saw above, or
preventing the clock rate to change.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/2447a113/attachment.sig>
