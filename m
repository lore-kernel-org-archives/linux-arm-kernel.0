From: al.stone@linaro.org (al.stone at linaro.org)
Date: Mon, 16 Dec 2013 17:16:38 -0700
Subject: [PATCH v4 2/5] ACPI: bus master reload not supported in reduced HW
 mode
In-Reply-To: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
Message-ID: <1387239401-13918-3-git-send-email-al.stone@linaro.org>
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
index 86d11a6..b91dcaa 100644
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
1.8.3.1
