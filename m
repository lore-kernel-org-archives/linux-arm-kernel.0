From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 27 Mar 2016 17:10:54 -0400
Subject: [PATCH 0/4] drivers/bus: remove unused modular code from non-modular
 drivers
Message-ID: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers/bus doesn't have a strict maintainer entry, but since
all the changes here are for ARM platforms, I'm Cc'ing arm-kernel
and hoping it makes sense to vector these few changes through the
arm-soc. [Olof, Will, Arnd? Seems you guys handle most of it...]

My ongoing audit looking for non-modular code that needlessly uses
modular macros (vs. built-in equivalents) and/or has dead code
relating to module unloading that can never be executed led to the
creation of these four commits.

Two are of the trivial kind, where we substitute in the non-modular
versions that CPP would have put in place anyway, resulting in no
actual changes, even at the binary output level.

The other two are of the kind where there was a ".remove" function
registered into the driver struct.  Being non-modular, these
functions will never be called via a normal module_exit path.

However, since it was possible (but largely pointless, and without
a real use case) to unbind these drivers via sysfs, we explicitly
disallow the unbind as part of the removal of the ".remove" itself.

For anyone new to the underlying goal of this cleanup, we are trying to
not use module support for code that can never be built as a module since:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

Build tested for arm and arm64 on v4.6-rc1 to ensure no silly typos
that would break compilation crept in.

---

Cc: Alison Chaiken <alison_chaiken@mentor.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel at lists.infradead.org

Paul Gortmaker (4):
  drivers/bus: make brcmstb_gisb.c driver explicitly non-modular
  drivers/bus: make imx-weim.c explicitly non-modular
  drivers/bus: make simple-pm-bus.c explicitly non-modular
  drivers/bus: make arm-ccn.c driver explicitly non-modular

 drivers/bus/arm-ccn.c       | 41 +++++------------------------------------
 drivers/bus/brcmstb_gisb.c  |  4 +---
 drivers/bus/imx-weim.c      |  9 ++-------
 drivers/bus/simple-pm-bus.c | 22 +++++-----------------
 4 files changed, 13 insertions(+), 63 deletions(-)

-- 
2.6.1
