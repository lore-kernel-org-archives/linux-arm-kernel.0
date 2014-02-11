From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 18:36:49 +0100
Subject: [PATCH] reset: Add generic GPIO reset driver.
In-Reply-To: <CANh8QzwERe-zxCaAd4QujZJ4zcZ7SchK+w8u52fvJj0s5tx2nA@mail.gmail.com>
References: <20140210125432.10683.86571.stgit@localhost>
 <1392038191.6687.12.camel@pizza.hi.pengutronix.de>
 <CANh8QzwERe-zxCaAd4QujZJ4zcZ7SchK+w8u52fvJj0s5tx2nA@mail.gmail.com>
Message-ID: <1392140209.6943.49.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am Dienstag, den 11.02.2014, 10:34 +0100 schrieb Fuzzey, Martin:
[...]
> >> 2) Allow hardware on discoverable busses to be rest via a GPIO line
> >> without driver modifications.
> >>
> >> Examples of the second use case include:
> >> * SDIO wifi modules
> >> * USB hub chips with a reset line
> >
> > Now this is interesting. But if you export it to userspace anyway, why
> > not use the existing gpio sysfs API?
> >
> 
> In the normal case of reset on boot the userspace interface isn't needed.
> Setting the "auto" dt property will make the kernel do the reset by
> itself during
> early boot. This is the standard use case.
> 
> The userspace interface is to let applications deal with special cases.
> It is also simpler for userspace than manlually toggling the GPIO line
> and keeps the configuration (active high / low, delay) centralised in
> the DT and consistent between the automatic on boot reset and the
> manually triggered reset.
>
> > I think a proper solution should handle this in the kernel. For SDIO
> > wifi modules you usually have a powerdown line that can be implemented
> > as an rfkill switch.
> >
> 
> I think this is too specific. It's not just for SDIO wifi. We also
> have the problem
> of a USB hub needing to be reset.
> 
> Also even for the SDIO wifi case rfkill doesn't ssem the right
> abstraction to say "reset me"
> (particularly when firmware fails to load on warm boot if you don't).

so long as you need to take devices out of reset before they can be
discovered, maybe the corresponding host controller would be the right
place to put the reset.

regards
Philipp
