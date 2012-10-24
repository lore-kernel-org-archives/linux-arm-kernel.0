From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Oct 2012 11:37:04 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121023200249.GA2712@core.coreip.homeip.net>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <508660D4.9030507@ti.com>
 <20121023200249.GA2712@core.coreip.homeip.net>
Message-ID: <20121024083704.GF5665@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 01:02:49PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 23, 2012 at 11:18:12AM +0200, Benoit Cousson wrote:
> > Hi Dimitry,
> > 
> > On 10/22/2012 05:50 PM, Dmitry Torokhov wrote:
> > > Hi Sourav,
> > > 
> > > On Mon, Oct 22, 2012 at 06:43:00PM +0530, Sourav Poddar wrote:
> > >> Adapt keypad to use pinctrl framework.
> > >>
> > >> Tested on omap4430 sdp with 3.7-rc1 kernel.
> > > 
> > > I do not see anything in the driver that would directly use pinctrl. Is
> > > there a better place to select default pin configuration; maybe when
> > > instantiating platform device?
> > 
> > Why?
> > The devm_pinctrl_get_select_default is using the pinctrl.
> 
> No, I guess we ihave different understanding of what "directly use" means.
> This particular driver does directly use interrupts: it requests it and
> performs some actions when interrupt arrives. Same goes for IO memory -
> it gets requested, then we access it. With pinctrl we do not do anything
> - we just ask another layer to configure it and that is it.

this is true for almost anything we do:

- we ask another layer to allocate memory for us
- we ask another layer to call our ISR once the IRQ line is asserted
- we ask another layer to handle the input events we just received
- we ask another layer to transfer data through DMA for us
- we ask another layer to turn regulators on and off.

and so on. This is just how abstractions work, we group common parts in
a framework so that users don't need to know the details, but still need
to tell the framework when to fiddle with those resources.

> I have seen just in a few days 3 or 4 drivers having exactly the same
> change - call to devm_pinctrl_get_select_default(), and I guess I will
> receive the same patches for the rest of input drivers shortly.
> This suggests that the operation is done at the wrong level. Do the
> pin configuration as you parse DT data, the same way you set up i2c
> devices registers in of_i2c.c, and leave the individual drivers that do
> not care about specifics alone.

Makes no sense to hide that from drivers. The idea here is that driver
should know when it needs its pins to muxed correctly. 95% of the time
it will be done during probe() but then again, so what ?

doing that when parsing DT, or on bus notifiers is just plain wrong.
Drivers should be required to handle all of their resources.

> > That's why it is named "get_select_default" and not "get" only.
> > This API ensure that the pin will be set to the default state, and this
> > is all we need to do during the probe.
> 
> Why during the probe and not by default? Realistically, the driver will
> be loaded as long as there is a matching device and pins will need to be
> configured.

likewise memory will be allocated when matching happens, IRQs will be
allocated, regulators will be turned on. So why don't we do all that by
default ? Because it is wrong.

> > There is no point to change the mux if the driver is not probed, because
> > potentially the pin can be use be another driver.
> 
> What other driver would use it? Who would chose what driver to load?

Well, you _do_ know that on a SoC we have a limited amount of pins
right ?

Considering the amont of features which are packed inside a single die,
it's not farfetched to assume we will have a lot less pins then we
actually need, so we need muxers behind each pin in order to choose
which functionality we want.

If it happens that keypad's pins are shared with another IP (e.g. GPIO),
we need to give the final user (a OEM/ODM) the choice of using those
pins as either keypad or GPIOs, thus the need for pinctrl framework and
the calls in the drivers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/5220f3db/attachment.sig>
