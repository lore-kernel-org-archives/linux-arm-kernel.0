From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri, 26 Jan 2018 06:51:25 -0600
Subject: [PATCH v5 0/2] staging: fsl-mc: Move bus driver out of staging
Message-ID: <20180126125127.26439-1-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous submission: https://patchwork.kernel.org/patch/10081731/

Most of the feedback was addressed by a separate series of cleanup
/ refactoring patches [1] which were applied.

The thing left to do is to split the original patch into moving out the
core bus infrastructure separate from the irqchip glue code, and
integrate the documentation with the kernel build system.

This patchset only handles moving the fsl-mc bus core out of staging.
The remaining objects (DPBP, DPCON) and drivers (dpio, dpaa2-eth) will
be moved out in subsequent patches.

[1] https://lkml.org/lkml/2018/1/16/386

Notes:
    -v5:
      - split irqchip glue code to separate patch (GregKH)
      - integrate doc with the kernel build system
    -v4:
      - regenerated patch with renames detection disabled (Andrew Lunn)
    -v3:
      - rebased
    -v2:
      - group irqchip gic its glue code together with the rest (Marc Zyngier)

Bogdan Purcareata (2):
  staging: fsl-mc: Move core bus out of staging
  staging: fsl-mc: Move irqchip code out of staging

 Documentation/networking/dpaa2/index.rst           |   8 +
 Documentation/networking/dpaa2/overview.rst        | 404 +++++++++
 Documentation/networking/index.rst                 |   1 +
 MAINTAINERS                                        |   3 +-
 drivers/bus/Kconfig                                |   2 +
 drivers/bus/Makefile                               |   4 +
 drivers/bus/fsl-mc/Kconfig                         |  16 +
 drivers/bus/fsl-mc/Makefile                        |  16 +
 drivers/bus/fsl-mc/dpmcp.c                         |  99 +++
 drivers/bus/fsl-mc/dprc-driver.c                   | 809 ++++++++++++++++++
 drivers/bus/fsl-mc/dprc.c                          | 532 ++++++++++++
 drivers/bus/fsl-mc/fsl-mc-allocator.c              | 648 ++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-bus.c                    | 948 +++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-msi.c                    | 285 +++++++
 drivers/bus/fsl-mc/fsl-mc-private.h                | 475 +++++++++++
 drivers/bus/fsl-mc/mc-io.c                         | 268 ++++++
 drivers/bus/fsl-mc/mc-sys.c                        | 296 +++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        | 100 +++
 drivers/staging/fsl-dpaa2/ethernet/README          |   2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   2 +-
 drivers/staging/fsl-mc/TODO                        |  18 -
 drivers/staging/fsl-mc/bus/Kconfig                 |  10 -
 drivers/staging/fsl-mc/bus/Makefile                |  15 +-
 drivers/staging/fsl-mc/bus/dpbp.c                  |   2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                 |   2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      |   2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c     |   2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c             |   2 +-
 drivers/staging/fsl-mc/bus/dpmcp.c                 |  99 ---
 drivers/staging/fsl-mc/bus/dprc-driver.c           | 809 ------------------
 drivers/staging/fsl-mc/bus/dprc.c                  | 531 ------------
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      | 648 --------------
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c            | 948 ---------------------
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            | 284 ------
 drivers/staging/fsl-mc/bus/fsl-mc-private.h        | 475 -----------
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 100 ---
 drivers/staging/fsl-mc/bus/mc-io.c                 | 268 ------
 drivers/staging/fsl-mc/bus/mc-sys.c                | 296 -------
 drivers/staging/fsl-mc/include/mc.h                | 454 ----------
 drivers/staging/fsl-mc/overview.rst                | 404 ---------
 include/linux/fsl/mc.h                             | 454 ++++++++++
 43 files changed, 5378 insertions(+), 5366 deletions(-)
 create mode 100644 Documentation/networking/dpaa2/index.rst
 create mode 100644 Documentation/networking/dpaa2/overview.rst
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 create mode 100644 drivers/bus/fsl-mc/dpmcp.c
 create mode 100644 drivers/bus/fsl-mc/dprc-driver.c
 create mode 100644 drivers/bus/fsl-mc/dprc.c
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-allocator.c
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-bus.c
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-msi.c
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-private.h
 create mode 100644 drivers/bus/fsl-mc/mc-io.c
 create mode 100644 drivers/bus/fsl-mc/mc-sys.c
 create mode 100644 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
 delete mode 100644 drivers/staging/fsl-mc/TODO
 delete mode 100644 drivers/staging/fsl-mc/bus/dpmcp.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dprc-driver.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dprc.c
 delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
 delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-bus.c
 delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-msi.c
 delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-private.h
 delete mode 100644 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
 delete mode 100644 drivers/staging/fsl-mc/bus/mc-io.c
 delete mode 100644 drivers/staging/fsl-mc/bus/mc-sys.c
 delete mode 100644 drivers/staging/fsl-mc/include/mc.h
 delete mode 100644 drivers/staging/fsl-mc/overview.rst
 create mode 100644 include/linux/fsl/mc.h

-- 
2.7.4
