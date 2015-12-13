From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 12 Dec 2015 20:41:47 -0500
Subject: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*
Message-ID: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of commits is a slice of a larger project to ensure
people don't have dead code for module removal in non-modular
drivers.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, etc. and we continue to work on other areas.

There are several reasons to not use module_init for code that can
never be built as a module, but the big ones are:

 (1) it is easy to accidentally code up unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
      modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else.

Here we convert some module_init() calls into device_initcall() and delete
any module_exit and remove code that gets orphaned in the process, for
an overall net code reduction, which is always welcome.

The use of device_initcall ensures that the init function ordering
remains unchanged, but one could argue that PCI host code might be more
appropriate to be handled under subsys_initcall.  Fortunately we can
revisit making this extra change at a later date if desired; it does
not need to happen now, and we reduce the risk of introducing
regressions at this point in time by separating the two changes.

Over half of the drivers changed here already explicitly disallowed any
unbind operations.  For the rest we make them the same, since there is
not really any sensible use case to unbind any built-in bus support that
I can think of.

I have more "avoid module usage in non-modular code" cleanups for the
PCI subsystem, but these all have a common theme and it makes for a
more maintainer friendly series size to just ask to digest these 1st.

Testing was done on linux-next, using an ARCH=arm allmodconfig and then
explicitly building the files changed in this series.  If desired, I
can provide a v4.4-rc4 based branch for merging vs e-mail processing,
since I don't think the underlying baseline is overly important for
this (largely trivial) series of patches.

Paul.
---

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-omap at vger.kernel.org
Cc: linux-pci at vger.kernel.org
Cc: linux-sh at vger.kernel.org
Cc: linux-tegra at vger.kernel.org
Cc: rfi at lists.rocketboards.org

Paul Gortmaker (10):
  drivers/pci: make host/pci-imx6.c driver explicitly non-modular
  drivers/pci: make host/pcie-spear13xx.c driver explicitly non-modular
  drivers/pci: make host/pci-mvebu.c explicitly non-modular
  drivers/pci: make host/pci-dra7xx.c explicitly non-modular
  drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular
  drivers/pci: make host/pci-tegra.c explicitly non-modular
  drivers/pci: make host/pcie-rcar.c explicitly non-modular
  drivers/pci: make host/pcie-xilinx.c explicitly non-modular
  drivers/pci: make host/pci-keystone.c explicitly non-modular
  drivers/pci: make host/pcie-altera.c explicitly non-modular

 drivers/pci/host/pci-dra7xx.c     | 31 +++--------------------
 drivers/pci/host/pci-imx6.c       | 12 +++------
 drivers/pci/host/pci-keystone.c   | 21 +++-------------
 drivers/pci/host/pci-mvebu.c      | 11 +++-----
 drivers/pci/host/pci-rcar-gen2.c  | 12 +++------
 drivers/pci/host/pci-tegra.c      | 11 +++-----
 drivers/pci/host/pcie-altera.c    | 12 ++++-----
 drivers/pci/host/pcie-rcar.c      | 11 +++-----
 drivers/pci/host/pcie-spear13xx.c | 10 +++-----
 drivers/pci/host/pcie-xilinx.c    | 53 ++-------------------------------------
 10 files changed, 35 insertions(+), 149 deletions(-)

-- 
2.6.1
