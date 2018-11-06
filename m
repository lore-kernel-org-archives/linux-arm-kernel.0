From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 6 Nov 2018 12:13:10 +0100
Subject: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane
 scaling
In-Reply-To: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20181106111310.GP21967@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 10:39:59AM +0100, Neil Armstrong wrote:
> This serie adds support for :
> - Overlay Plane blended with the primary plane, we can describe as "behind"
> - Primary Plane up-scaling up to 5x factor to support the OSD plane being
>   upscaled from 1920x1080 when the display mode is set as 3840x2160.
> 
> These patches depends on the "drm/meson: Allow using optional canvas provider"
> patchset from Maxime Jourdan at [1]
> 
> [1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355
> 
> Neil Armstrong (3):
>   drm/meson: Support Overlay plane for video rendering
>   drm/meson: move OSD scaler management into plane atomic update
>   drm/meson: Add primary plane scaling

Got bored, read a bit your patch series. Two things I've noticed:
- We need to drop the crtc_state argument from
  drm_atomic_helper_check_plane_state(), some drivers (not meson) do
  really funny stuff with this.

- I think your osd1_commit = true update is racy with the interrupt
  handler checking it. Needs at least a few memory barriers. Since helpers
  guarantee that you can't overtake a preceending update (you do the
  vblank handling after the updating) that should be ok, except you arm
  the vblank before setting up registers, so this might race too.

Anyway all unrelated, so feel free to smash an

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

on the entire series.

Cheers, Daniel

> 
>  drivers/gpu/drm/meson/Makefile          |   2 +-
>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>  drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>  drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>  drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>  drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
>  12 files changed, 1156 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
