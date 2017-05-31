From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:42 +0300
Subject: [PATCH v6 00/10] staging: fsl-mc: move bus driver out of staging
Message-ID: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Now that there is a functional ethernet driver probed on the
mc bus this patch series requests that the fsl-mc bus driver
be moved out of staging.

The proposed destination for the bus driver is drivers/bus.
Proposed location for global header files for fsl-mc and dpaa2
is the already existing include/linux/fsl.

First couple of patches fix several checkpatch.pl and README issues
and the last patch moves the bus out of staging, updating all
the users (e.g. #include paths).

Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git, staging-next

Link to previous version:
https://lkml.org/lkml/2017/5/22/327

Link to last round of driver model fixes & cleanups:
https://lkml.org/lkml/2017/2/1/235

version 6 changes
 - split patch containing multiple checkpatch.pl fixes into distinct patches (GregKH)
 - fix couple submission issues (GregKH)
   - reverted version bump on patches that weren't actually changed
   - fix version prefix

version 5 changes
 - drop restool utility reference from README (Marc Zyngier)
 - add binding path in README (Marc Zyngier)

version 4 changes
 - rebased on latest staging-next
 - dpio was submitted separately so dropped from the series
 - several checkpatch.pl --strict fixes (first 2 patches)
 - update existing dpaa2 drivers to match the new fsl-mc bus location

version 3 changes
   -zero memory allocated for a dpio store
   -replace hardcoded dequeue token with a #define and look for
    that token when checking for a new result

version 2 changes (mostly feedback from Ioana Radulescu)
   -removed unused structs and defines in dpio command definitions
   -added setter/getter for the FD ctrl field
   -corrected comment for SG format_offset field description
   -added support for short length field in FD
   -fix bug in buffer release command, by setting bpid field
   -handle error (NULL) return value from qbman_swp_mc_complete()
   -fix bug in sending management commands where the verb was
    properly initialized
   -use service_select_by_cpu() for re-arming DPIO interrupts
   -replace use of NR_CPUS with num_possible_cpus()
   -handle error case where number of DPIOs exceeds number of possible
    CPUs
   -error message cleanup
   -updated MAINTAINERS file with proper location for both fsl-mc bus
    driver and dpio driver
Laurentiu Tudor (9):
  staging: fsl-mc: enclose macro params in parens
  staging: fsl-mc: fix macros with possible side effects
  staging: fsl-mc: simplify couple of deallocations
  staging: fsl-mc: drop a few useless #includes
  staging: fsl-mc: remove extra blank line
  staging: fsl-mc: drop unused forward declaration
  staging: fsl-mc: add binding path to MAINTAINERS
  staging: fsl-mc: drop reference to restool
  staging: fsl-mc: add reference to mc-bus DT binding

Stuart Yoder (1):
  staging: fsl-mc: move bus driver out of staging

 .../README.txt => Documentation/dpaa2/overview.txt    |  6 +++---
 MAINTAINERS                                           |  3 ++-
 drivers/bus/Kconfig                                   |  2 ++
 drivers/bus/Makefile                                  |  3 +++
 drivers/bus/fsl-mc/Kconfig                            | 17 +++++++++++++++++
 drivers/bus/fsl-mc/Makefile                           | 19 +++++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp-cmd.h |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c     |  6 +++---
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h    |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c    |  4 ++--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h    |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng.c    |  6 +++---
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c  | 14 +++++++++-----
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c     |  6 +++---
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c      | 17 ++++++++++-------
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c   | 18 ++++++------------
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c   |  4 +++-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h        |  3 +--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c    |  5 +++--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c   |  6 +++---
 drivers/irqchip/Makefile                              |  1 +
 .../bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c       |  3 +--
 drivers/staging/fsl-dpaa2/ethernet/README             |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c        |  4 ++--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h        |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c             |  4 ++--
 drivers/staging/fsl-mc/TODO                           | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                    | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                   | 15 +--------------
 drivers/staging/fsl-mc/bus/dpcon.c                    |  8 ++++----
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c        |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                |  4 ++--
 .../fsl-mc/include => include/linux/fsl}/dpbp.h       |  0
 .../fsl-mc/bus => include/linux/fsl}/dpcon-cmd.h      |  0
 .../fsl-mc/include => include/linux/fsl}/dpmng.h      |  0
 .../fsl-mc/include => include/linux/fsl}/dprc.h       |  4 ----
 .../fsl-mc/include => include/linux/fsl}/mc-bus.h     |  2 +-
 .../fsl-mc/include => include/linux/fsl}/mc-cmd.h     |  0
 .../fsl-mc/include => include/linux/fsl}/mc-sys.h     |  1 -
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h |  2 +-
 43 files changed, 115 insertions(+), 116 deletions(-)
 rename drivers/staging/fsl-mc/README.txt => Documentation/dpaa2/overview.txt (99%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp-cmd.h (97%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng.c (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (98%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dpbp.h (100%)
 rename {drivers/staging/fsl-mc/bus => include/linux/fsl}/dpcon-cmd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dpmng.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dprc.h (99%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-bus.h (99%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-cmd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-sys.h (99%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (99%)

-- 
2.9.4
