From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri, 07 Sep 2018 17:15:27 +0200
Subject: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <20180907142528.4daxlsd6jwnkw74h@flea>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
 <20180907132620.lmsvlwpa3rzioj2h@flea>
 <2c9689b2-c5a6-58b7-b467-fc53208ecd2d@xs4all.nl>
 <20180907142528.4daxlsd6jwnkw74h@flea>
Message-ID: <97d47388931bec3740a503b080dd9f8f9a4ec57e.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le vendredi 07 septembre 2018 ? 16:25 +0200, Maxime Ripard a ?crit :
> On Fri, Sep 07, 2018 at 03:52:00PM +0200, Hans Verkuil wrote:
> > On 09/07/2018 03:26 PM, Maxime Ripard wrote:
> > > Hi Hans,
> > > 
> > > On Fri, Sep 07, 2018 at 03:13:19PM +0200, Hans Verkuil wrote:
> > > > On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> > > > > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > 
> > > > > This introduces the Cedrus VPU driver that supports the VPU found in
> > > > > Allwinner SoCs, also known as Video Engine. It is implemented through
> > > > > a V4L2 M2M decoder device and a media device (used for media requests).
> > > > > So far, it only supports MPEG-2 decoding.
> > > > > 
> > > > > Since this VPU is stateless, synchronization with media requests is
> > > > > required in order to ensure consistency between frame headers that
> > > > > contain metadata about the frame to process and the raw slice data that
> > > > > is used to generate the frame.
> > > > > 
> > > > > This driver was made possible thanks to the long-standing effort
> > > > > carried out by the linux-sunxi community in the interest of reverse
> > > > > engineering, documenting and implementing support for the Allwinner VPU.
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > 
> > > > One high-level comment:
> > > > 
> > > > Can you add a TODO file for this staging driver? This can be done in
> > > > a follow-up patch.
> > > > 
> > > > It should contain what needs to be done to get this out of staging:
> > > > 
> > > > - Request API needs to stabilize
> > > > - Userspace support for stateless codecs must be created
> > > 
> > > On that particular note, as part of the effort to develop the driver,
> > > we've also developped two userspace components:
> > > 
> > >   - v4l2-request-test, that has a bunch of sample frames for various
> > >     codecs and will rely solely on the kernel request api (and DRM for
> > >     the display part) to test and bringup a particular driver
> > >     https://github.com/bootlin/v4l2-request-test
> > > 
> > >   - libva-v4l2-request, that is a libva implementation using the
> > >     request API
> > >     https://github.com/bootlin/libva-v4l2-request
> > > 
> > > Did you have something else in mind?
> > 
> > Reviewing this will be the next step. I haven't looked at the userspace components
> > at all yet, so I don't know yet whether it is what we expect/want/need.
> 
> We meant this as a debug tool and a stop-gap measure, respectively, so
> it might not be what you're expecting, and I'm kind of expecting to
> have the libva fade away with media frameworks getting native support.
> 
> > I think this might be a very good topic for the media summit in October if we
> > can get all the stakeholders together.
> 
> I'll be there, so we can definitely discuss this.

Note that I won't be able to attend the summit in the end.

I think some work still needs to be done in libva-v4l2-request to make
it really generic and compatible with other drivers (for instance, only
NV12 is in there at this point, and it's hardcoded in quite some
places). There are other things I'm not too happy about (e.g. I figured
very recently that the approach to "deduce" logical planes sizes and
offsets is problematic). Hopefully, I'll find time to rework that soon.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/cd1d480b/attachment.sig>
