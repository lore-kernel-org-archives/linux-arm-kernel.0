From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 23:47:32 +0100
Subject: [RFC v3 0/4] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130609190612.GM18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
Message-ID: <20130610224732.GD18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, so the previous set didn't contain all the updates I wanted.
That's partly because of the timespan between making those changes
and re-posting the RFC.

This time, the "Add Armada DRM driver" commit contains all the
updates it should've had from last time!

However, I'm posting a slightly different branch - it's rooted at
the same "Add Armada DRM driver" commit so take patch 1 from this
as an update to patch 2 of the previous series.

This looks like:
+  DRM: Armada: Add Armada DRM driver
|\
+ | drm/i2c: nxp-tda998x patches
+ | DRM: Armada: add support for drm tda19988 driver
  + DRM: Armada: Add support for hardware cursors
  + DRM: Armada: convert Armada hardware cursor support to RGB+transparency
  + DRM: Armada: convert hardware cursor support to 64x32 or 32x64 ARGB

Now, the three additional patches where incrementally add hardware
cursor support; first my original version.  This didn't work very well.
Next is my try with the RGB+transparency suggested in the first RFC
round.  The cursor image looked silly against some windows because
you can't sanely translate an alpha channel to transparency.

The last version is what I'm using, and I _am_ using hardware cursors.
This seems to be the best solution if we're going to have hardware
cursors, even though it means that we don't support 64x64 cursors.

For the first patch (the main large patch) the changes are as per my
reply to the previous review comments confirming the updates, and
a couple of other changes which should've been in the previous RFC:

1. if we map a gem object in kernel space, store its kernel space
   address.  This avoids use of phys_to_virt() in the cursor code
   which really wasn't nice.
2. initial variant-based clocking support to support non-Dove
   implementations.
