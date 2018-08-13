From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 13 Aug 2018 16:29:12 +0900
Subject: [PATCH] drm/rockchip: update cursors asynchronously through
 atomic.
In-Reply-To: <1889320.MtRaPYoaVN@phil>
References: <20180806155339.9473-1-enric.balletbo@collabora.com>
 <CAAFQd5CGhkfTRzSdTqtFh4zuQuFH0H5SVyKWtk98Ceh_izo4=A@mail.gmail.com>
 <1889320.MtRaPYoaVN@phil>
Message-ID: <CAAFQd5B-TN7G_UBXMEExnFQT0RtSRMxF5baV98Bj8mdzMVBLvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 4:26 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 13. August 2018, 09:11:07 CEST schrieb Tomasz Figa:
> > Hi Enric,
> >
> > On Tue, Aug 7, 2018 at 12:53 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Add support to async updates of cursors by using the new atomic
> > > interface for that.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > Hi,
> > >
> > > This first version is slightly different from the RFC, note that I did
> > > not maintain the Sean reviewed tag for that reason. With this version I
> > > don't touch the atomic_update function and all is implemented in the
> > > async_check/update functions. See the changelog for a list of changes.
> > >
> > > The patch was tested on a Samsung Chromebook Plus in two ways.
> > >
> > >  1. Running all igt kms_cursor_legacy and kms_atomic at plane_cursor_legacy
> > >     tests and see that there is no regression after the patch.
> > >
> > >  2. Running weston using the atomic API.
> >
> > Thanks for the patch. This feature might look like a really minor
> > thing, but we really had hard time dealing with users complaints, so
> > having this in upstream would be a really useful thing.
> >
> > Let me post some comments inline.
> >
> > >
> > > Best regards,
> > >   Enric
> > >
> > > Changes in v1:
> > > - Rebased on top of drm-misc
> > > - In async_check call drm_atomic_helper_check_plane_state to check that
> > >   the desired plane is valid and update various bits of derived state
> > >   (clipped coordinates etc.)
> > > - In async_check allow to configure new scaling in the fast path.
> > > - In async_update force to flush all registered PSR encoders.
> > > - In async_update call atomic_update directly.
> > > - In async_update call vop_cfg_done needed to set the vop registers and take effect.
> > >
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 53 +++++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index e9f91278137d..dab70056ee73 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > @@ -811,10 +811,63 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> > >         spin_unlock(&vop->reg_lock);
> > >  }
> > >
> > > +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> > > +                                       struct drm_plane_state *state)
> > > +{
> > > +       struct vop_win *vop_win = to_vop_win(plane);
> > > +       const struct vop_win_data *win = vop_win->data;
> > > +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
> > > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > > +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
> > > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > > +       int ret;
> > > +
> > > +       if (plane != state->crtc->cursor)
> > > +               return -EINVAL;
> > > +
> > > +       if (!plane->state)
> > > +               return -EINVAL;
> > > +
> > > +       if (!plane->state->fb ||
> > > +           plane->state->fb != state->fb)
> > > +               return -EINVAL;
> >
> > While it covers for quite a big part of cursor movements, you may
> > still expect jumpy cursor when hoovering text boxes or hyperlinks,
> > since it changes the cursor image. Our downstream patch [1] actually
> > took care of changing the framebuffer as well, although with the added
> > complexity of referencing the old buffer at update time and releasing
> > it in a flip work.
> >
> > [1] https://chromium.git.corp.google.com/chromiumos/third_party/kernel/+/1ad887e1a1349991c9e137b48cb32086e65347fc%5E%21/
>
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/394492
> for non-google people ;-)
>

Thanks, not sure how that internal link sneaked into my clipboard.
Should have checked what I pasted. :P

Best regards,
Tomasz
