From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 9 Jan 2018 15:28:34 +0100
Subject: [PATCH 06/19] drm/blend: Add a generic alpha property
In-Reply-To: <20180109135322.7lb3snbxfcezobhz@flea>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <5c765fc730d75cb362dc37bcdb3b3aeacc7bdb30.1515494838.git-series.maxime.ripard@free-electrons.com>
 <20180109123241.GU26573@phenom.ffwll.local>
 <20180109135322.7lb3snbxfcezobhz@flea>
Message-ID: <20180109142834.GZ26573@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 02:53:22PM +0100, Maxime Ripard wrote:
> On Tue, Jan 09, 2018 at 01:32:41PM +0100, Daniel Vetter wrote:
> > On Tue, Jan 09, 2018 at 11:56:25AM +0100, Maxime Ripard wrote:
> > > Some drivers duplicate the logic to create a property to store a per-plane
> > > alpha.
> > > 
> > > Let's create a helper in order to move that to the core.
> > > 
> > > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > Do we have userspace for this?
> 
> Wayland seems to be on its way to implement this, with ChromeOS using
> it:
> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html
> 
> and more specifically:
> https://chromium.googlesource.com/chromium/src/+/master/third_party/wayland-protocols/unstable/alpha-compositing/alpha-compositing-unstable-v1.xml#118

Yay, would be good to include these links in the patch description. Really
happy we're having a real standard now used by multiple people.

> > Is encoding a fixed 0-255 range really the best idea?
> 
> I don't really know, is there hardware or formats where there is more
> than 255? Or did you mean less than that?

30bit I'd assume wants more alpha. In the past we've done some fixed-point
stuff (e.g. for LUT), using the 0.0-1.0 float range. Using that for the
blend equation docs is also what I recommend (and that we map from 0-255
to 0.0-1.0 logically). Ofc the hw might not do any of that ... I think
0.16 fixed point, stored in a u16 is probably best. That's what we're
doing for gamma tables already, and that way drivers can simply throw away
the lower bits.

> > I know other drivers have skimped on the rules here a bit ... But at least
> > internally (i.e. within the drm_plane_state) we probably should restrict
> > ourselves to u8. And this needs real docs (i.e. the full blend equation
> > drivers are supposed to implement).
> 
> You mean straight vs premultiplied? Maybe we should implement this as
> an additional property in read only depending on how the hardware
> behaves?

No need for an additional property right now, but definitely document
whether you mean straight or pre-multiplied. Just writing down the blend
equation is probably best.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
