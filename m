From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 11 Oct 2015 21:35:44 -0400
Subject: [PATCH 0/3] amba/coresight: make non-modular code explicitly
 non-modular
Message-ID: <1444613747-17715-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a previous merge window, we made changes to allow better
delineation between modular and non-modular code in commit
0fd972a7d91d6e15393c449492a04d94c0b89351 ("module: relocate module_init
from init.h to module.h").  This allows us to now ensure module code
looks modular and non-modular code does not accidentally look modular
just to avoid suffering build breakage.

Here we target code that is, by nature of their Makefile and/or
Kconfig settings, only available to be built-in, but implicitly
presenting itself as being possibly modular by way of using modular
headers, macros, and functions.

The goal here is to remove that illusion of modularity from these
files, but in a way that leaves the actual runtime unchanged.
In doing so, we remove code that has never been tested and adds
no value to the tree.  And we continue the process of expecting a
level of consistency between the Kconfig/Makefile of code and the
code in use itself.

The coresight drivers make extensive use of module_amba_driver, hence
why this is all grouped together. Build tested on the latest linux-next,
for ARCH=arm.

Note that the coresight drivers could in theory be unbound prior to
this commit, but there doesn't seem to be any case where that would
make sense, so we explicitly disable that now that we have deleted
the .remove functions that the unbind would have called.

Paul.
--

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org

Paul Gortmaker (3):
  amba: create builtin_amba_driver to avoid registration boilerplate
  drivers/hwtracing: make coresight-* explicitly non-modular
  drivers/amba: make tegra-ahb.c explicitly non-modular

 drivers/amba/tegra-ahb.c                           |  9 ++-----
 drivers/hwtracing/coresight/coresight-etb10.c      | 26 +++++--------------
 drivers/hwtracing/coresight/coresight-etm3x.c      | 29 ++++++---------------
 drivers/hwtracing/coresight/coresight-etm4x.c      | 19 +++-----------
 drivers/hwtracing/coresight/coresight-funnel.c     | 25 +++++-------------
 .../coresight/coresight-replicator-qcom.c          | 19 +++-----------
 drivers/hwtracing/coresight/coresight-replicator.c | 30 +++++-----------------
 drivers/hwtracing/coresight/coresight-tmc.c        | 28 +++++---------------
 drivers/hwtracing/coresight/coresight-tpiu.c       | 25 +++++-------------
 drivers/hwtracing/coresight/coresight.c            |  3 ---
 drivers/hwtracing/coresight/of_coresight.c         |  1 -
 include/linux/amba/bus.h                           |  9 +++++++
 12 files changed, 60 insertions(+), 163 deletions(-)

-- 
2.6.1
