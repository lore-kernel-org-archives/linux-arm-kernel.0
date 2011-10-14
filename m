From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 14 Oct 2011 11:04:49 +0100
Subject: [PATCH 0/2] ARM: amba: Enable module alias autogeneration for AMBA
	drivers
Message-ID: <1318586691-3833-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[This is a partial repost of a series previously posted to alkml.

This post contains the core changes.  The driver-specific changes
can be found on alkml.]

 --

There's no special reason why AMBA device drivers should not be
auto-loadable via udev, but udev currently has no way to map AMBA
device IDs to drivers.

As part of the effort to help enable the building of multiple
ARM platforms into a single kernel image in the future, it's desirable
to be able to build any non-critical platform-specific drivers as
modules.

A straightforward solution is to use modaliases to allow udev to
identify the correct driver module to load.

This series enables the general infrastructure for modalias generation
to work for AMBA devices, and enables it in the affected drivers.

Briefly tested on Versatile Express, including aaci, mmci and amba-clcd
(which appears to have the most interesting modalias match pattern).
For me, the appropiate modules now get loaded at udev trigger time.

Any comments and feedback are welcome.

Dave Martin (2):
  ARM: amba: Move definition of struct amba_id to mod_devicetable.h
  ARM: amba: Auto-generate AMBA driver module aliases during modpost

 drivers/amba/bus.c              |    9 ++++-
 include/linux/amba/bus.h        |    7 +---
 include/linux/mod_devicetable.h |   18 ++++++++++
 scripts/mod/file2alias.c        |   72 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 7 deletions(-)

-- 
1.7.4.1
