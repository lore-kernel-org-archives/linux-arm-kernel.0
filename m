From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 21 Jul 2014 11:24:38 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <20140721085908.GI8843@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
 <20140715103136.GA6616@ulmo> <20140718165152.0a9fde09@bbrezillon>
 <20140718174334.209e99c1@bbrezillon> <20140721085908.GI8843@ulmo>
Message-ID: <20140721112438.60452e09@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jul 2014 10:59:12 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Jul 18, 2014 at 05:43:34PM +0200, Boris BREZILLON wrote:
> [...]
> > > > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > > > +   The first cell is a phandle to a DRM panel device
> > > > > > > +   The second cell encodes the RGB mode, which can take the following values:
> > > > > > > +   * 0: RGB444
> > > > > > > +   * 1: RGB565
> > > > > > > +   * 2: RGB666
> > > > > > > +   * 3: RGB888
> > > > > > 
> > > > > > These are properties of the panel and should be obtained from the panel
> > > > > > directly rather than an additional cell in this specifier.
> > > > > 
> > > > > Okay.
> > > > > What's the preferred way of doing this ?
> > > > > What about defining an rgb-mode property in the panel node.
> > > > 
> > > > There's .bpc in struct drm_display_info, I suspect that it could be used
> > > > for this. Alternatively, maybe we could extend the list of color formats
> > > > that go into drm_display_info.color_formats? RGB444 is already covered.
> > > 
> > 
> > I forgot to ask about bpc meaning. If, as I think, it means "bits per
> > color" then it cannot be used to encode RGB565 where green color is
> > encoded on 6 bits and red and blue are encoded on 5 bits. 
> 
> Yes, I agree that bps is not a good fit for what you need here.

Okay, then I think we can replace bpc and color_formats by a bus_formats
table containing all supported formats, and use an enum (something
similar to v4l2_mbus_pixelcode defined in v4l2-mediabus.h [1]) to list
the available formats.

As this implies quite a few changes in crtc core and some drm drivers
(nouveau, i915 and radeon), I'd like to be sure this is what both of you
had in mind.

Best Regards,

Boris

[1]http://lxr.free-electrons.com/source/include/uapi/linux/v4l2-mediabus.h#L37

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
