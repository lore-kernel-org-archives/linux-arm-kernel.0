From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Oct 2012 11:24:10 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121029194901.GA30152@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
Message-ID: <20121030112410.GM4511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 09:49:01PM +0200, Felipe Balbi wrote:
> On Fri, Oct 26, 2012 at 05:03:16PM +0100, Mark Brown wrote:

> > You could have the driver explicitly set the flag, it would just be one
> > extra line, but it seems marginally nicer to just do it.

> You didn't get the whole picture I'm afraid. Consider the situation
> where the same e.g. keypad driver is being used on OMAP4 and OMAP5 and
> those have different requirements towards pinctrl.

No, I'm pretty certain that I do.

> Now, we need to add OMAP5 support *to the same keypad driver*.
> Unfortunately, OMAP5 needs to handle pinctrl explicitly for whatever
> reason (SW-controlled sleep mode, errata fix, whatever).

> This will mean that we will have to remove the flag from the keypad
> driver because that's not valid anymore for OMAP5.

This isn't a problem; either the pinctrl code for OMAP5 will do
something sensible for OMAP4 in which case there's no difference to the
resulting code or you're going to have to have conditional code for the
two devices anyway and you're no worse off.

> This is why I think hiding things from drivers makes no sense. Also
> consider the situations Linus W exposed on another subthread. If you
> change ordering of certain calls, you will really break the
> functionality of the IP. Because we can't make sure this won't work
> automagically in all cases (just like we can't make sure $size memory
> allocation is enough for all drivers) we don't hide that from the
> driver. We require driver to manage its resources properly.

We need some place to put the SoC integration; power domains seem like
the obvious place to me but YMMV.  Nothing about having this out of the
drivers requires that this be done by individual subsystems in isolation
from each other.  Half the point here is that for the reusable IPs this
stuff often isn't driver specific at all, it's often more about the SoC
integration than it is about the driver and so you'll get a consistent
pattern for most IPs on the SoC.

> How can you make sure that this will work for at least 50% of the
> drivers ? You just can't. We don't know the implementation details of
> every arch/soc/platform supported by Linux today to make that decision.

Well, we've managed to get along for rather a long time with essentially
all architectures implementing this stuff by doing static setup for the
pins on boot.  That does suggest we can get a reasonably long way with
something simple, and it does seem to match up with how things usually
look at an electrical level too.

It seems fairly obvious that if we need to add identical bolier plate
code to lots of drivers we're doing something wrong, it's just churn for
little practical gain and a problem if we ever decide to change how this
stuff works in the future.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/89953e6b/attachment.sig>
