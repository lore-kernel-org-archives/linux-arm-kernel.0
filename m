From: al.stone@linaro.org (al.stone at linaro.org)
Date: Wed,  4 Dec 2013 14:22:04 -0700
Subject: [PATCH v3 2/5] ACPI: bus master reload not supported in reduced HW
 mode
In-Reply-To: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Message-ID: <1386192127-28564-3-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Remove the saving and restoring of bus master reload registers in
suspend/resume when in reduced HW mode; according to the spec, no
such registers should exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..8b48c08 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 
 #endif
 
-#ifdef CONFIG_PM_SLEEP
+#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
 static u32 saved_bm_rld;
 
 static int acpi_processor_suspend(void)
@@ -236,7 +236,10 @@ void acpi_processor_syscore_exit(void)
 {
 	unregister_syscore_ops(&acpi_processor_syscore_ops);
 }
-#endif /* CONFIG_PM_SLEEP */
+#else
+void acpi_processor_syscore_init(void) { return; }
+void acpi_processor_syscore_exit(void) { return; }
+#endif
 
 #if defined(CONFIG_X86)
 static void tsc_check_state(int state)
-- 
1.8.3.1
