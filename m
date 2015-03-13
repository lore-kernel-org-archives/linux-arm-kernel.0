From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:40 +0100
Subject: [PATCH 0/9] PM / Domains: Don't leave unused PM domains powered after
 ->probe()
Message-ID: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "PM / Domains: Power on the PM domain right after attach completes",
helped to make sure a PM domain stays powered during ->probe(), but unfurtunate
it also caused a regression.

In those scenario where the driver leaves its device in runtime PM suspended
state, and don't bring it to active state during ->probe(), could cause an
unsued PM domain to stay powered.

The intent from this patchset, is to fix this regression and to rework the
solution of how to make sure PM domains stays powered during ->probe().

This patchset is a rebased version of the below earlier posted patchset.
[PATCH v3 0/9] PM / Domains: Fix race conditions during boot

You may find that patchset from here:
http://marc.info/?l=linux-pm&m=141320895122707&w=2

>From that patchset, there is a "scenario 5" described, which actually is a more
detailed description the regression commit "PM / Domains: Power on the PM domain
right after attach completes" was about to introduce.


Ulf Hansson (9):
  PM / Domains: Add dev_pm_domain_get|put() APIs
  PM / Domains: Enable genpd to support ->get|put() callbacks
  amba: Keep PM domain powered during ->probe()
  drivercore / platform: Keep PM domain powered during ->probe()
  i2c: core: Keep PM domain powered during ->probe()
  spi: core: Keep PM domain powered during ->probe()
  mmc: core: Attach PM domain prior probing of SDIO func driver
  mmmc: core: Keep PM domain powered during ->probe() of SDIO func
    driver
  Revert "PM / Domains: Power on the PM domain right after attach
    completes"

 drivers/amba/bus.c          |  8 ++++++++
 drivers/base/platform.c     |  7 +++++++
 drivers/base/power/common.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
 drivers/i2c/i2c-core.c      |  7 +++++++
 drivers/mmc/core/sdio_bus.c | 21 +++++++++++++++++----
 drivers/spi/spi.c           |  7 +++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  5 +++++
 9 files changed, 118 insertions(+), 6 deletions(-)

-- 
1.9.1
