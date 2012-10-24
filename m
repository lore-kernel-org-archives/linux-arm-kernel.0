From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Oct 2012 19:52:16 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121024161429.GA16350@core.coreip.homeip.net>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <508660D4.9030507@ti.com>
 <20121023200249.GA2712@core.coreip.homeip.net>
 <20121024083704.GF5665@arwen.pp.htv.fi>
 <20121024161429.GA16350@core.coreip.homeip.net>
Message-ID: <20121024165215.GA32220@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 24, 2012 at 09:14:29AM -0700, Dmitry Torokhov wrote:

<snip>

> > > No, I guess we ihave different understanding of what "directly use" means.
> > > This particular driver does directly use interrupts: it requests it and
> > > performs some actions when interrupt arrives. Same goes for IO memory -
> > > it gets requested, then we access it. With pinctrl we do not do anything
> > > - we just ask another layer to configure it and that is it.
> > 
> > this is true for almost anything we do:
> > 
> > - we ask another layer to allocate memory for us
> > - we ask another layer to call our ISR once the IRQ line is asserted
> > - we ask another layer to handle the input events we just received
> > - we ask another layer to transfer data through DMA for us
> > - we ask another layer to turn regulators on and off.
> 
> But we are _directly_ _using_ all of these. You allocate memory and you
> (the driver) stuff data into that memory. You ask for DMA and you take
> the DMAed data and work with it. Not so with pinctrl in omap keypad and
> other drivers I have seen so far.

of course we are. If we don't mux the pins to their correct setting, we
can't realy use the HW. So while you don't see any SW control of the
requested pins, we're still making use of them.

> > and so on. This is just how abstractions work, we group common parts in
> > a framework so that users don't need to know the details, but still need
> > to tell the framework when to fiddle with those resources.
> > 
> > > I have seen just in a few days 3 or 4 drivers having exactly the same
> > > change - call to devm_pinctrl_get_select_default(), and I guess I will
> > > receive the same patches for the rest of input drivers shortly.
> > > This suggests that the operation is done at the wrong level. Do the
> > > pin configuration as you parse DT data, the same way you set up i2c
> > > devices registers in of_i2c.c, and leave the individual drivers that do
> > > not care about specifics alone.
> > 
> > Makes no sense to hide that from drivers. The idea here is that driver
> > should know when it needs its pins to muxed correctly.
> 
> The driver also needs memory controller to be initialized, gpio chip be
> ready and registered, DMA subsystem ready, input core reade, etc, etc,
> etc. You however do not have every driver explicitly initialize any of
> that; you expect certain working environment to be already operable. The
> driver does manage resources it controls, it has ultimate knowledge
> about, pin configuration is normally is not it. We just need to know
> that we wired/muxed properly, otherwise we won't work. So please let
> parent layers deal with it.
> 
> > 95% of the time
> > it will be done during probe() but then again, so what ?
> > 
> > doing that when parsing DT, or on bus notifiers is just plain wrong.
> > Drivers should be required to handle all of their resources.
> 
> All of _their_ resources, exactly. They do not own nor control pins so
> they should not be bothered with them either. Look, when you see that

except that they *own* the pins. Now that the muxer has been setup
properly, this particular IP owns the pins.

> potentially _every_ driver in the system needs to set up the same object
> that it doe snot use otherwise you should realize that individual driver
> is not the proper place to do that.

fair enough, but IMHO, we're not there yet. We can't make that claim
yet. Besides, we don't know what's the default pin state in a system. It
might be that certain pins start out in a way which consumes less power
due to the internal construction of the SoC. If we set pins up before
driver probes, and probe fails or the driver is never really used, then
we could be falling into a situation where we're wasting power.

Granted, you can undo everything you did before, but I guess keeping
track of everything we setup before probe() just to remove a couple of
lines from drivers is wrong.

> > > > That's why it is named "get_select_default" and not "get" only.
> > > > This API ensure that the pin will be set to the default state, and this
> > > > is all we need to do during the probe.
> > > 
> > > Why during the probe and not by default? Realistically, the driver will
> > > be loaded as long as there is a matching device and pins will need to be
> > > configured.
> > 
> > likewise memory will be allocated when matching happens, IRQs will be
> > allocated, regulators will be turned on. So why don't we do all that by
> > default ? Because it is wrong.
> 
> No, because we do not know how. The generic layer does not know the ISR
> to install, how much memory to allocate, etc. Having regulator turned on
> before getting to probe might not be a bad idea.

what if your driver never probes ? Will you really leave regulators on
consuming extra, valuable power ?

> > > > There is no point to change the mux if the driver is not probed, because
> > > > potentially the pin can be use be another driver.
> > > 
> > > What other driver would use it? Who would chose what driver to load?
> > 
> > Well, you _do_ know that on a SoC we have a limited amount of pins
> > right ?
> > 
> > Considering the amont of features which are packed inside a single die,
> > it's not farfetched to assume we will have a lot less pins then we
> > actually need, so we need muxers behind each pin in order to choose
> > which functionality we want.
> > 
> > If it happens that keypad's pins are shared with another IP (e.g. GPIO),
> > we need to give the final user (a OEM/ODM) the choice of using those
> > pins as either keypad or GPIOs, thus the need for pinctrl framework and
> > the calls in the drivers.
> 
> Right, so please walk me through, step by step, how an OEM/ODM woudl
> select a particular configuration. Do you expect it to happen at
> runtime, or do you expect relevant data be put in DT?

It depends, I've seen both happening, really. Also note that DT
migration is still not complete, meaning that most (all ?) OEM/ODMs are
still using the legacy board-file-based approach and it will still take
them a few years to move to DT-based boot.

Another point to consider is community boards such as beaglebone which
have tens of different "capes" to support. Depending on the cape, pins
might have to be remuxed, so instead of adding all that code to platform
support, just leave it all in drivers. Depending on the "cape" different
drivers will probe() and those drivers should know how to mux pins for
themselves.

Note that these are only the two easy examples that came to my mind, I'm
sure we can discuss this for a long, but is it valid ? For a single line
of code ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/1f1b2220/attachment.sig>
