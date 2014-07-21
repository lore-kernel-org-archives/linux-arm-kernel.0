From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 21 Jul 2014 14:34:28 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1616525.bcHvjgnZ4T@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721115737.1377a5fd@bbrezillon> <20140721121245.GA15238@ulmo>
 <1616525.bcHvjgnZ4T@avalon>
Message-ID: <20140721143428.078b68a4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jul 2014 14:16:42 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Thierry,
> 
> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> > > On Mon, 21 Jul 2014 11:32:55 +0200 Laurent Pinchart wrote:
> > >> On Monday 21 July 2014 11:24:38 Boris BREZILLON wrote:
> > >>> On Mon, 21 Jul 2014 10:59:12 +0200 Thierry Reding wrote:
> > >>>> On Fri, Jul 18, 2014 at 05:43:34PM +0200, Boris BREZILLON wrote:
> > >>>> [...]
> > >>>> 
> > >>>>>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > >>>>>>>>>> +   The first cell is a phandle to a DRM panel device
> > >>>>>>>>>> +   The second cell encodes the RGB mode, which can take the
> > >>>>>>>>>> following values:
> > >>>>>>>>>> +   * 0: RGB444
> > >>>>>>>>>> +   * 1: RGB565
> > >>>>>>>>>> +   * 2: RGB666
> > >>>>>>>>>> +   * 3: RGB888
> > >>>>>>>>> 
> > >>>>>>>>> These are properties of the panel and should be obtained from
> > >>>>>>>>> the panel directly rather than an additional cell in this
> > >>>>>>>>> specifier.
> > >>>>>>>> 
> > >>>>>>>> Okay.
> > >>>>>>>> What's the preferred way of doing this ?
> > >>>>>>>> What about defining an rgb-mode property in the panel node.
> > >>>>>>> 
> > >>>>>>> There's .bpc in struct drm_display_info, I suspect that it could
> > >>>>>>> be used for this. Alternatively, maybe we could extend the list
> > >>>>>>> of color formats that go into drm_display_info.color_formats?
> > >>>>>>> RGB444 is already covered.
> > >>>>> 
> > >>>>> I forgot to ask about bpc meaning. If, as I think, it means "bits
> > >>>>> per color" then it cannot be used to encode RGB565 where green
> > >>>>> color is encoded on 6 bits and red and blue are encoded on 5 bits.
> > >>>> 
> > >>>> Yes, I agree that bps is not a good fit for what you need here.
> > >>> 
> > >>> Okay, then I think we can replace bpc and color_formats by a
> > >>> bus_formats table containing all supported formats, and use an enum
> > >>> (something similar to v4l2_mbus_pixelcode defined in v4l2-mediabus.h
> > >>> [1]) to list the available formats.
> > >>> 
> > >>> As this implies quite a few changes in crtc core and some drm drivers
> > >>> (nouveau, i915 and radeon), I'd like to be sure this is what both of
> > >>> you had in mind.
> > >> 
> > >> I think it is, but just to make sure I understand you correctly, could
> > >> you just show how the drm_display_info structure would look like ?
> > > 
> > > The new drm_display_info structure should look like this [2] (except
> > > that color_formats and bpc have not be removed yet), and [1] is just
> > > here to show how the video_bus_format enum would look like.
> > > 
> > > [1] http://code.bulix.org/rfd0yx-86557
> > > [2] http://code.bulix.org/7n03b4-86556
> > 
> > Quoting from your paste:
> > 
> > 	+   const enum video_bus_format *bus_formats;
> > 	+   int nbus_formats;
> > 
> > Do we really need more than one?
> 
> We do if we want to replace the color_formats and bpc fields.
> 

Yes, that's what I was about to answer :-).


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
