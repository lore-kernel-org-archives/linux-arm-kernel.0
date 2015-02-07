From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 7 Feb 2015 08:39:24 +0100
Subject: [PATCH] drm: atmel-hlcdc: add discard area support
In-Reply-To: <CAF6AEGukjEWb5DK4CKH1si9YEBH8aiuhz78tMiYjg9qLBiNvPA@mail.gmail.com>
References: <1423236662-6782-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150206211147.GF14009@phenom.ffwll.local>
 <CAF6AEGukjEWb5DK4CKH1si9YEBH8aiuhz78tMiYjg9qLBiNvPA@mail.gmail.com>
Message-ID: <20150207083924.3fa4df33@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob, Daniel,

On Fri, 6 Feb 2015 18:32:19 -0500
Rob Clark <robdclark@gmail.com> wrote:

> On Fri, Feb 6, 2015 at 4:11 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Feb 06, 2015 at 04:31:02PM +0100, Boris Brezillon wrote:
> >> The HLCDC IP provides a way to discard a specific area on the primary
> >> plane (in case at least one of the overlay is activated and alpha
> >> blending is disabled).
> >> Doing this will reduce the amount of data to transfer from the main
> >> memory to the Display Controller, and thus alleviate the load on the
> >> memory bus (since this link is quite limited on such hardware,
> >> this kind of optimization is really important).
> >>
> >> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >> ---
> >> Hi Daniel,
> >>
> >> Can you tell me if that's what you had in mind for the discard area feature
> >> we talked about yersterday.
> >>
> >> This patch depends on the Atmel HLCDC Atomic mode-setting conversion
> >> work [1].
> >>
> >> Best Regards,
> >>
> >> Boris
> >>
> >> [1]https://lkml.org/lkml/2015/2/4/658
> >>
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |   2 +-
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |   2 +
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 108 ++++++++++++++++++++++++
> >>  3 files changed, 111 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> >> index de6973d..4fd1683 100644
> >> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> >> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> >> @@ -201,7 +201,7 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
> >>       if (atmel_hlcdc_dc_mode_valid(crtc->dc, &s->adjusted_mode) != MODE_OK)
> >>               return -EINVAL;
> >>
> >> -     return 0;
> >> +     return atmel_hlcdc_plane_prepare_disc_area(s);
> >>  }
> >>
> >>  static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c)
> >> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> >> index 015c3f1..1ea9c2c 100644
> >> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> >> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> >> @@ -148,6 +148,8 @@ int atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
> >>  struct atmel_hlcdc_planes *
> >>  atmel_hlcdc_create_planes(struct drm_device *dev);
> >>
> >> +int atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state);
> >> +
> >>  void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
> >>
> >>  void atmel_hlcdc_crtc_cancel_page_flip(struct drm_crtc *crtc,
> >> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> >> index 6c6fcae..dbf97d9 100644
> >> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> >> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> >> @@ -51,6 +51,13 @@ struct atmel_hlcdc_plane_state {
> >>
> >>       u8 alpha;
> >>
> >> +     bool disc_updated;
> >> +
> >> +     int disc_x;
> >> +     int disc_y;
> >> +     int disc_w;
> >> +     int disc_h;
> >> +
> >>       /* These fields are private and should not be touched */
> >>       int bpp[ATMEL_HLCDC_MAX_PLANES];
> >>       unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
> >> @@ -428,6 +435,104 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
> >>       }
> >>  }
> >>
> >> +int
> >> +atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
> >> +{
> >> +     int disc_x = 0, disc_y = 0, disc_w = 0, disc_h = 0;
> >> +     const struct atmel_hlcdc_layer_cfg_layout *layout;
> >> +     struct atmel_hlcdc_plane_state *primary_state;
> >> +     struct drm_plane_state *primary_s;
> >> +     struct atmel_hlcdc_plane *primary;
> >> +     struct drm_plane *ovl;
> >> +
> >> +     primary = drm_plane_to_atmel_hlcdc_plane(c_state->crtc->primary);
> >> +     layout = &primary->layer.desc->layout;
> >> +     if (!layout->disc_pos || !layout->disc_size)
> >> +             return 0;
> >> +
> >> +     primary_s = drm_atomic_get_plane_state(c_state->state,
> >> +                                            &primary->base);
> >> +     if (IS_ERR(primary_s))
> >> +             return PTR_ERR(primary_s);
> >> +
> >> +     primary_state = drm_plane_state_to_atmel_hlcdc_plane_state(primary_s);
> >> +
> >> +     drm_atomic_crtc_state_for_each_plane(ovl, c_state) {
> >> +             struct atmel_hlcdc_plane_state *ovl_state;
> >> +             struct drm_plane_state *ovl_s;
> >> +
> >> +             if (ovl == c_state->crtc->primary)
> >> +                     continue;
> >> +
> >> +             ovl_s = drm_atomic_get_plane_state(c_state->state, ovl);
> >> +             if (IS_ERR(ovl_s))
> >> +                     return PTR_ERR(ovl_s);
> >> +
> >> +             ovl_state = drm_plane_state_to_atmel_hlcdc_plane_state(ovl_s);
> >
> > Note that right now the atomic helpers do not no-op out null plane state
> > updates. The assumption is that such plane states aren't requested.
> > Usually it's not harmful to add more planes by default (just a bit of
> > busy-work really), but if you have more than 1 crtc then suddenly every
> > pageflip will be converted into an update spanning more than 1 crtc, and
> > you most definitely don't want that. This is because we always must the
> > state for the crtc each plane is connected to. This is also the reason why
> > my speudo-code started from the planes and not the crtc, so that
> > unecessary plane states can be avoided.
> >
> 
> so maybe a:
> 
>   const struct drm_xyz_state * drm_atomic_get_xyz_state_ro(...);
> 
> which does not create new state, if there is not already one, but
> instead just returns the current state for planes that are not being
> changed?
> 
> might need to be a bit careful about state state pointers if someone
> subsequently does drm_atomic_get_xyz_state().. but that shouldn't
> normally be the case in the check phase.  If needed there could be
> some sanity checking to WARN() on drm_atomic_get_xyz_state() after
> drm_atomic_get_xyz_state_ro()


Here is a naive implementation of the drm_atomic_get_ro_plane_state
function.
I don't make any consistency checks and directly return the current
plane state if the next atomic state does not contain any state update
for this plane (which is exactly what I need).

Tell me if you see any problem with this approach (I'm discovering the
atomic APIs, so I might miss some key aspects ;-)).

Best Regards,

Boris

[1]http://code.bulix.org/66rb4z-87845

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
