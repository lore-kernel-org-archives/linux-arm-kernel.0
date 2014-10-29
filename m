From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 29 Oct 2014 09:24:19 +0100
Subject: [PATCH 3/6] ASoC: kirkwood: get rid of armada-370-db driver
In-Reply-To: <20141028230740.GQ18557@sirena.org.uk>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
 <20141028235456.7d68d53e@free-electrons.com>
 <20141028230740.GQ18557@sirena.org.uk>
Message-ID: <20141029092419.5eb8ad3a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Tue, 28 Oct 2014 23:07:40 +0000, Mark Brown wrote:

> > Hum, I'm not sure to follow you here. In a subsequent patch, I change
> > the Armada 370 DB audio complex DT description to use the
> > simple-audio-card DT binding, which makes the Armada 370 DB audio
> > machine driver irrelevant.
> 
> > Of course, this means that if someone uses an old Armada 370 DB Device
> > Tree with a new kernel, it will no longer. But I believe this is kind
> 
> Yes, this is the entire point of device tree as an ABI.  We also need to
> care about out of tree users.

Right, but I believe it has been discussed multiple times that when a
subsystem doesn't yet have the proper generic DT bindings and that
temporary solutions are used, we are allowed to break the compatibility
when moving to the proper generic DT bindings.

Another example is a platform moving from clocks defined in the platform
code to clocks defined in the Device Tree and using the common clock
framework. Should we keep around the code defining the clocks in the
platform code forever, just because old Device Tree didn't carry the
clock description?

> > of expected for this specific case: when we originally introduced the
> > Armada 370 DB audio support, we knew a proper DT binding to describe
> > sound complex was arriving, and therefore the Armada 370 DB audio
> > machine driver was only a temporary solution until the pure DT solution
> > was available.
> 
> No, that's not the case - these drivers predate DT IIRC and while it's

No, the armada-370-db driver does not predate DT. The mach-mvebu
platforms started to be supported in kernel 3.6, in full DT mode from
the beginning. The armada-370-db audio machine driver was added in
3.15, and is *only* used for the Marvell Armada 370 DB platform, which
is only described in DT.

In addition, the Marvell Armada 370 DB board is an internal evaluation
board that is not publicly available. So the rules in terms of DT
backward compatibility should I believe be a bit relaxed for such
platforms.

> good to avoid adding new drivers there's nothing inherently bad about
> having a machine driver or adaption layer into simple card (you could do
> this just as platform data for simple card for many devices).

I'm sorry but I don't understand what you mean: the simple card DT
binding is completely sufficient, in its current state, to describe the
audio complex of the Armada 370 DB.

> In this particular case I'm especially worried since we've got the whole
> thing with not having a good story for supporting simulataneous use of
> the S/PDIF and I2S links worked out yet on the controller side and on
> the simple-card side it's pretty much just the most basic CPUs that are
> supported.

I agree that the simple card binding may not be sufficient for all
situations, but in the case of this platform, it is sufficient. The
audio data gets sent simultaneously to the codec and the S/PDIF
transceiver, with no way of enabling or disabling those outputs
independently. So I believe the simple card DT binding is good enough
for this case.

> > Therefore, with the agreement of the mvebu maintainers, I'd like to be
> > allowed to break the DT backward compatibility here, and get rid of
> > this audio machine driver which would otherwise have no users left.
> 
> ...in mainline.  Doesn't this hardware tend to have lots of small
> variants on the design floating around?

Again, the armada-370-db driver is a *board* specific driver, that
works just and only for the Armada 370 DB board. Other boards may have
a different codec, maybe no S/PDIF transceivers, etc. So any "variant"
on the design would anyway have to use a different driver.

All that being said, if you really want to keep the armada-370-db audio
machine driver around that's fine with me. It's going to be just an
unused piece of code and therefore a piece of code that will probably
be broken in the near future, but I'm not the ASoC maintainer, so it's
your call.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
