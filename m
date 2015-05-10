From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 10 May 2015 15:49:38 -0400
Subject: [PATCH 0/7] Introduce builtin_driver and use it for non-modular code
Message-ID: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We see an increasing number of non-modular drivers using the
modular_driver() type register functions.  There are several
downsides to this (as listed in the 1st commit log), so here
we introduce similar non-modular macros for builtin drivers.

Then we convert builtin drivers (controlled by a bool Kconfig)
by making the following type of changes:

  module_platform_driver()       --->  builtin_platform_driver()
  module_platform_driver_probe() --->  builtin_platform_driver_probe().

The set of drivers that are converted here are just the ones that
showed up as relying on an implicit include of <module.h> during
a pending header cleanup.  So we convert them here vs. adding
an include of <module.h> to non-modular code to avoid compile fails.
Additonal conversions can be done asynchronously at any time.

These changes, and the pending header cleanup are a refactoring of
a larger series[1] into smaller, more easily reviewed chunks that
share a common theme.

Note to maintainers:  None of the conversion patches here can be
taken into subtrees individually, since they all rely on the 1st
patch to add the builtin macros.  But I'll add Acks as requested.

Thanks,
Paul.

[1] https://marc.info/?l=linux-kernel&m=139033951228828
---

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pm at vger.kernel.org
Cc: linux-tegra at vger.kernel.org
