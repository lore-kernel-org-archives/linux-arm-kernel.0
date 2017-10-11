From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 11 Oct 2017 10:03:01 +0200
Subject: [PATCH 1/2] drivers: firmware: psci: Add psci_is_available()
In-Reply-To: <1507708982-12336-1-git-send-email-geert+renesas@glider.be>
References: <1507708982-12336-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1507708982-12336-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCI support may be disabled at build time (by configuration) or at
run-time (PSCI firmware not present).  While CONFIG_ARM_PSCI_FW can be
used to check for build time enablement, there is currently no simple
way to check if PSCI is actually available and used.

Hence add a helper function to check if PSCI is available.

This is useful for e.g. drivers that are used on platforms with and
without PSCI.  Such drivers may need to take provisions for proper
operation when PSCI is used, and/or to implement functionality that is
usually provided by PSCI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/firmware/psci.c | 5 +++++
 include/linux/psci.h    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index da469c972b503f83..a3a11e2d8ffffaaa 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -670,6 +670,11 @@ int __init psci_dt_init(void)
 	return init_fn(np);
 }
 
+bool psci_is_available(void)
+{
+	return psci_ops.cpu_off && psci_ops.cpu_on && psci_ops.cpu_suspend;
+}
+
 #ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
diff --git a/include/linux/psci.h b/include/linux/psci.h
index bdea1cb5e1db142b..2bdee325aeb80cf6 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -39,8 +39,10 @@ extern struct psci_operations psci_ops;
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+bool psci_is_available(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline bool psci_is_available(void) { return false; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
-- 
2.7.4
