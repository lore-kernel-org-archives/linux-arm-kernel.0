From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 14 May 2010 18:01:33 +0300
Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
Message-ID: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The main purpose of this patch series is to be able to compile mach platform
data as built-in. Otherwise, client modules such as bridgedriver will load the
platform code, but not the mach code when mailbox is built as a module.

Unfortunately, there's no easy way to do that since plat and mach code are
deepely interrelated. So the first patches try to separate the mailbox
registering through a defined omap_mbox_platform_data.

Also, it's worth noting that mailboxes are not a one-to-one mapping to
resources; that is, some resources belong to multiple mboxes. So it's best to
think of mailboxes as fake devices. That is why custom platform_data is required.

Finally, a bunch of cleaning up is done in the very first patches, specially for
OMAP1.

The initial RFC included comments from Felipe Balbi, and this proposal includes
comments from Tony Lindgren.

v2:
 * Rebased on top of Hiroshi's v2.6.34-rc7.mailbox
 * A bit more extra cleanups

v1 was tested on OMAP3 (beagleboard), and compiled-tested for OMAP1.
v2 was compile-tested for OMAP3 and 1.

Felipe Contreras (17):
  omap: mailbox: trivial whitespace cleanups
  omap: mailbox: trivial cleanups
  omap: mailbox: reorganize structures
  omap: mailbox: 2420 should be detected at run-time
  omap: mailbox: use correct config for omap1
  omap: mailbox: update omap1 probing
  omap: mailbox: reorganize registering
  omap: mailbox: only compile for configured archs
  omap: mailbox: reorganize omap platform_device
  omap: mailbox: move more stuff to omap_mbox_init()
  omap: mailbox: trivial sync between omap1 and 2
  omap: mailbox: split platform driver
  omap: mailbox: always built-in platform data
  omap: mailbox: reorganize headers
  omap: mailbox: don't export unecessary symbols
  omap: mailbox: mark some resources as __initdata
  omap: mailbox: don't export register/unregister

 arch/arm/mach-omap1/Makefile              |    6 +-
 arch/arm/mach-omap1/devices.c             |   40 -----
 arch/arm/mach-omap1/mailbox.c             |  118 ++++++++------
 arch/arm/mach-omap2/Makefile              |    5 +-
 arch/arm/mach-omap2/devices.c             |   92 -----------
 arch/arm/mach-omap2/mailbox.c             |  254 ++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/mailbox.h |   10 +-
 arch/arm/plat-omap/mailbox.c              |   89 +++++++---
 8 files changed, 290 insertions(+), 324 deletions(-)
