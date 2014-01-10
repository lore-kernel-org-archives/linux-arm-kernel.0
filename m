From: al.stone@linaro.org (al.stone at linaro.org)
Date: Fri, 10 Jan 2014 15:52:18 -0700
Subject: [PATCH v6 4/6] ACPI: in HW reduced mode,
 using FADT PM information is not allowed.
In-Reply-To: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Message-ID: <1389394340-2680-5-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Per the ACPI 5.0 specification, section 5.2.9, none of the power
management fields in the FADT are to be used.  Short-circuit using
any of those fields in acpi_processor_get_power_info_fadt().

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index eac984a..89f0a0f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 	if (!pr->pblk)
 		return -ENODEV;
 
+	/*
+	 * Using power management information from the FADT is not
+	 * allowed when in HW reduced mode.  See ACPI 5.0, section
+	 * 5.2.9.
+	 */
+	if (acpi_gbl_reduced_hardware)
+		return -ENODEV;
+
 	/* if info is obtained from pblk/fadt, type equals state */
 	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
 	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
-- 
1.8.4.2
