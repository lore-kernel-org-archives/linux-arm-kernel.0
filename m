From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 12 May 2016 11:01:22 +1000
Subject: [PATCH v2 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <20160511143313.GA7426@rob-hp-laptop>
References: <462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462802317-27086-1-git-send-email-joel@jms.id.au>
 <1462802317-27086-2-git-send-email-joel@jms.id.au>
 <20160511143313.GA7426@rob-hp-laptop>
Message-ID: <1463014882.20290.203.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-05-11 at 09:33 -0500, Rob Herring wrote:
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- #interrupt-cells : Specifies the number of cells needed to encode an
> > +? interrupt source. The value shall be 1.
> 
> No need for level vs. edge flags?

That's an open question. Most interrupts are fixed. A handful of GPIOs
can be configured either way. For now I am relying on uboot setting up
the right config for them and I read it back at boot time, but we could
make it part of the binding I suppose.

> > +- valid-sources : bitmask of valid irq sources
> 
> Drop this. Either all interrupt controllers need this or none of?
> them do. The valid sources are the ones described in the DT.

Looking at the code (I wrote that ages ago), this is only used for:

? - Failing map on an unsupported source, so we could drop it

? - Counting the number of sources in order to optimize the
? ? revmap size allocation. We could unconditionally allocate
? ? 64, I don't see a big deal here.

So yes Joel, feel free to just ditch this.

> > +
> > +Example:
> > +
> > + vic: interrupt-controller {
> 
> Needs a unit address.
> 
> > +????? compatible = "aspeed,ast2400-vic";
> > +????? interrupt-controller;
> > +????? #interrupt-cells = <1>;
> > +????? valid-sources = < 0xffffffff 0x0007ffff>;
> > +????? reg = <0x1e6c0080 0x80>;
> > + };
> > --?
> > 2.8.1
> >?
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at? http://vger.kernel.org/majordomo-info.html
