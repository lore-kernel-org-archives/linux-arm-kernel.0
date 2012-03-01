From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu,  1 Mar 2012 10:11:30 +0200
Subject: [PATCH 0/7] remoteproc: additional virtio support
Message-ID: <1330589497-4139-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set focuses on extending remoteproc's virtio support: we're
putting behind the single rpmsg virtio device limitation, and allowing
firmwares to publish any number of virtio devices and of any type.

This allows us to reuse the existing virtio drivers with remote processor
backends.

For example, by publishing a virtio console device and hooking it up to the
logging mechanism of OMAP's SYS/BIOS (the RTOS which runs on the M3
subsystem), we get a fancy console with log messages coming from the M3
without writing any additional driver:

root at omap4430-panda:~# modprobe virtio_console
root at omap4430-panda:~# cat /dev/hvc0 
M3 Core0 init...
Hello from SYS/BIOS
copyTask 50: Entered...:
registering rpmsg-client-sample service on 50 with HOST
copyTask 51: Entered...:
registering rpmsg-proto service on 51 with HOST
registering rpmsg-omx service on 60 with HOST
copyTask 1: Received data: hello world!, len:12
copyTask 2: Received data: hello world!, len:12
copyTask 3: Received data: hello world!, len:12
...

Note: at this point, whether you can start using vanilla virtio drivers
with your remote processor strongly depends on your platform. E.g., there
are additional changes required for this to work on OMAP4 (mainly to
satisfy the M3's iommu requirements), and that's not upstream yet.
Other non-iommu remote processors might be able to use vanilla virtio
drivers though (probably DaVinci, for example, but this wasn't tested yet).

Cc: Brian Swetland <swetland@google.com>
Cc: Iliyan Malchev <malchev@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark Grosen <mgrosen@ti.com>
Cc: John Williams <john.williams@petalogix.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Loic PALLARDY <loic.pallardy@stericsson.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Guzman Lugo Fernando <fernando.lugo@ti.com>
Cc: Anna Suman <s-anna@ti.com>
Cc: Clark Rob <rob@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Kieran Bingham <kieranbingham@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>

Ohad Ben-Cohen (7):
  remoteproc: resource table overhaul
  remoteproc: remoteproc_rpmsg -> remoteproc_virtio
  remoteproc: safer boot/shutdown order
  remoteproc: remove the single rpmsg vdev limitation
  remoteproc/omap: remove the mbox_callback limitation
  remoteproc: remove the hardcoded vring alignment
  remoteproc: cleanup resource table parsing paths

 Documentation/remoteproc.txt                       |  136 +++---
 drivers/remoteproc/Makefile                        |    2 +-
 drivers/remoteproc/omap_remoteproc.c               |   11 +-
 drivers/remoteproc/remoteproc_core.c               |  524 ++++++++++++--------
 drivers/remoteproc/remoteproc_internal.h           |    6 +-
 .../{remoteproc_rpmsg.c => remoteproc_virtio.c}    |  162 +++----
 include/linux/remoteproc.h                         |  339 ++++++++++---
 7 files changed, 747 insertions(+), 433 deletions(-)
 rename drivers/remoteproc/{remoteproc_rpmsg.c => remoteproc_virtio.c} (65%)

-- 
1.7.5.4
