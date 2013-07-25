From: robdclark@gmail.com (Rob Clark)
Date: Thu, 25 Jul 2013 14:21:59 -0400
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
Message-ID: <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 1:17 PM,  <tom.cooksey@arm.com> wrote:
> From: Tom Cooksey <tom.cooksey@arm.com>
>
> Please find below the current state of our pl111 DRM/KMS driver. This
> is lightly tested on a Versatile Express using X running the
> xf86-video-armsoc DDX driver[i] with the patches applied to drm-next
> as of ~last week. To actually see anything on the DVI output, you
> must also apply Pawel Moll's VExpress DVI mux driver[ii] to select
> the video signal from the ca9x4 core tile.
>
> [i] <https://git.linaro.org/gitweb?p=arm/xorg/driver/xf86-video-armsoc.git;a=summary>
> [ii] <https://patchwork.kernel.org/patch/1765981/>
>
>
> Known issues:
>  * It uses KDS. We intend to switch to whatever implicit per-buffer
>    synchronisation mechanism gets merged, once something is merged.
>  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
>    allocate buffers for the GPU. Still not sure how to resolve this
>    as we don't use DRM for our GPU driver.

any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
once the dma-fence stuff is in place), we'd have gpu-specific drm
(gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
using prime/dmabuf to share between the two.

>  * Doesn't handle page flip event sequence numbers and timestamps
>  * The v_sync handling needs work in general - a work queue is a
>    little overkill
>  * Doesn't support the import half of PRIME properly, only export
>  * Need to validate src rectangle size in
>    pl111_drm_cursor_plane_update()
>  * Only supports 640x480 mode, which is hard-coded. We intend to
>    rebase on top of CDF once it is merged, which hopefully will
>    handle a lot of the EDID parsing & mode setting for us (once
>    Pawel's CDF patches for VExpress also land).

note that drm core already handles EDID parsing quite nicely.. I'm not
entirely sure why CDF would be needed for this?

>
> I appreciate that's a fairly hefty list of known issues already!
> However, we're waiting for both CDF & dma_buf sync mechanisms to land
> before we can address some of those. So in the mean-time, I thought
> someone might be interested in taking a look at what we have so far,
> which is why I'm posting this now. Needless to say the code will need
> to be refactored a fair bit, however I'm keen to get and additional
> feedback anyone cares to give.
>

What is the dependency on CDF?  Is there an external encoder/bridge
that could be shared between platforms?

btw, I think that having some share-able KMS objects is a good idea.
I'm not entirely sure that the directions that the current CDF
proposals are headed is necessarily the right way forward.  I'd prefer
to see small/incremental evolution of KMS (ie. add drm_bridge and
drm_panel, and refactor the existing encoder-slave).  Keeping it
inside drm means that we can evolve it more easily, and avoid layers
of glue code for no good reason.

BR,
-R


>
> Cheers,
>
> Tom
>
> Tom Cooksey (1):
>   drm/pl111: Initial drm/kms driver for pl111 display controller
>
>  drivers/gpu/drm/Kconfig                     |    2 +
>  drivers/gpu/drm/Makefile                    |    1 +
>  drivers/gpu/drm/pl111/Kbuild                |   14 +
>  drivers/gpu/drm/pl111/Kconfig               |    9 +
>  drivers/gpu/drm/pl111/pl111_clcd_ext.h      |   78 ++++
>  drivers/gpu/drm/pl111/pl111_drm.h           |  227 ++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_connector.c |  166 +++++++++
>  drivers/gpu/drm/pl111/pl111_drm_crtc.c      |  432 ++++++++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_cursor.c    |   97 +++++
>  drivers/gpu/drm/pl111/pl111_drm_device.c    |  319 +++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_dma_buf.c   |  339 ++++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_encoder.c   |  106 ++++++
>  drivers/gpu/drm/pl111/pl111_drm_fb.c        |  152 ++++++++
>  drivers/gpu/drm/pl111/pl111_drm_funcs.h     |  127 +++++++
>  drivers/gpu/drm/pl111/pl111_drm_gem.c       |  287 +++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_pl111.c     |  513 +++++++++++++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_drm_platform.c  |  150 ++++++++
>  drivers/gpu/drm/pl111/pl111_drm_suspend.c   |   35 ++
>  drivers/gpu/drm/pl111/pl111_drm_vma.c       |  214 +++++++++++
>  19 files changed, 3268 insertions(+)
>  create mode 100644 drivers/gpu/drm/pl111/Kbuild
>  create mode 100644 drivers/gpu/drm/pl111/Kconfig
>  create mode 100644 drivers/gpu/drm/pl111/pl111_clcd_ext.h
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm.h
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_connector.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_crtc.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_cursor.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_device.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_dma_buf.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_encoder.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_fb.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_funcs.h
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_gem.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_pl111.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_platform.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_suspend.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_drm_vma.c
>
> --
> 1.7.9.5
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
