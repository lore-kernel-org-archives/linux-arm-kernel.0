From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 Nov 2016 14:02:59 -0500
Subject: [PATCH 0/3] soc: avoid module usage in non-modular code
Message-ID: <20161113190302.18099-1-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of commits is a part of a larger project to ensure
people don't reference modular support functions in non-modular
code.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, gpio ... and we continue to work on other areas.

There are several reasons to not use module support for code that
can never be built as a module, but the big ones are:

 (1) it is easy to accidentally code up unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
      modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else.

Two of the changes are essentially source only -- the resuting module
will be binary equivalent.  Only the FSL driver has unused code in
addition to the use of modular macros that get converted.

Note the FSL SOC driver just appeared in linux-next and so this series
won't apply on Linus' master branch.  These commits were applied to
linux-next and build tested there.

Paul.
---

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-tegra at vger.kernel.org

Paul Gortmaker (3):
  soc: sunxi: make sunxi_sram explicitly non-modular
  soc: tegra: make fuse-tegra explicitly non-modular
  soc: fsl: make guts driver explicitly non-modular

 drivers/soc/fsl/guts.c              | 17 ++---------------
 drivers/soc/sunxi/sunxi_sram.c      |  9 ++-------
 drivers/soc/tegra/fuse/fuse-tegra.c |  4 ++--
 3 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.10.1
