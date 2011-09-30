From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Sep 2011 17:56:39 +0100
Subject: [RFC PATCH 0/3] ARM: amba: defining module aliases for AMBA driver
	autoloading
Message-ID: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no special reason why AMBA device drivers should not be
auto-loadable via udev, but udev currently has no way to map AMBA
device IDs to drivers.

As part of the effort to help enable the building of multiple
platforms into a single kernel image in the future, it's desirable
to be able to build any non-critical platform-specific drivers as
modules.


A straightforward solution is to use modaliases to allow udev to
identify the correct driver module to load.

This series adds the needed MODALIAS uevent property when sending
events concerning amba bus devices, and adds appropriate
MODULE_ALIAS() declarations to a couple of modules.

Briefly tested on Versatile Express.

Any comments and feedback are welcome.


Issues:

  * Do new module alises need to be globally agreed/registered
    somewhere?

  * Because a driver's ID table is in match-and-mask format whereas
    udev uses string pattern matching, we effectively have to
    maintain two ID tables per driver, containing the same
    information in different formats.  The patch to mmci.c gives an
    example.

    I predict that maintenance of those duplicated tables will be
    somewhat painful and error-prone.  However, the necessary
    transformations, while simple, are beyond the scope of the C
    preprocessor.

    In order to avoid this duplication of information, an extra
    (but simple) bit of build-time infrastructure would be needed.

    I think this effort would be worth it -- does anyone have
    strong views on this?

Dave Martin (3):
  ARM: amba: pass a suitable modalias to udev
  ARM: sound/arm/aaci.c: Define amba module alias
  ARM: drivers/mmc/host/mmci.c: Define amba module alias

 drivers/amba/bus.c      |    9 ++++++++-
 drivers/mmc/host/mmci.c |    8 ++++++++
 sound/arm/aaci.c        |    2 ++
 3 files changed, 18 insertions(+), 1 deletions(-)

--
1.7.4.1
