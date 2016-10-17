From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:05 -0700
Subject: [PATCH 4/5] staging/vchi: Add a TODO file of things I know we need to
 deal with.
In-Reply-To: <20161017194406.1080-1-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
Message-ID: <20161017194406.1080-5-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've left out the downstream HDMI audio driver from the "to be
imported" section, as we'll want to handle it natively in vc4.  The
downstream kernel will likely continue to use that driver for a while
due to using the interim "vc4 firmware KMS" mode while vc4 gets its
featureset (such as HDMI audio!) completed.

I've also left out VC-CMA, which appears to be about having Linux
manage a CMA area that the firmware gets to make allocations out of.
I'm not clear on if this is useful (the firmware's need for memory
drops massively with vc4 present, and may drop even more depending on
how we resolve dmabuf handling for camera and video decode)

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchi/TODO | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 drivers/staging/vc04_services/interface/vchi/TODO

diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
new file mode 100644
index 000000000000..03aa65183b25
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchi/TODO
@@ -0,0 +1,50 @@
+1) Port to aarch64
+
+This driver won't be very useful unless we also have it working on
+Raspberry Pi 3.  This requires, at least:
+
+  - Figure out an alternative to the dmac_map_area() hack.
+
+  - Decide what to use instead of dsb().
+
+  - Do something about (int) cast of bulk->data in
+    vchiq_bulk_transfer().
+
+    bulk->data is a bus address going across to the firmware.  We know
+    our bus addresses are <32bit.
+
+2) Write a DT binding doc and get the corresponding DT node merged to
+   bcm2835.
+
+This will let the driver probe when enabled.
+
+3) Import drivers using VCHI.
+
+VCHI is just a tool to let drivers talk to the firmware.  Here are
+some of the ones we want:
+
+  - vc_mem (https://github.com/raspberrypi/linux/blob/rpi-4.4.y/drivers/char/broadcom/vc_mem.c)
+
+  This driver is what the vcdbg userspace program uses to set up its
+  requests to the firmware, which are transmitted across VCHIQ.  vcdbg
+  is really useful for debugging firmware interactions.
+
+  - bcm2835-camera (https://github.com/raspberrypi/linux/tree/rpi-4.4.y/drivers/media/platform/bcm2835)
+
+  This driver will let us get images from the camera using the MMAL
+  protocol over VCHI.
+
+  - VCSM (https://github.com/raspberrypi/linux/tree/rpi-4.4.y/drivers/char/broadcom/vc_sm)
+
+  This driver is used for talking about regions of VC memory across
+  firmware protocols including VCHI.  We'll want to extend this driver
+  to manage these buffers as dmabufs so that we can zero-copy import
+  camera images into vc4 for rendering/display.
+
+4) Garbage-collect unused code
+
+One of the reasons this driver wasn't upstreamed previously was that
+there's a lot code that got built that's probably unnecessary these
+days.  Once we have the set of VCHI-using drivers we want in tree, we
+should be able to do a sweep of the code to see what's left that's
+unused.
-- 
2.9.3
