From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Oct 2012 17:03:16 +0100
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121026062008.GA21734@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
Message-ID: <20121026160316.GY18814@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 09:20:36AM +0300, Felipe Balbi wrote:
> On Thu, Oct 25, 2012 at 09:59:01PM +0100, Mark Brown wrote:

> > I suspect that's not actually a big deal and that if we went down this
> > route we'd have the driver take over control from the core code during
> > probe() with the core still setting up the default state.

> > Personally I do think we want to be factoring bolierplate out of
> > drivers, if they're not doing anything constructive with pinctrl they
> > should be able to avoid having code for it.  There definitely are issues
> > to work through but it seems like we ought to be able to do something.

> IMHO this will come back to bite you in the *ss. Specially when the same
> driver is shared among multiple revisions of the same SoC or multiple
> different SoCs.

I'm not entirely sure you fully understood the proposal...

> Hypothetical situation: OMAP4 has keypad as the default pin mode and low
> power is handled by the HW, so keypad could have pinctlr "boilerplate"
> factored out. Then comes OMAP5 and low power mode has to be handled by
> SW for whatever reason (maybe there are more than one low power mode).
> Then we will need to patch omap4-keypad.c to remove "dont_touch_my_pins"
> flag and add pinctrl support.

This isn't going to make any practical difference at all, as soon as the
driver starts using pinctrl explicitly a flag gets set in the driver and
the default code does nothing more.  The only difference will be that we
may get a default configuration applied prior to probe.

You could have the driver explicitly set the flag, it would just be one
extra line, but it seems marginally nicer to just do it.

> When you think of the possibilities of every single driver going
> throught that it sounds a lot nicer to not make that decision IMHO and
> keep pinctrl explicit.

I'm just not seeing any impact on drivers that do something interesting
here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/1ccb08f7/attachment.sig>
