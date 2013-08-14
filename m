From: tom.cooksey@arm.com (Tom Cooksey)
Date: Wed, 14 Aug 2013 16:01:42 +0100
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <CAF6AEGsmvtwBKMhp3b3Z3M0B2Xi9HXApQ+0c2_prDST1QrL8Xw@mail.gmail.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>	<CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>	<51f29ccd.f014b40a.34cc.ffffca2aSMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGvFPGueM_LHVij9KFzM6NJySHCzmaLstuzZkK5GwP+6gQ@mail.gmail.com>	<51ffdc7e.06b8b40a.2cc8.0fe0SMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGsyKk_G-R-OX_YcgYFDgTEmCy9Vf2LV1pAOV0452QKSww@mail.gmail.com>	<5200deb3.0b24b40a.3b26.ffffbadeSMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGvXcpTKrTjhvrycLqab6F9QP5fAk0ZEWxJ-WvE==PiPsA@mail.gmail.com>	<52010257.245fc20a.6ff8.1cfdSMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGsDA8qdShWdYQRqQ0Czn4mLAe-FoADjZdRFcbeWGGe8Hg@mail.gmail.com>	<52013482.e107c20a.27f9.ffffa718SMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGtaYJfJ4WBddbtyE9P8odXOYvJXLsreMwXMLCBOsfXy7w@mail.gmail.com>	<520284d6.07300f0a.72a4.1623SMTPIN_ADDED_BROKEN@mx.google.com>	<CAF6AEGtq-azZAxD+2OKz=Tg48bYAphBqGn033iWVZ-DjHA216A@mail.gmail.com>	<520515b9.87370f0a.16e6.2380SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAF6AEG
 smvtwBKMhp3b3Z3M0B2Xi9HXApQ+0c2_prDST1QrL8Xw@mail.gmail.com>
Message-ID: <000a01ce98ff$30356090$90a021b0$@cooksey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > Turning to DRM/KMS, it seems the supported formats of a plane 
> >> > can be queried using drm_mode_get_plane. However, there doesn't 
> >> > seem to be a way to query the supported formats of a crtc? If 
> >> > display HW only supports scanning out from a single buffer 
> >> > (like pl111 does), I think it won't have any planes and a fb can 
> >> > only be set on the crtc. In which case, how should user-space 
> > >> query which pixel formats that crtc supports?
> >>
> >> it is exposed for drm plane's.  What is missing is to expose the
> >> primary-plane associated with the crtc.
> >
> > Cool - so a patch which adds a way to query the what formats a crtc
> > supports would be welcome?
> 
> well, I kinda think we want something that exposes the "primary plane"
> of the crtc.. I'm thinking something roughly like:
> 
> ---------
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 53db7ce..c7ffca8 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -157,6 +157,12 @@ struct drm_mode_get_plane {
>  struct drm_mode_get_plane_res {
>  	__u64 plane_id_ptr;
>  	__u32 count_planes;
> +	/* The primary planes are in matching order to crtc_id_ptr in
> +	 * drm_mode_card_res (and same length).  For crtc_id[n], it's
> +	 * primary plane is given by primary_plane_id[n].
> +	 */
> +	__u32 count_primary_planes;
> +	__u64 primary_plane_id_ptr;
>  };

Yup - I think that works and allows userspace to query the supported
formats of the crtc. Great!


<SNIP>

> which is why you want to let userspace figure out the pitch and then
> tell the display driver what size it wants, rather than using dumb
> buffer ioctl ;-)
> 
> Ok, you could have a generic TELL_ME_WHAT_STRIDE_TO_USE ioctl or
> property or what have you.. but I think that would be hard to get
> right for all cases, and most people don't really care about that
> because they already need a gpu/display specific xorg driver and/or
> gl/egl talking to their kernel driver.  You are in a slightly special
> case, since you are providing GL driver independently of the display
> driver.  But I think that is easier to handle by just telling your
> customers "here, fill out this function(s) to allocate buffer for
> scanout" (and, well, I guess you'd need one to query for
> pitch/stride), rather than trying to cram everything into the kernel.

I fear we're going round in circles here, so time to step back a sec.

My first goal is to figure out how to solve our immediate problem of
how to allocate buffers in our DDX which doesn't abuse the dumb buffer
interface. As stated at the start of this thread, we need to allocate
two types of buffers:

1) Those which will be shared between GPU & Display. These must be
allocated in such a way as to satisfy both devices' constraints.

2) Those which will only be used by the GPU (DRI2 buffers, pixmaps
which have been imported into a client's EGL, etc.)

It must be possible to obtain handles to both those types of buffers
in a single DRM/GEM name-space to allow us to implement DRI2.


I think we can satisfy the first buffer type by adjusting the display
DRM's dumb buffer alloc function to always allocate buffers which also
satisfy the GPU's constraints. In pl111_drm, that means all buffers
are allocated with a 64-byte stride alignment, even on SoCs without a
GPU. Not a big issue really and if it were we could make it a Kconfig
option or something.

>From what I have now understood, allocating GPU-only buffers should
be done with a device-specific ioctl. We then have a choice about
which DRM driver we should add that device-specific ioctl to. We could
either add it to the display controller's DRM or we could add it to
the GPU's DRM.

Adding it to the GPU's DRM requires user-space to jump through quite
a lot of hoops: In order to get both the scan-out GEM buffers and DRI2
GEM buffers in a single device's name-space, it would have to use
PRIME to export, say dumb scan-out buffers from the display's DRM as
dma_buf fds, then import those dma_buf fds into the GPU's DRM and then
use flink to give those imported scan-out buffers a name in the GPU's
DRM's namespace. Yuck.

No, I think it is easier to just add allocating GPU DRI2 buffers as
a device-specific ioctl on the display controller's DRM. Indeed, this	
appears to be what OMAP and Exynos DRM drivers (and maybe others) do.
One device does all the allocations and thus all buffers are already
in the same namespace, no faffing with exporting & importing buffers
in the DDX required.

We will need to figure out a way in the xf86-video-armsoc DDX to
abstract those driver-specific allocation ioctls. Using GBM is an
interesting idea - looking at the interface it seems to be very,
_very_ similar to Android's gralloc! Though I don't see how to get
a system-wide name for a buffer I can pass back to a client via DRI2?
I assume gbm_bo_handle is process-local? In the short term, I think
we'll just use run-time detection of the underlying DRM and bake
knowledge of specific DRMs into the DDX.


Anyway, I think we have a conclusion on the "how to allocate buffers
for the X.Org/DRI stack" question. However, there are more advanced
use-cases like streaming from v4l2 to DRM for which I remain convinced
the current allocation model really doesn't work for. Or at a minimum 
causes significant code duplication in many DRM drivers and forces 
lots of per-SoC code in userspace which could otherwise be avoided.
However, I'm keen to not go round in any more circles on this mail
thread and suggest we defer that conversation to Linux Plumbers. :-)



Cheers,

Tom
