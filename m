From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Jun 2013 23:52:10 +0100
Subject: [PATCH RFC v4 0/3] Armada DRM driver
Message-ID: <20130629225210.GF3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a number of things has changed since the last revision in the
core code - notably the move to use drm_plane for overlay, and the
limited and restricted use of dma_buf so that gem objects can be
passed to the GALCORE code and libbmm contiguous video frames can
be imported into DRM.

As I thought, this does require quite a number of new system calls,
but the case which I care more about (vlc) doesn't pass rendered
frames directly to the X server by physical address, it's not
something I'm particularly concerned about - for vlc and the "normal"
Xv protocol we can cache four DRM gem objects with their framebuffers
pre-prepared meaning we just copy the frame and call the DRM set_plane
function.

What the loss of the create_phys() interface does mean is that the
modified gstreamer gstbmmxvimagesink plugin will not work; it will
need to be updated.  I do *not* intend to support the hacky
bidirectional Xv SHM hack which Marvell came up with there!

I've left out the TDA998x changes and the final patch which depends
on those changes which add the HDMI output for the cubox, so this
series will be lacking the final parts of connector support.  It is
probable that the patch from the previous series can be trivially
applied to this (or easily adapted if not.)

Other changes:
- the crtc exports a few attributes now for setting the colour
  transform mode.  (CCIR601/709 to Computer vs "Studio" RGB).
  An automatic mode for these settings provided depending on selected
  resolution.
- overlay has working brightness/contrast/saturation settings, but
  not hue - not worked that bit out yet.
- hardware ARGB cursor support only in this version.
- backend ops are now called variants, because the structure started
  to contain other stuff other than just function pointers.  Armada510
  backend moved to a separate file.
- features requiring the SPU_ADV_REG (only present on Armada 510)
  can be disabled by the variant structure - such as interlace and
  ARGB cursor.
- use of page_alloc() reduced down to 8K, enough to store the hardware
  cursor.  This is all that that allocation was really used for anyway.
- now uses a common kfifo queue to free used framebuffers at the
  appropriate time, both from the crtc code and the drm_plane code,
  rather than having this logic in several places.  kfifo is a weird
  API and there's a note in the driver about that.
- framebuffers now carry their configuration with them, to save having
  the pixel format decode scattered in several places in the driver.
- power down FIFOs and RAMs not being used, and keep them powered down
  where possible.
- minimum framebuffer size added, moved out from the X server driver.
- maximum horizontal resolution dropped to 1920 to avoid a potential
  problem with V scaling (the RAM is apparantly 1920 pixels by 3 lines.)
- protection preventing various gem objects being used in unexpected
  ways added - eg, you can't create a framebuffer from a cursor gem
  object or an imported object which is non-contiguous.
- full range of colorkey modes for video supported (hey, it's just
  drm plane properties!)
- loads of smaller cleanups, and a number of checkpatch fixes.

Things left to do, in no particular order:
- Creation of planar YUV formatted framebuffers - I suspect the planar
  YUV formats are not supported for graphic framebuffers even though
  Marvell document the register settings.  (Where do you program the
  base addresses of the U and V planes?)  Not a high priority as Vmeta
  produces UYVY encoded frames and it's more efficient to keep the
  native format.
- Gamma support if anyone cares.  Again, not high priority.
- Resolution of the clocking conundrum.
- Resolution of the DT specification conundrum (super-device?)
- Specification of DRM connectors (DT but how?), their configuration,
  what they're connected to and what fixed format(s) they support.
- CMA or no CMA - I've added a comment pointing out additional concerns
  about how to get the physical address from CMA.  I think for most
  platforms this driver will be used on, the device address and physical
  address will be the same, but _conceptually_ they have never been the
  same in the kernel.
- DCON support... I have no use for this, and the information in my
  documentation is pretty damned poor, so much so that I'm reluctant to
  try prodding around with it, especially as some of it is
  self-contradictory.  Anyone who really cares about this can look at
  the issues there.

Stuff omitted:
- the DRM refcounting bug fix which breaks the i915 driver (but without
  it, booting with this driver results in a leaked refcount on the
  framebuffer thanks what I consider to be a bug in the DRM crtc code.)
  So don't boot this without something reporting itself as being
  connected with a valid mode.
