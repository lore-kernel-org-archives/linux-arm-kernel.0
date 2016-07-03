From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 3 Jul 2016 13:30:36 -0400
Subject: [PATCH v2 0/4] bus: remove unused modular code from non-modular
 drivers
Message-ID: <20160703173040.23612-1-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers/bus doesn't have a strict maintainer entry, but since
all the changes here are for ARM platforms, I'm Cc'ing arm-kernel
and hoping it makes sense to vector these few changes through the
arm-soc tree.

My ongoing audit looking for non-modular code that needlessly uses
modular macros (vs. built-in equivalents) and/or has dead code
relating to module unloading that can never be executed led to the
creation of these four commits.

Two are of the trivial kind, where we substitute in the non-modular
versions that CPP would have put in place anyway, resulting in no
actual changes, even at the binary output level.

Another is of the kind where there was a ".remove" function
registered into the driver struct.  Being non-modular, these
functions will never be called via a normal module_exit path.

However, since it was possible (but largely pointless, and without
a real use case) to unbind these drivers via sysfs, we explicitly
disallow the unbind as part of the removal of the ".remove" itself.

Finally one is a conversion of a bool to a tristate; not something
I'd do myself by default, but in this case we had a desire from
the original author to have it that way.

For anyone new to the underlying goal of this cleanup, we are trying to
not use module support for code that can never be built as a module since:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

Build tested for arm and arm64 on linux-next to ensure no silly typos
that would break compilation crept in.

---

[v2: drop arm-ccn patch; it is being made tristate elsewhere, convert
 simple-pm to tristate, add new patch for new tegra-aconnect driver.]

[v1: https://lkml.kernel.org/r/1459113058-14340-1-git-send-email-paul.gortmaker at windriver.com ]

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Alison Chaiken <alison_chaiken@mentor.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org

Paul Gortmaker (4):
  bus: brcmstb_gisb: make it explicitly non-modular
  bus: imx-weim: make it explicitly non-modular
  bus: tegra-aconnect: make it explicitly non-modular
  bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate

 drivers/bus/Kconfig          |  2 +-
 drivers/bus/brcmstb_gisb.c   |  4 +---
 drivers/bus/imx-weim.c       |  9 ++-------
 drivers/bus/tegra-aconnect.c | 22 +++++-----------------
 4 files changed, 9 insertions(+), 28 deletions(-)

-- 
2.8.4
