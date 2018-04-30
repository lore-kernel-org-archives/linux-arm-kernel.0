From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 30 Apr 2018 17:18:03 +0200
Subject: [PATCH 00/24] device link, bridge supplier <-> drm device
In-Reply-To: <1881012.XPHlTWYXH6@avalon>
References: <20180426223139.16740-1-peda@axentia.se>
 <1881012.XPHlTWYXH6@avalon>
Message-ID: <20180430151803.GN12521@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 01:40:21AM +0300, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patches.
> 
> On Friday, 27 April 2018 01:31:15 EEST Peter Rosin wrote:
> > Hi!
> > 
> > It was noted by Russel King [1] that bridges (not using components)
> > might disappear unexpectedly if the owner of the bridge was unbound.
> > Jyri Sarha had previously noted the same thing with panels [2]. Jyri
> > came up with using device links to resolve the panel issue, which
> > was also my (independent) reaction to the note from Russel.
> > 
> > This series builds up to the addition of that link in the last
> > patch, but in my opinion the other 23 patches do have merit on their
> > own.
> > 
> > The last patch needs testing, while the others look trivial. That
> > said, I might have missed some subtlety.
> 
> I don't think this is the way to go. We have a real lifetime management 
> problem with bridges, and device links are just trying to hide the problem 
> under the carpet. They will further corner us by making a real fix much more 
> difficult to implement. I'll try to comment further in the next few days on 
> what I think a better solution would be, but in a nutshell I believe that 
> drm_bridge objects need to be refcounted, with a .release() operation to free 
> the bridge resources when the reference count drops to zero. This shouldn't be 
> difficult to implement and I'm willing to help.

I agree that refcounting is the proper fix if bridges can be
hot-unplugged, independently of the overall drm_device.

And yes retro-shoehorning refcounting is "fun", but it's also not
impossible. I've done it a few times by now in drm.

Otoh, refcounting has a pretty serious cost - we're still blowing up
drm_framebuffer refcounting in corner cases at shocking regularity, and
that's something that's been refcounted for years by now. As long as we
don't have a clearly defined need to make bridges hotpluggable then I
think not paying the hefty bill just yet is the correct technical
decision. This patch series here looks like a reasonable way to tie the
lifetimes together a bit more closely and should fix the bugs we have
right now.

Cheers, Daniel

PS: Yes there's cases where you can hotplug display blocks on a SoC. To my
knowledge they're all covered by hotplugging the entire drm_device (plus
all the statically associated bits like drm_bridge/crtc/plane/encoder).
And we're already working on fixing up drm_device to at least make it
possible to write a correct hot-unpluggable driver in theory. We'll see
whether anyone manages to pull that off in practice :-)

> 
> > [1] https://lkml.org/lkml/2018/4/23/769
> > [2] https://www.spinics.net/lists/dri-devel/msg174275.html
> > 
> > Peter Rosin (24):
> >   drm/bridge: allow optionally specifying an .owner device
> >   drm/bridge: adv7511: provide an .owner device
> >   drm/bridge/analogix: core: specify the .owner of the bridge
> >   drm/bridge: analogix-anx78xx: provide an .owner device
> >   drm/bridge: vga-dac: provide an .owner device
> >   drm/bridge: lvds-encoder: provide an .owner device
> >   drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an .owner device
> >   drm/bridge: nxp-ptn3460: provide an .owner device
> >   drm/bridge: panel: provide an .owner device
> >   drm/bridge: ps8622: provide an .owner device
> >   drm/bridge: sii902x: provide an .owner device
> >   drm/bridge: sii9234: provide an .owner device
> >   drm/bridge: sii8620: provide an .owner device
> >   drm/bridge: synopsys: provide an .owner device for the bridges
> >   drm/bridge: tc358767: provide an .owner device
> >   drm/bridge: ti-tfp410: provide an .owner device
> >   drm/exynos: mic: provide an .owner device for the bridge
> >   drm/mediatek: hdmi: provide an .owner device for the bridge
> >   drm/msm: specify the .owner of the bridges
> >   drm/rcar-du: lvds: provide an .owner device for the bridge
> >   drm/sti: provide an .owner device for the bridges
> >   drm/bridge: remove the .of_node member
> >   drm/bridge: require the .owner to be filled in on drm_bridge_attach
> >   drm/bridge: establish a link between the bridge supplier and consumer
> > 
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
> >  drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
> >  drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
> >  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
> >  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
> >  drivers/gpu/drm/bridge/panel.c                     |  4 +---
> >  drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
> >  drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
> >  drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
> >  drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
> >  drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
> >  drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
> >  drivers/gpu/drm/drm_bridge.c                       | 23 ++++++++++++++++++-
> >  drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
> >  drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
> >  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
> >  drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
> >  drivers/gpu/drm/sti/sti_hda.c                      |  1 +
> >  drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
> >  include/drm/drm_bridge.h                           |  8 ++++----
> >  27 files changed, 51 insertions(+), 33 deletions(-)
> 
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
