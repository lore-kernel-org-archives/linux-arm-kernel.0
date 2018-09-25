From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 11:39:27 -0500
Subject: [PATCH 2/3] dt-bindings: firmware: coreboot: document board
 variant properties
In-Reply-To: <1660300.IG1gbB27SJ@phil>
References: <20180822120214.11848-1-heiko@sntech.de>
 <20180822120214.11848-2-heiko@sntech.de>
 <20180831121836.GA23441@bogus> <1660300.IG1gbB27SJ@phil>
Message-ID: <20180925163927.GA23163@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 04:11:31PM +0200, Heiko Stuebner wrote:
> Hi Rob,
> 
> Am Freitag, 31. August 2018, 14:18:36 CEST schrieb Rob Herring:
> > On Wed, Aug 22, 2018 at 02:02:13PM +0200, Heiko Stuebner wrote:
> > > Since at least 2014 coreboot exports board specific variant ids for
> > > board-revision, used ram-modules and component variants on the same board
> > > into the loaded devicetree.
> > > 
> > > These are set on all devicetree-based Chromebooks since then, so at
> > > least we can make the effort to document these long-used properties.
> > 
> > Long used, but never reviewed, so that doesn't really matter.
> > 
> > > 
> > > A case where these are used is for example to determine the touchscreen
> > > type that is only identifyable via the sku-id when updating its firmware
> > > on the Scarlet tablet from the Gru ChromeOS family.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/coreboot.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/firmware/coreboot.txt b/Documentation/devicetree/bindings/firmware/coreboot.txt
> > > index 4c955703cea8..cfc7623e2577 100644
> > > --- a/Documentation/devicetree/bindings/firmware/coreboot.txt
> > > +++ b/Documentation/devicetree/bindings/firmware/coreboot.txt
> > > @@ -21,6 +21,12 @@ Required properties:
> > >  	0xc0389481 that resides in the topmost 8 bytes of the area.
> > >  	See coreboot's src/include/imd.h for details.
> > >  
> > > +Board variant properties determined via strapping measures (like gpios):
> > > + - board-id: board-specific id indicating the board-revision
> > > + - ram-code: board-specific id identifying the used ram-module
> > > + - sku-id: board-specific id indicating a variant (using different
> > > +           display panels for example)
> > 
> > The appear to be consumed by coreboot, but the purpose of the /firmware 
> > nodes has describing firmware interfaces provided by the platform. 
> > 
> > Not saying we can't put things to configure the firmware there, but it 
> > would be a departure and something we should consider. These properties 
> > aren't really coreboot specific and probably belong at the root node. 
> > Though I think we already discussed a 'board-id' property for QCom (and 
> > ended up with a compatible string approach instead.
> 
> These are not for configuring the firmware. Coreboot is reading the values
> from hardware-strappings, like special gpios and inserts the properties into
> the devicetree for the kernel or userspace to read back if needed.
> 
> So coreboot loads a devicetree without them from the boot-partition and
> amends that devicetree we these properties.
> 
> As indicated above, devices since 2014 do that, so I thought it might make
> sense to document that behaviour.

Reading strapping values and putting into DT seems like a perfectly 
reasonable thing to do (I'm assuming the pins get initialized to their 
function and reading them later is not possible), but that has nothing 
to do coreboot really. We don't put things u-boot touches under a u-boot 
node. These should go at the top-level IMO.

And maybe it is compelling to just take them having been in use for some 
time on widely deploying devices, but that's not really good precedence.

Rob
