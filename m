From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 11:44:02 -0600
Subject: [PATCH v4 10/14] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180716183935.36f48f76@xps13>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-11-miquel.raynal@bootlin.com>
 <20180716152734.GA4581@rob-hp-laptop>
 <20180716183935.36f48f76@xps13>
Message-ID: <20180716174402.GA28988@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 06:39:35PM +0200, Miquel Raynal wrote:
> Hi Rob,
> 
> Rob Herring <robh@kernel.org> wrote on Mon, 16 Jul 2018 09:27:34 -0600:
> 
> > On Thu, Jul 05, 2018 at 02:40:07PM +0200, Miquel Raynal wrote:
> > > Change the documentation to reflect the new bindings used for Marvell
> > > ICU. This involves describing each interrupt group as a subnode of the
> > > ICU node. Each of them having their own compatible.
> > > 
> > > The DT binding documentation still documents the legacy binding, where
> > > there was a single node with no subnode.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/interrupt-controller/marvell,icu.txt  | 83 ++++++++++++++++++----
> > >  1 file changed, 71 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > > index 649b7ec9d9b1..83b4fbf8af65 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > > @@ -5,6 +5,8 @@ The Marvell ICU (Interrupt Consolidation Unit) controller is
> > >  responsible for collecting all wired-interrupt sources in the CP and
> > >  communicating them to the GIC in the AP, the unit translates interrupt
> > >  requests on input wires to MSG memory mapped transactions to the GIC.
> > > +These messages will access a different GIC memory area depending on
> > > +their type (NSR, SR, SEI, REI, etc).
> > >  
> > >  Required properties:
> > >  
> > > @@ -12,20 +14,19 @@ Required properties:
> > >  
> > >  - reg: Should contain ICU registers location and length.
> > >  
> > > +Subnodes: Each group of interrupt is declared as a subnode of the ICU,
> > > +with their own compatible.
> > > +
> > > +Required properties for the icu_nsr/icu_sei subnodes:
> > > +
> > > +- compatible: Should be "marvell,cp110-icu-nsr" or "marvell,cp110-icu-sei".
> > > +  
> > 
> > I raised this before and still don't understand. You had 4 types before 
> > and now you only have 2 types? How do you handle SR and REI with the new 
> > binding?
> 
> Indeed there are 4 types: NSR, SR, SEI, REI.
> 
> Until now only NSR were supported.

All 4 were supported by the binding and now only 2 though.

> I'm adding SEI support.
> 
> In the future, people might want to add support for SR/REI as well but
> they have never been supported in mainline. When support for these
> interrupts will have been contributed, I suppose it will easy to add
> two other compatibles with the same formatting "marvell,cp110-icu-xxx"?

Perhaps, but I have know way to tell.

> I hope the changes in the driver will make such contribution almost
> trivial.

You can add bindings without adding driver.

Rob
