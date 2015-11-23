From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 16:02:11 +0000
Subject: [PATCH 0/4] Component helper updates
Message-ID: <20151123160210.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

These four patches update the component helper by:
* Removing the legacy matching code with the .add_components method
  in the master's operation structure.  Nothing in -rc1 appears to be
  using the legacy functions or method, according to my git greps.

* A slight code reorganisation which results in slightly easier to read
  code.

* Switch to tracking components via an array rather than a list, which
  allows us to keep the matching and matched components together, and
  more importantly allows us to reduce the amount of matching - with
  this structure, we can incrementally add the component devices as
  they become available, rather than re-running the list of matches
  each time something changes.

* Fix the lack of match release functionality, which Liviu Dudau
  reminded me was missing.  This allows people who want to pass
  device_node structures in to (correctly) retain the reference to the
  node, and drop the node when the need to do matches is no longer
  required.

The first three patches have been well tested over the last year as I've
had them in my tree that long.  I hadn't considered them important enough
to send as they're only removing and cleaning up functionality.  However,
with the need to fix something, it now makes sense to get them merged.

The last patch has been tested with etnaviv DRM to prove that the match
release works by unloading the module.  On unload, the release function
is correctly called.

This is intended for the next merge window.  Please apply.

 drivers/base/component.c  | 281 ++++++++++++++++++++++++----------------------
 include/linux/component.h |  33 ++++--
 2 files changed, 167 insertions(+), 147 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
