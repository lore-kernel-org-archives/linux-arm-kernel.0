From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Apr 2014 11:29:47 -0700
Subject: [PATCH v4 1/2] Documentation: Add GPIO reset binding to reset
 binding documentation
In-Reply-To: <1398848062.19894.38.camel@paszta.hi.pengutronix.de>
References: <1397463709-19405-1-git-send-email-p.zabel@pengutronix.de>
 <20140417115820.GD4132@lukather>
 <1398848062.19894.38.camel@paszta.hi.pengutronix.de>
Message-ID: <20140430182947.GF3000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 10:54:22AM +0200, Philipp Zabel wrote:
> Hi Maxime,
> 
> Am Donnerstag, den 17.04.2014, 13:58 +0200 schrieb Maxime Ripard:
> > I still feel like we should really treat gpios like just another reset
> > controller, ie. using the resets property.
> 
> I now feel like we really shouldn't. If we do anything but use the
> generic gpio bindings for reset gpios, we might force every OS or
> bootloader using the device tree to implement some kind of reset
> controller framework, even for hardware that only has gpio resets.

Well, we pretty much introduced that requirement already whenever we
got this framework in the first place.

You can now expect pretty much anything, even a CPU or a timer to have
a reset property, so you have to handle them anyway.

So I'd be much more in favor of consistency both with other frameworks
and within the reset framework itself.

> > I understand that you chose this pattern to be pretty much compatible
> > with what have been done so fare, bu I don't see how to fulfill that
> > goal completely, since most of the devices are actually using
> > reset-gpios, but some are using other names too (including
> > reset-gpio).
> 
> Yes, that is a problem that applies to all gpios, not only to reset
> gpios, though.

Indeed, but you're the only one I can think of that have tried to
factor the gpio handling in the framework after the facts. All the
other either have no standards and let the driver deal with it, or
have explicitly asked for a given property name.

> > So if we can't be fully backward compatible, I don't see the benefit
> > of being inconsistent with how reset controllers are used in general,
> 
> See above.
> 
> > and more globally on how gpios are tied for regulators for example.
> 
> Reset controllers are rather more similar to gpio or interrupt
> controllers. Those also have a number of entities per device node,
> as opposed to regulators.

Well, that depends on the bindings actually. The fact that the reset
controller can handle several reset lines is dependent of the
controller itself. And I believe we can say pretty much the same about
the regulators.

> > That would also make reset-gpio a regular reset driver, instead of
> > adding logic to the core itself to handle this special case.
> 
> Which is what I initially tried and moved away from.

Yeah, I know.

Overall, I'd very much like the DT maintainers to step in on
this. Especially after the discussion we had again yesterday about the
stable DT bindings things.

Stable DT bindings only works if the DT maintainers can do some
arbitration in this case.

Mark? Ping?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/5e34ea60/attachment.sig>
