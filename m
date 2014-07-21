From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Jul 2014 14:15:16 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <20140718165152.0a9fde09@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
 <20140715103136.GA6616@ulmo> <20140718165152.0a9fde09@bbrezillon>
Message-ID: <20140721121513.GB15238@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> Hi Thierry,
> 
> Oops, I missed this reply.
> 
> On Tue, 15 Jul 2014 12:31:37 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > [...]
> > > > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > [...]
> > > > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> > > > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.
> > > > 
> > > > I think it's better to refer to these using relative filenames. When the
> > > > device tree bindings are moved out of the kernel tree, they may no
> > > > longer use the same hierarchy.
> > > 
> > > Sure.
> > > By relative path you mean ../../mfd/atmel-hlcdc.txt or just
> > > mfd/atmel-hlcdc.txt ?
> > 
> > I think the former is more explicit.
> 
> Okay.
> 
> > 
> > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > +   The first cell is a phandle to a DRM panel device
> > > > > +   The second cell encodes the RGB mode, which can take the following values:
> > > > > +   * 0: RGB444
> > > > > +   * 1: RGB565
> > > > > +   * 2: RGB666
> > > > > +   * 3: RGB888
> > > > 
> > > > These are properties of the panel and should be obtained from the panel
> > > > directly rather than an additional cell in this specifier.
> > > 
> > > Okay.
> > > What's the preferred way of doing this ?
> > > What about defining an rgb-mode property in the panel node.
> > 
> > There's .bpc in struct drm_display_info, I suspect that it could be used
> > for this. Alternatively, maybe we could extend the list of color formats
> > that go into drm_display_info.color_formats? RGB444 is already covered.
> 
> I don't think this color_formats field is intended to represent data
> stream format going through the bus.
> Moreover, AFAIU, RGB444 in this definition represent RGB 4:4:4 (chroma
> subsampling rate) and not 12 bits signals (4 bits for each color).
> 
> Anyway I'll propose a patch series adding a new field to
> drm_display_info to encode the mediabus format (as discussed with
> Laurent and you).
> 
> > 
> > Also, like Laurent said, this shouldn't go into the device tree, since
> > it's already implied by the panel's compatible value, so we'd be
> > duplicating information.
> 
> Again, this is not necessarily true (depending on your board design).
> One can decide to connect an RGB888 panel on an RGB666 bus and connect
> the missing pins to ground.

I think in that case the board design itself could be considered as an
RGB888 to RGB666 bridge, and I think that's what the device tree should
be describing rather than a panel with a variable number of input
formats.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/c0a93c42/attachment-0001.sig>
