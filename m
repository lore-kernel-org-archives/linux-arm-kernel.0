From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 16 Jul 2018 21:38:19 +0200
Subject: [PATCH v4 10/14] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180716152734.GA4581@rob-hp-laptop>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-11-miquel.raynal@bootlin.com>
 <20180716152734.GA4581@rob-hp-laptop>
Message-ID: <20180716213819.48e13e4d@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 16 Jul 2018 09:27:34 -0600, Rob Herring wrote:

> > +Required properties for the icu_nsr/icu_sei subnodes:
> > +
> > +- compatible: Should be "marvell,cp110-icu-nsr" or "marvell,cp110-icu-sei".
> > +  
> 
> I raised this before and still don't understand. You had 4 types before 
> and now you only have 2 types? How do you handle SR and REI with the new 
> binding?

As I replied to a different e-mail, the current binding pretended to
support SR, SEI and REI, but it definitely could not.

The ICU collects wired interrupts from the CP, and forwards them to the
AP as MSIs. And contrary to what we thought when designing the current
binding, the target of the MSIs is different depending on the type of
interrupt. NSRs go to the GICP controller in the AP, SEIs go to a
special SEI controller in the AP, REIs go to a special REI controller
in the AP.

In order to represent that in the Device Tree, you need to have a
different msi-parent property for each of NSR, SEI and REI. This is not
something that the current broken binding allows to express, and it's
the reason why we're migrating to this new binding.

So even if the current binding documents that it supports NSR, SEI, REI
and SR, it definitely cannot support anything but NSR. Therefore, the
introduction of the new binding by Miqu?l does not introduce any
regression in functionality: it simply allows to really support SEIs.

Does this explanation clarify the situation, and what we're trying to
achieve ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
