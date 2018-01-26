From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 26 Jan 2018 15:06:25 +0100
Subject: [PATCH v5 1/2] staging: fsl-mc: Move core bus out of staging
In-Reply-To: <20180126125127.26439-2-bogdan.purcareata@nxp.com>
References: <20180126125127.26439-1-bogdan.purcareata@nxp.com>
 <20180126125127.26439-2-bogdan.purcareata@nxp.com>
Message-ID: <20180126140625.GA14509@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 06:51:26AM -0600, Bogdan Purcareata wrote:
> Move the source files out of staging into their final locations:
>   -mc.h include file in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
>   -overview.rst, providing an overview of DPAA2, goes to
>    Documentation/networking/dpaa2/overview.rst
> 
> Update or delete other remaining staging files -- Makefile, Kconfig, TODO.
> Update dpaa2_eth and dpio staging drivers.
> Add integration bits for the documentation build system.
> 
> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> [rebased, add dpaa2_eth and dpio #include updates]
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> [rebased, split irqchip to separate patch]
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Notes:
>     -v5:
>       - split irqchip glue code to separate patch (GregKH)
>       - integrate doc with the kernel build system
>     -v4:
>       - regenerated patch with renames detection disabled (Andrew Lunn)
>     -v3:
>       - rebased
>     -v2:
>       - group irqchip gic its glue code together with the rest (Marc Zyngier)
> 
>  Documentation/networking/dpaa2/index.rst           |   8 +
>  Documentation/networking/dpaa2/overview.rst        | 404 +++++++++
>  Documentation/networking/index.rst                 |   1 +
>  MAINTAINERS                                        |   3 +-
>  drivers/bus/Kconfig                                |   2 +
>  drivers/bus/Makefile                               |   4 +
>  drivers/bus/fsl-mc/Kconfig                         |  16 +
>  drivers/bus/fsl-mc/Makefile                        |  16 +
>  drivers/bus/fsl-mc/dpmcp.c                         |  99 +++
>  drivers/bus/fsl-mc/dprc-driver.c                   | 809 ++++++++++++++++++
>  drivers/bus/fsl-mc/dprc.c                          | 532 ++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-allocator.c              | 648 ++++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    | 948 +++++++++++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-msi.c                    | 285 +++++++
>  drivers/bus/fsl-mc/fsl-mc-private.h                | 475 +++++++++++
>  drivers/bus/fsl-mc/mc-io.c                         | 268 ++++++
>  drivers/bus/fsl-mc/mc-sys.c                        | 296 +++++++
>  drivers/staging/fsl-dpaa2/ethernet/README          |   2 +-
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   2 +-
>  drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   2 +-
>  drivers/staging/fsl-mc/TODO                        |  18 -
>  drivers/staging/fsl-mc/bus/Kconfig                 |  10 -
>  drivers/staging/fsl-mc/bus/Makefile                |  16 +-
>  drivers/staging/fsl-mc/bus/dpbp.c                  |   2 +-
>  drivers/staging/fsl-mc/bus/dpcon.c                 |   2 +-
>  drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      |   2 +-
>  drivers/staging/fsl-mc/bus/dpio/dpio-service.c     |   2 +-
>  drivers/staging/fsl-mc/bus/dpio/dpio.c             |   2 +-
>  drivers/staging/fsl-mc/bus/dpmcp.c                 |  99 ---
>  drivers/staging/fsl-mc/bus/dprc-driver.c           | 809 ------------------
>  drivers/staging/fsl-mc/bus/dprc.c                  | 531 ------------
>  drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      | 648 --------------
>  drivers/staging/fsl-mc/bus/fsl-mc-bus.c            | 948 ---------------------
>  drivers/staging/fsl-mc/bus/fsl-mc-msi.c            | 284 ------
>  drivers/staging/fsl-mc/bus/fsl-mc-private.h        | 475 -----------
>  .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |   2 +-
>  drivers/staging/fsl-mc/bus/mc-io.c                 | 268 ------
>  drivers/staging/fsl-mc/bus/mc-sys.c                | 296 -------
>  drivers/staging/fsl-mc/include/mc.h                | 454 ----------
>  drivers/staging/fsl-mc/overview.rst                | 404 ---------
>  include/linux/fsl/mc.h                             | 454 ++++++++++
>  41 files changed, 5279 insertions(+), 5267 deletions(-)
>  create mode 100644 Documentation/networking/dpaa2/index.rst
>  create mode 100644 Documentation/networking/dpaa2/overview.rst
>  create mode 100644 drivers/bus/fsl-mc/Kconfig
>  create mode 100644 drivers/bus/fsl-mc/Makefile
>  create mode 100644 drivers/bus/fsl-mc/dpmcp.c
>  create mode 100644 drivers/bus/fsl-mc/dprc-driver.c
>  create mode 100644 drivers/bus/fsl-mc/dprc.c
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-allocator.c
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-bus.c
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-msi.c
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-private.h
>  create mode 100644 drivers/bus/fsl-mc/mc-io.c
>  create mode 100644 drivers/bus/fsl-mc/mc-sys.c
>  delete mode 100644 drivers/staging/fsl-mc/TODO
>  delete mode 100644 drivers/staging/fsl-mc/bus/dpmcp.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/dprc-driver.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/dprc.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-msi.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/fsl-mc-private.h
>  delete mode 100644 drivers/staging/fsl-mc/bus/mc-io.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/mc-sys.c
>  delete mode 100644 drivers/staging/fsl-mc/include/mc.h
>  delete mode 100644 drivers/staging/fsl-mc/overview.rst
>  create mode 100644 include/linux/fsl/mc.h

I thought you were creating this with -M to git format-patch, what
happened?  That will show the files being renamed, not just deleted and
added.

thanks,

greg k-h
