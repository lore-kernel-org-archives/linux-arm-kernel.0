From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Aug 2017 16:42:00 +0200
Subject: [PATCH v2 0/9] PM / ACPI / i2c: Deploy runtime PM centric path for
 system sleep
Message-ID: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
isn't well optimized for system sleep.

What makes this driver particularly interesting is because it's a cross-SoC
driver, which sometimes means there is an ACPI PM domain attached to the i2c
device and sometimes not. The driver is being used on both x86 and ARM.

In principle, to optimize the system sleep support in i2c driver, this series
enables the proven runtime PM centric path for the i2c driver. However, to do
that the ACPI PM domain also have to collaborate and understand this behaviour.
Therefore a number of changes, patch 1 to patch 7, makes the needed changes to
the ACPI PM domain. In patch8 and patch 9, the i2c driver gets optimized and is
converted to the runtime PM centric path for system sleep.

It shall be noted, the behaviour of the ACPI PM domain should remain intact,
still taking benefit of using the direct_complete path during system sleep,
except for those drivers that explicitly request it not to (via a new ACPI API
added in this series).

This series has been tested on an ARM64 Hikey board, which isn't having the
i2c device attached to the ACPI PM domain. This means that the ACPI changes
needs to be tested on some relevant Intel SoCs and it's greatly appreciated
is someone could help out with this, so is of course review comments.

Some news in v2:
	- The v1 contained a fix for the i2c driver, this has been sent
	separately [1] and picked up for fixes by Wolfram for v4.13-rcs. However
	the fix has not yet reached Linus' tree. The changes on i2c driver
	are based upon that change.
	- To simplify for testers, I have published a branch [2] based upon
	Rafael's pm tree and linux-next branch, which also includes the above
	patch.
	- Rephrased the coverletter to clarify the intent of this series.
	- Addressed review comments from v1.

[1]
http://patchwork.ozlabs.org/patch/799803/

[2]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git acpi_pm_i2c_rpm_path_v2

Kind regards
Ulf Hansson


Ulf Hansson (9):
  PM / ACPI: Restore acpi_subsys_complete()
  PM / Sleep: Remove pm_complete_with_resume_check()
  PM / ACPI: Split code validating need for runtime resume in
    ->prepare()
  PM / ACPI: Split acpi_lpss_suspend_late|resume_early()
  PM / ACPI: Provide option to disable direct_complete for ACPI devices
  PM / ACPI: Enable the runtime PM centric approach for system sleep
  PM / ACPI: Avoid runtime resuming device in
    acpi_subsys_suspend|freeze()
  i2c: designware: Don't resume device in the ->complete() callback
  i2c: designware: Deploy the runtime PM centric approach for system
    sleep

 drivers/acpi/acpi_lpss.c                    |  81 +++++++++----
 drivers/acpi/device_pm.c                    | 169 ++++++++++++++++++++++++----
 drivers/base/power/generic_ops.c            |  23 ----
 drivers/i2c/busses/i2c-designware-platdrv.c |  35 +-----
 include/acpi/acpi_bus.h                     |   1 +
 include/linux/acpi.h                        |   4 +
 include/linux/pm.h                          |   1 -
 7 files changed, 218 insertions(+), 96 deletions(-)

-- 
2.7.4
