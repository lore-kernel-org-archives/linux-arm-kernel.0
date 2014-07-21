From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Jul 2014 15:54:12 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1605488.5CKVSJec67@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721133034.GI15238@ulmo> <20140721154313.1de8bf6f@bbrezillon>
 <1605488.5CKVSJec67@avalon>
Message-ID: <20140721135410.GA13770@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:47:52PM +0200, Laurent Pinchart wrote:
> Hi Boris,
> 
> On Monday 21 July 2014 15:43:13 Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 15:30:35 +0200 Thierry Reding wrote:
> > > On Mon, Jul 21, 2014 at 03:22:05PM +0200, Laurent Pinchart wrote:
> > >> On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> > >>> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > >>>> On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> > >>>>> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> > >>>>>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> > >>
> > >> [snip]
> > >> 
> > >>>>>>> The new drm_display_info structure should look like this [2]
> > >>>>>>> (except that color_formats and bpc have not be removed yet), and
> > >>>>>>> [1] is just here to show how the video_bus_format enum would look
> > >>>>>>> like.
> > >>>>>>> 
> > >>>>>>> [1] http://code.bulix.org/rfd0yx-86557
> > >>>>>>> [2] http://code.bulix.org/7n03b4-86556
> > >>>>>> 
> > >>>>>> Quoting from your paste:
> > >>>>>> 	+   const enum video_bus_format *bus_formats;
> > >>>>>> 	+   int nbus_formats;
> > >>>>>> 
> > >>>>>> Do we really need more than one?
> > >>>>> 
> > >>>>> We do if we want to replace the color_formats and bpc fields.
> > >>>> 
> > >>>> Yes, that's what I was about to answer :-).
> > >>> 
> > >>> Maybe we don't need to replace color_formats and bpc field
> > >>> immediately. That could be done in a follow-up patch.
> > >> 
> > >> We don't need to replace them right now, but we should at least agree on
> > >> how to replace them. Introducing a new field that would need to be
> > >> replaced in the near future when removing color_formats and bpc would
> > >> be a waste of time.
> > >
> > > Sure. One of the problems I see with replacing color_formats and bpc
> > > with the above is that some of the bits within color_formats are set
> > > when the EDID is parsed. That implies that if they are replaced with
> > > an array of formats, the array would need to be reallocated during EDID
> > > parsing. That sounds like ugliness.
> > > 
> > > But if you can find a nice way to make it work that'd be great.
> > 
> > How about using a list instead of an array ?
> > This way we can add elements to this list when parsing the EDID.
> > 
> > Or we can just define a maximum size for the bus_formats array when
> > retrieving this info from EDID. If I'm correct we have at most 18 bus
> > formats:
> >  - 3 color formats:
> >    * RGB 4:4:4
> >    * YCbCr 4:4:4
> >    * YCbCr 4:4:2
> >  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color
> 
> bpc isn't a bitmask, so EDID supports up to three formats only.
> 
> The color_formats field is computed in the drm_add_display_info() function. 
> You could easily turn it into a local variable and allocate and fill the 
> formats array at the end of the function.

But you also need to be careful to keep whatever formats the driver
might have set explicitly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/2013db14/attachment.sig>
