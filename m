From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri,  1 May 2015 10:41:10 +0100
Subject: [PATCH] drivers: mfd: check ACPI device companion before checking
 resources
Message-ID: <1430473270-11359-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code in mfd-core calls into ACPI to check resources even
on a system that booted with a DT (on kernels with both DT and ACPI
support compiled in). This triggers ACPI exceptions since we may
end up calling the ACPI interpreter when it has not been initialized:

"ACPI Exception: AE_BAD_PARAMETER, Thread 2064154624 could not acquire
Mutex [0x1] (20150410/utmutex-285)"

This patch fixes the issues by adding a check for an ACPI companion
device before carrying out ACPI resources checks to avoid calling
the ACPI interpreter if the fwnode representing the device is an OF one.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
Lee, Samuel,

I could not test it on X86 and I do not know if you prefer setting
ignore_resource_conflicts in the respective mfd cells (ie vexpress),
just let me know how do you want to fix it.

Thanks,
Lorenzo

 drivers/mfd/mfd-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 1aed3b7..14fd5cb 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -207,9 +207,11 @@ static int mfd_add_device(struct device *parent, int id,
 		}
 
 		if (!cell->ignore_resource_conflicts) {
-			ret = acpi_check_resource_conflict(&res[r]);
-			if (ret)
-				goto fail_alias;
+			if (has_acpi_companion(&pdev->dev)) {
+				ret = acpi_check_resource_conflict(&res[r]);
+				if (ret)
+					goto fail_alias;
+			}
 		}
 	}
 
-- 
2.2.1
