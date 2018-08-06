From: Alexandru-Cosmin.Gheorghe@arm.com (Alexandru-Cosmin Gheorghe)
Date: Mon, 6 Aug 2018 13:20:38 +0100
Subject: [PATCH v3 00/10] Add helper for plane reset
In-Reply-To: <15977863.ZBGtPEODRU@avalon>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <20180806110727.GA3314@e114479-lin.cambridge.arm.com>
 <15977863.ZBGtPEODRU@avalon>
Message-ID: <20180806122038.GA6755@e114479-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 02:45:42PM +0300, Laurent Pinchart wrote:

Hi Laurent,

> Hi Alex,
> 
> On Monday, 6 August 2018 14:07:27 EEST Alexandru-Cosmin Gheorghe wrote:
> > Hi,
> > 
> > On Sat, Aug 04, 2018 at 05:15:20PM +0100, Alexandru Gheorghe wrote:
> > > No significant change since v2, fixed a spelling mistake and
> > > added/removed some newlines in 01 and 07 patches.
> > > 
> > > I plan to apply the first patch of the series and the patches for
> > > the drivers maintained through drm-misc(that go Reviewed/Ack) in
> > > drm-misc-next on Monday.
> > > 
> > > For the other drivers please let me know if you want me to push them
> > > in drm-misc-next as well.
> > 
> > Pushed the following patch to drm-misc-next:
> > 
> > drm/atomic: Add __drm_atomic_helper_plane_reset
> > drm: mali-dp: Use __drm_atomic_helper_plane_reset instead of copying the
> > logic
> > drm: atmel-hlcdc: Use __drm_atomic_helper_plane_reset instead of copying the
> > logic
> > drm/imx: Use __drm_atomic_helper_plane_reset instead of copying the logic
> > drm/sun4i: Use __drm_atomic_helper_plane_reset instead of copying the logic
> 
> I've acked the rcar-du part, could it be merged with the rest of the code ?
> 

Done, it's in drm-misc-next now. I didn't know how to handle this for
drivers that have their own tree, so I just pushed the patches where I
was explicitly asked.

Thank you,
Alex Gheorghe

> > > Changes since v1:
> > >  - Make __drm_atomic_helper_plane_reset consistent with the other
> > >    helpers and require that both plane and state not be NULL,
> > >    suggested by Boris Brezillon and Philipp Zabel. Drivers already
> > >    check for that.
> > >  
> > >  - Add a proper commit message for driver changes.
> > > 
> > > Drivers that subclass drm_plane need to copy the logic for linking the
> > > drm_plane with its state and to initialize core properties to their
> > > default values. E.g (alpha and rotation)
> > > 
> > > Having a helper to reset the plane_state makes sense because of multiple
> > > reasons:
> > > 1. Eliminate code duplication.
> > > 2. Add a single place for initializing core properties to their
> > > default values, no need for driver to do it if what the helper sets
> > > makes sense for them.
> > > 3. No need to debug the driver when you enable a core property and
> > > observe it doesn't have a proper default value.
> > > 
> > > Tested with mali-dp the other drivers are just built-tested.
> > > 
> > > Alexandru Gheorghe (10):
> > >   drm/atomic: Add  __drm_atomic_helper_plane_reset
> > >   drm/amd/display: Use __drm_atomic_helper_plane_reset instead of
> > >     copying the logic
> > >   drm: mali-dp: Use __drm_atomic_helper_plane_reset instead of copying
> > >     the logic
> > >   drm: atmel-hlcdc: Use __drm_atomic_helper_plane_reset instead of
> > >     copying the logic
> > >   drm/exynos: Use __drm_atomic_helper_plane_reset instead of copying the
> > >     logic
> > >   drm/imx: Use __drm_atomic_helper_plane_reset instead of copying the
> > >     logic
> > >   drm: rcar-du: Use __drm_atomic_helper_plane_reset instead of copying
> > >     the logic
> > >   drm/sun4i: Use __drm_atomic_helper_plane_reset instead of copying the
> > >     logic
> > >   drm/vc4: Use __drm_atomic_helper_plane_reset instead of copying the
> > >     logic
> > >   drm/vmwgfx: Use __drm_atomic_helper_plane_reset instead of copying the
> > >     logic
> > >  
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++--
> > >  drivers/gpu/drm/arm/malidp_planes.c           |  7 ++--
> > >  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  5 +--
> > >  drivers/gpu/drm/drm_atomic_helper.c           | 33 ++++++++++++++-----
> > >  drivers/gpu/drm/exynos/exynos_drm_plane.c     |  3 +-
> > >  drivers/gpu/drm/imx/ipuv3-plane.c             |  8 ++---
> > >  drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  6 ++--
> > >  drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  5 +--
> > >  drivers/gpu/drm/sun4i/sun4i_layer.c           |  4 +--
> > >  drivers/gpu/drm/vc4/vc4_plane.c               |  4 +--
> > >  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |  4 +--
> > >  include/drm/drm_atomic_helper.h               |  2 ++
> > >  12 files changed, 41 insertions(+), 47 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Cheers,
Alex G
