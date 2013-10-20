From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Oct 2013 17:31:56 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131020130057.GN25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
 <20131020000434.GL25034@n2100.arm.linux.org.uk>
 <20131020130057.GN25034@n2100.arm.linux.org.uk>
Message-ID: <20131020163156.GO25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 02:00:57PM +0100, Russell King - ARM Linux wrote:
> As for imx-drm, there was a warning which preceded that oops.  Here's the
> full log, below the "---------" marker - this is from unbinding the imx-drm
> module, and then trying to reboot.
> 
> imx-drm is really very broken in the way it tries to bend DRM to be
> used in DT - it doesn't consider the lifetime for anything like the
> CRTCs, connectors or encoders.  All these have empty .destroy functions
> to them. If we unbind imx-drm, the top level drm_device tries to be
> destroyed, but it leaves behind all the CRTCs, connectors and encoders,
> causing the first warning because none of the framebuffers got cleaned
> up through that destruction (because the functions did nothing.)
> 
> The second one is through trying to clean up the framebuffer, which is
> still in use.
> 
> The third one is caused because there's still allocated memory objects
> against the DRM memory manager - again, because nothing has been cleaned
> up.

Right, so how imx-drm "works" as far as DRM initialization is by a wing
and a prayer at the moment.

It works like this - the driver relies heavily upon this sequence:

- imx_drm_init()
  - creates an imx_drm_device structure to contain references to other
    parts.
  - registers the imx-drm platform device and an associated structure.
    - the platform device is immediately probed, causing it to be registered
      with the DRM subsystem.
    - the DRM subsystem creates the drm_device structure, and calls the
      drivers ->load method.
    - the driver initialises some basic data, places a pointer to the
      drm_device into the imx_drm_device and returns
- imx_pd_driver_init()
  - registers the imx_pd_driver platform device driver for DT devices
    with a compatible string of "fsl,imx-parallel-display"
  - such devices will be immediately probed
    - these allocate an imx_parallel_display structure, which contains
      a drm_connector and drm_encoder structure embedded within.
    - these structures are registered into the core of imx_drm, and
      via the imx_drm_device structure, are both attached to the
      drm_device immediately.
- imx_tve_driver_init()
  essentially the same as imx_pd_driver_init()
- imx_ldb_driver_init()
  essentially the same as imx_pd_driver_init()
- imx_ipu_driver_init()
  - registers a platform driver fot DT devices with a compatible string
    of "fsl,imx51-ipu", "fsl,imx53-ipu", or "fsl,imx6q-ipu".
  - initialises such devices, and creates two new platform devices
    called "imx-ipuv3-crtc", one for each display interface.
- ipu_drm_driver_init()
  - registers a platform driver for "imx-ipuv3-crtc" devices.
    - for each device found
      - it allocates a ipu_crtc device structure, which embeds a drm_crtc
        structure.
      - it registers a CRTC via imx_drm_add_crtc().
        - this allocates an imx_drm_crtc structure, and eventually registers
          the drm_crtc structure against the drm_device
- imx_hdmi_driver_init
  similar to imx_pd_driver_init

All that sequence is in init level 6.  The last bit comes in init level 7
(the late_initcall):

- imx_fb_helper_init()
  - this grabs the drm_device, and calls drm_fbdev_cma_init() on it
    hoping that we know the number of CRTCs at this point.  This is
    held indefinitely.
  - the resulting drm_fbdev_cma is saved into the imx_drm_device.

Now, if the imx-drm device is unbound from its driver, all hell breaks
loose - none of these crtc/connector/encoder structures have a meaningful
destroy function - their destruction is all in their individual driver
"remove" functions.  This causes some warnings to be spat out from DRM.

Amongst this is the "last_close" callback which looks at the imx_drm_device,
sees that drm_fbdev_cma is registered against it, and calls
drm_fbdev_cma_restore_mode() on it.  drm_fbdev_cma contains objects which
store a pointer to the drm_device structure that it was registered against,
which exists at this point, so everything is fine.

The unload proceeds, and eventually the drm_device is freed.

Now, if we rebind the imx-drm device, causing the probe actions above to
be repeated.  imx_drm_device still contains a pointer to the drm_fbdev_cma
object that was allocated...  Let's ignore the fact that none of the
sub-modules have re-initialised anything against this new drm_device.

The real fun comes when you try and unbind it again.  This time, the
drm_device which is being torn down isn't the one in drm_fbdev_cma,
but we still call drm_fbdev_cma_restore_mode().  This tries to get a
mutex on the _original_ drm_device->mode_config.mutex, which has been
freed.  The result is a kernel oops.

Now, several things stand out here: piece-meal construction of a
drm_device in this manner is unsafe:
- it relies heavily on all devices already being present at the time that
  the above sequence starts, and it assumes that the drivers will probe
  immediately, as soon as they are registered.
- the late_initcall() is really a "barrier" on the initialisation sequence:
  no CRTCs can be registered after that point.
- it is impossible to tear down and re-create the subsystem when the device
  goes wrong as you can never clear out that CMA fbdev helper, even if you
  unbind every other device in that setup in the right order.
- each of these drivers is itself a separate loadable module, which means
  when built in a modular state and loaded under Ubuntu 12.04, which does
  multi-threaded module loading, there is no guarantee of any initialisation
  order.

Really, this kind of hack needs to be outlawed.  Trying to bend a subsystem
which has a fairly solid model around a single "device" into this kind of
multi-device for the sake of DT is really buggered.

This is not an imx-drm specific problem: this the same problem which the
Armada DRM driver would have with DT: DT is based around describing
individual components of hardware separately rather than describing
something at high level.

I've been looking at what can be done with imx-drm.  One thing that
desperately needs sorting is that drm_fbdev_cma thing, which has to be
registered after all CRTCs.  The problem is that there is _no way_ to
positively know when all CRTCs have been registered, because they're
separate devices entirely.

For other stuff, it would require quite an amount of restructuring, so
that sub-modules don't "probe" themselves until the main drm_device is
known to be in place, and clean themselves up in the ->destroy callbacks.
... maybe.  Sorting out the connectors/encoders might actually be the
easier bit of the task, something which I'm currently looking into at
the moment.
