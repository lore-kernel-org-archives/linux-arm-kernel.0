From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Oct 2016 16:57:51 +0200
Subject: [RFC PATCH 0/5] Add an overlay manager to handle board capes
Message-ID: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Many boards now come with dips and compatible capes; among others the
C.H.I.P, or Beaglebones. All these boards have a kernel implementing an
out-of-tree "cape manager" which is used to detected capes, retrieve
their description and apply a corresponding overlay. This series is an
attempt to start a discussion, with an implementation of such a manager
which is somehow generic (i.e. formats or cape detectors can be added).
Other use cases could make use of this manager to dynamically load dt
overlays based on some input / hw presence.

The proposed design is a library which can be used by detector drivers
to parse headers and load the corresponding overlay. Helpers are
provided for this purpose. The whole thing is divided into 3 entities:

- The parser which is project-specific (to allow supporting headers
  already into the wild). It registers a function parsing an header's
  data and filling one or more strings which will be used to find
  matching dtbo on the fs.

- The overlay manager helpers allowing to parse a header to retrieve
  the previously mentioned strings and to load a compatible overlay.

- The detectors which are used to detect capes and get their description
  (to be parsed).

An example of parser and detector is given, compatible with what's done
for the C.H.I.P. As the w1 framework is really bad (and we should
probably do something about that) the detector code is far from being
perfect; but that's not related to what we try to achieve here.

The actual implementation has a limitation: the detectors cannot be
built-in the kernel image as they would likely detect capes at boot time
but will fail to get their corresponding dt overlays as the fs isn't
mounted yet. The only case this can work is when dt overlays are
built-in firmwares. This isn't an issue for the C.H.I.P. use case right
now. There was a discussion about making an helper to wait for the
rootfs to be mount but the answer was "this is the driver's problem".

I'd like to get comments, specifically from people using custom cape
managers, to see if this could fill their needs (with I guess some
modifications).

Thanks!

Antoine

Antoine Tenart (5):
  of: introduce the overlay manager
  of: overlay-mgr: add the CHIP format
  w1: report errors returned by w1_family_notify
  w1: add a callback to call slave when a new device is connected
  of: overlay-mgr: add a detector for headers stored on a ds2431 eeprom
    over w1

 drivers/of/Kconfig                           |   2 +
 drivers/of/Makefile                          |   1 +
 drivers/of/overlay-manager/Kconfig           |  29 ++++
 drivers/of/overlay-manager/Makefile          |   2 +
 drivers/of/overlay-manager/format-chip.c     |  72 ++++++++++
 drivers/of/overlay-manager/overlay-manager.c | 199 +++++++++++++++++++++++++++
 drivers/w1/slaves/w1_ds2431.c                |  39 ++++++
 drivers/w1/w1.c                              |  14 +-
 drivers/w1/w1_family.h                       |   2 +
 include/linux/overlay-manager.h              |  51 +++++++
 10 files changed, 410 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/overlay-manager/Kconfig
 create mode 100644 drivers/of/overlay-manager/Makefile
 create mode 100644 drivers/of/overlay-manager/format-chip.c
 create mode 100644 drivers/of/overlay-manager/overlay-manager.c
 create mode 100644 include/linux/overlay-manager.h

-- 
2.10.1
