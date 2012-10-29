From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Oct 2012 21:49:01 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121026160316.GY18814@opensource.wolfsonmicro.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
Message-ID: <20121029194901.GA30152@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 26, 2012 at 05:03:16PM +0100, Mark Brown wrote:
> On Fri, Oct 26, 2012 at 09:20:36AM +0300, Felipe Balbi wrote:
> > On Thu, Oct 25, 2012 at 09:59:01PM +0100, Mark Brown wrote:
> 
> > > I suspect that's not actually a big deal and that if we went down this
> > > route we'd have the driver take over control from the core code during
> > > probe() with the core still setting up the default state.
> 
> > > Personally I do think we want to be factoring bolierplate out of
> > > drivers, if they're not doing anything constructive with pinctrl they
> > > should be able to avoid having code for it.  There definitely are issues
> > > to work through but it seems like we ought to be able to do something.
> 
> > IMHO this will come back to bite you in the *ss. Specially when the same
> > driver is shared among multiple revisions of the same SoC or multiple
> > different SoCs.
> 
> I'm not entirely sure you fully understood the proposal...
> 
> > Hypothetical situation: OMAP4 has keypad as the default pin mode and low
> > power is handled by the HW, so keypad could have pinctlr "boilerplate"
> > factored out. Then comes OMAP5 and low power mode has to be handled by
> > SW for whatever reason (maybe there are more than one low power mode).
> > Then we will need to patch omap4-keypad.c to remove "dont_touch_my_pins"
> > flag and add pinctrl support.
> 
> This isn't going to make any practical difference at all, as soon as the
> driver starts using pinctrl explicitly a flag gets set in the driver and
> the default code does nothing more.  The only difference will be that we
> may get a default configuration applied prior to probe.
>
> You could have the driver explicitly set the flag, it would just be one
> extra line, but it seems marginally nicer to just do it.

You didn't get the whole picture I'm afraid. Consider the situation
where the same e.g. keypad driver is being used on OMAP4 and OMAP5 and
those have different requirements towards pinctrl.

Let's just assume for the sake of argument that OMAP4 would set the flag
on the driver structure which would tell drivers/base/ to handle pinctrl
default automatically and let's assume that's just fine for OMAP4 since
sleep mode is handled by HW (all of this is just for the sake of
argument, I'm not claiming this is how OMAP4/5 work).

Now, we need to add OMAP5 support *to the same keypad driver*.
Unfortunately, OMAP5 needs to handle pinctrl explicitly for whatever
reason (SW-controlled sleep mode, errata fix, whatever).

This will mean that we will have to remove the flag from the keypad
driver because that's not valid anymore for OMAP5.

What I'm claiming below is that quite possibly all drivers will go
through that:

- start with transparent pinctrl default mode by letting drivers/base/
  automagically take care of that for us.

- remove the 'handle-pinctrl-automatically-for-me' flag because of new
  requirements on different version of the IP.

This is why I think hiding things from drivers makes no sense. Also
consider the situations Linus W exposed on another subthread. If you
change ordering of certain calls, you will really break the
functionality of the IP. Because we can't make sure this won't work
automagically in all cases (just like we can't make sure $size memory
allocation is enough for all drivers) we don't hide that from the
driver. We require driver to manage its resources properly.

> > When you think of the possibilities of every single driver going
> > throught that it sounds a lot nicer to not make that decision IMHO and
> > keep pinctrl explicit.
> 
> I'm just not seeing any impact on drivers that do something interesting
> here.

that's because you didn't consider enough possibilities. See above.

How can you make sure that this will work for at least 50% of the
drivers ? You just can't. We don't know the implementation details of
every arch/soc/platform supported by Linux today to make that decision.

IMHO, it's best to require drivers to explicitly setup pin muxing by
calling into pinctrl framework.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/a50dc2e5/attachment.sig>
