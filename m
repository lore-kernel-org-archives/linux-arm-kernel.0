From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Jun 2013 20:06:12 +0100
Subject: [RFC v2 0/8] rmk's Dove DRM/TDA19988 Cubox driver
Message-ID: <20130609190612.GM18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of my DRM driver.  Changes since the previous version:

1. It's now called Armada not Dove, because the "LCD controllers" aka CRTCs
   are found in Armada 16x as well as Armada 510 Dove.  The Armada 16x is
   preliminary work.

2. Cursor support is now a separate patch.  I've tried several formats,
   and 64x32 ARGB is the one I've settled on for the time being, though
   the driver will permit 32x64 as well.  This, however, is not available
   with Armada 16x hardware.  This patch will be a separate follow-up to
   this.  The reason for this is it's in a separate branch which conflicts
   with this (and my NXP-TDA19988 output driver branch.)  The value of this
   is still questionable due to the restrictions in the hardware meaning
   the entire cursor has to be reloaded near the edge of the screen.

   This also may interfere with the interlaced support; however the DRM
   i2c TDA998x driver seems incapable of supporting interlace at present.
   (It works with the CEA mode number programmed but not if you program
   with mode timings.)

3. A slave encoder output encoder which contains nothing specific to TDA19988
   nor Cubox.  This data is now in the top level driver, and can be provided
   using whatever method is desirable (eg, from DT.)

   What *can't* be done without a rewrite of the DRM slave encoder backend
   is to have the TDA998x I2C device provided by DT.  There are mumblings
   about redoing the slave encoder API, hopefully this will be fixed there.

4. Finished off the page flip support, which now gets used on mode changes
   as well.  Page flip as a whole still isn't tested.

5. Removal of default mode and reporting of unknown connector status.  The
   kernel side will select 1024x768 if no connectors are connected - this
   will cause problems if your display reports that it supports 1024x768
   but it doesn't actually.  Xorg will do similar too.

What is not in this patch set yet, but I have patches for:
1. Pulled the clock stuff out of the armada_crtc.c file into the top level.
   Armada 16x has different clocking options to Armada 510, and certain bits
   in the clock configuration register are different.  This needs to be
   dealt with like we do in AMBA devices with "variant" support.  So in a
   DT environment, we'd have:
	compatible = "marvell,armada510-lcd";
   or
	compatible = "marvell,armada16x-lcd";
   and the driver adjusts according to that.

2. Sebastian's additional patches
