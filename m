From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Dec 2017 10:38:55 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: Add LED device
 node
In-Reply-To: <CAGb2v64HrvHZ-o7dRb2shUBUnwziV9ZVFVEA25+nyBrN+LffpA@mail.gmail.com>
References: <20171201162733.23156-1-wens@csie.org>
 <20171205100511.ohxcqlrozxfgq6id@flea.lan>
 <CAGb2v64HrvHZ-o7dRb2shUBUnwziV9ZVFVEA25+nyBrN+LffpA@mail.gmail.com>
Message-ID: <20171208093855.eyel7buw47efnq3i@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 09:00:37PM +0800, Chen-Yu Tsai wrote:
> On Tue, Dec 5, 2017 at 6:05 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sat, Dec 02, 2017 at 12:27:33AM +0800, Chen-Yu Tsai wrote:
> >> The Bananapi-M64 has 3 LEDS in red, green, and blue. These are toggled
> >> via GPIO lines, which drive transistors that control current across the
> >> LEDS. The red LED is by default on, via an additional pull-up on the
> >> control line. We consider this means that it is a power indicator.
> >> So we set the "default-on" property for it.
> >>
> >> The pingroups the GPIO lines belong to require external regulators be
> >> enabled to be able to drive the GPIO high. These regulators also have
> >> other purposes. However the pin controller does not have bindings for
> >> regulators. Here we just set them to always-on.
> >
> > I guess we should take the opportunity to do just that.
> >
> > We have been deferring this for quite some time now, this is a perfect
> > occasion to do it once and for all :)
> 
> True. But right now I don't see an elegant solution. What is the purpose
> of having the regulator tied to pinctrl / GPIO? You can't have the pinctrl
> driver asking for the regulator at probe time, as it might not be available
> or even have a cyclic dependency (because the PMIC is I2C driven, which
> needs an I2C controller, which needs the pinctrl).

Ah, right, you definitely have a circular dependency.

> If you defer fetching the regulator to a later point, you might end
> up with an inconsistent state.  Again with the I2C driven regulator
> example, what happens if the regulator core decides to turn the
> regulator off before the pinctrl side has a chance to take a
> reference and enable it?

I guess you could implement something based on the an asynchronous
regulator_get. You call regulator_get_async (or whatever) in the
pinctrl probe, and get notified as soon as it is registered so that
you can act upon it.

Anyway, this is a bit too much to ask to enable 3 LEDs... I've applied
that patch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/9c1af039/attachment-0001.sig>
