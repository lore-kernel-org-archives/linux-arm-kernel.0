From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Jul 2014 12:37:19 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1417324.PxofUz16v0@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
 <1417324.PxofUz16v0@avalon>
Message-ID: <20140715103718.GB6616@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> Hi Boris,
> 
> On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > > > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> > > > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> > > > controller device.
> > > > 
> > > > The HLCDC block provides a single RGB output port, and only supports LCD
> > > > panels connection to LCD panels for now.
> > > > 
> > > > The atmel,panel property link the HLCDC RGB output with the LCD panel
> > > > connected on this port (note that the HLCDC RGB connector implementation
> > > > makes use of the DRM panel framework).
> > > > 
> > > > Connection to other external devices (DRM bridges) might be added later
> > > > by mean of a new atmel,xxx (atmel,bridge) property.
> > > > 
> > > > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++++++++++
> > > >  1 file changed, 59 insertions(+)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> 
> [snip]
> 
> > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > +   The first cell is a phandle to a DRM panel device
> > > > +   The second cell encodes the RGB mode, which can take the following
> > > > values: +   * 0: RGB444
> > > > +   * 1: RGB565
> > > > +   * 2: RGB666
> > > > +   * 3: RGB888
> > > 
> > > These are properties of the panel and should be obtained from the panel
> > > directly rather than an additional cell in this specifier.
> > 
> > Okay.
> > What's the preferred way of doing this ?
> > What about defining an rgb-mode property in the panel node.
> 
> You could do that, but it won't help you much, as the HLCDC driver must not 
> parse properties from the panel node. You should instead extend the drm_panel 
> API with a function to retrieve panel properties. The HLCDC driver will then 
> query the panel driver at runtime for the interface type. The panel driver 
> will get the information from hardcoded data in the driver, from DT or 
> possibly in some cases by querying the panel hardware directly.

My preference for this would be that we either add this to some existing
structure (struct drm_display_info seems like a good candidate) or if
the number of parameters grows out of hands, then maybe even introduce a
new type of device that's specific for the interface. DRM panels are an
abstraction for panels, that is, interface-agnostic, and if we start
exposing interface specific parameters things will start to become very
unwieldy.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/4a4ecd4a/attachment-0001.sig>
