From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Oct 2012 13:49:49 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121030112410.GM4511@opensource.wolfsonmicro.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
 <20121030112410.GM4511@opensource.wolfsonmicro.com>
Message-ID: <20121030114949.GC28722@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 11:24:10AM +0000, Mark Brown wrote:
> > This is why I think hiding things from drivers makes no sense. Also
> > consider the situations Linus W exposed on another subthread. If you
> > change ordering of certain calls, you will really break the
> > functionality of the IP. Because we can't make sure this won't work
> > automagically in all cases (just like we can't make sure $size memory
> > allocation is enough for all drivers) we don't hide that from the
> > driver. We require driver to manage its resources properly.
> 
> We need some place to put the SoC integration; power domains seem like
> the obvious place to me but YMMV.  Nothing about having this out of the

except that pin muxing has nothing to do with power domain. To me that
sounds like an abuse of the API.

> drivers requires that this be done by individual subsystems in isolation
> from each other.  Half the point here is that for the reusable IPs this
> stuff often isn't driver specific at all, it's often more about the SoC
> integration than it is about the driver and so you'll get a consistent
> pattern for most IPs on the SoC.

and all of that SoC-specific detail is already hidden behind power
domains, runtime PM, pinctrl, clk API, regulator framework, etc.

> > How can you make sure that this will work for at least 50% of the
> > drivers ? You just can't. We don't know the implementation details of
> > every arch/soc/platform supported by Linux today to make that decision.
> 
> Well, we've managed to get along for rather a long time with essentially
> all architectures implementing this stuff by doing static setup for the
> pins on boot.  That does suggest we can get a reasonably long way with

and this is one of the issues we're all trying to solve today so we have
single zImage approach for the ARM port.

> something simple, and it does seem to match up with how things usually
> look at an electrical level too.

simple ? I really doubt it. Just look at the amount of code duplication
the ARM port had (still has in some places) to handle platform-specific
details.

It turned out that drivers weren't very portable when they had to do
platform-specific initialization, we were all abusing platform_data to
pass strings and/or function pointers down to drivers and so on.

I'm concerned if we hide pinctrl under e.g. power domains (as said
above, it sounds like an abuse of the API to me) we will end up with a
situation like above. Maybe not as bad, but still weird-looking.

> It seems fairly obvious that if we need to add identical bolier plate
> code to lots of drivers we're doing something wrong, it's just churn for
> little practical gain and a problem if we ever decide to change how this
> stuff works in the future.

I wouldn't consider it boilerplate if you remember that each driver
might have different requirements regarding how all of those details
need to be handled.

We have to consider power consumption, ordering of calls, proper IP
setup, IP reuse on multiple platforms (even multiple ARCHes), etc etc,
and to get that right outside of the driver - who's the only class that
actually knows what it needs to do with its resources - will just be too
complex and error-prone.

I would strongly suggest starting with explicit calls to pinctrl, clk
API, etc and if we can really prove later that 95% of the users are
"standard", then we can factor code out, but making that assumption now
is quite risky IMHO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/6920f961/attachment-0001.sig>
