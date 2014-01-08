From: al.stone@linaro.org (al.stone at linaro.org)
Date: Tue,  7 Jan 2014 17:46:48 -0700
Subject: [PATCH v5 2/5] ACPI: bus master reload not supported in reduced HW
 mode
In-Reply-To: <1389142011-27356-1-git-send-email-al.stone@linaro.org>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org>
Message-ID: <1389142011-27356-3-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Do not save and restore bus master reload registers in suspend/resume
when in reduced HW mode; according to the spec, no such registers should
exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..eac984a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -229,12 +229,14 @@ static struct syscore_ops acpi_processor_syscore_ops = {
 
 void acpi_processor_syscore_init(void)
 {
-	register_syscore_ops(&acpi_processor_syscore_ops);
+	if (!acpi_gbl_reduced_hardware)
+		register_syscore_ops(&acpi_processor_syscore_ops);
 }
 
 void acpi_processor_syscore_exit(void)
 {
-	unregister_syscore_ops(&acpi_processor_syscore_ops);
+	if (!acpi_gbl_reduced_hardware)
+		unregister_syscore_ops(&acpi_processor_syscore_ops);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
1.8.4.2
