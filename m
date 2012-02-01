From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 31 Jan 2012 21:00:10 -0600
Subject: [RFC PATCH v4 0/4] Consolidate cpuidle timekeeping and irq enabling
Message-ID: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series moves the timekeeping and irq enabling from the platform
code to the core cpuidle driver.  Also, the platform irq disabling was removed
as it appears that all calls into cpuidle_call_idle will have already called
local_irq_disable().

To save reviewers time, only a few platforms which required the most changes
are included in this version.  If these changes are approved, the next version
will include the remaining platform code which should require minimal changes.

For those who have followed the previous patch versions, as you know, the
previous version of this patch series added some helper functionality which
used a wrapper function to remove the time keeping and irq enabling/disabling
from the platform code.  There was also initialization helper functionality 
which has now been removed from this version.  If the basic implementation
in this version is approved, then a separate patch submission effort can be
made to focus on consolidation of initialziation functionality.

Based on 3.3-rc1

v3 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg156751.html
Changes since v3:
* Removed drivers/cpuidle/common.c
** Removed the initialization helper functions
** Removed the wrapper used to consolidate time keeping and irq enable/disable
* Add time keeping and local_irq_disable handling in cpuidle_call_idle().
* Made necessary modifications to a few platforms that required the most changes
** Note on omap3: changed structure of omap3_idle_drvdata and added 
   per_next_state and per_saved_state vars to accomodate new framework.

v2 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199

Changes since v2:
* Made various code organization and style changes as suggested in v1 review.
* Removed at91 use of common code.  A separate effort is underway to clean
at91 code and the author has offered to convert to common interface as part
of those changes (if this common interface is accepted in time).
* Made platform cpuidle_driver objects __initdata and dynamically added one
persistent instance of this object in common code.
* Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed after
being enabled during clock initialization.
* Re-organized patches.

v1 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791

Changes since v1:
* Common interface moved to drivers/cpuidle and made non arch-specific.
* Made various fixes and suggested additions to the common cpuidle
code from v1 review.
* Added callback for filling in driver_data field as needed.
* Modified the various platforms with these changes.

Robert Lee (4):
  cpuidle: Add time keeping and irq enabling
  ARM: omap: Remove cpuidle timekeeping and irq enable/disable
  acpi: Remove cpuidle timekeeping and irq enable/disable
  x86: Remove cpuidle timekeeping and irq enable/disable

 arch/arm/mach-omap2/cpuidle34xx.c |   96 ++++++++----------
 drivers/acpi/processor_idle.c     |  203 ++++++++++++++++++++++---------------
 drivers/cpuidle/cpuidle.c         |   75 +++++++++++---
 drivers/idle/intel_idle.c         |  110 ++++++++++++++------
 include/linux/cpuidle.h           |   26 +++--
 5 files changed, 317 insertions(+), 193 deletions(-)
