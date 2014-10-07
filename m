From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:43 -0700
Subject: [PATCH 41/44] x86: pmc_atom: Register poweroff handler with kernel
 poweroff handler
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-42-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with a low priority value of 64 to reflect that
the original code only sets pm_power_off if it was not already set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kernel/pmc_atom.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 0c424a6..79331a2 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -20,6 +20,8 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
 
@@ -92,7 +94,8 @@ static inline void pmc_reg_write(struct pmc_dev *pmc, int reg_offset, u32 val)
 	writel(val, pmc->regmap + reg_offset);
 }
 
-static void pmc_power_off(void)
+static int pmc_power_off(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	u16	pm1_cnt_port;
 	u32	pm1_cnt_value;
@@ -107,8 +110,15 @@ static void pmc_power_off(void)
 	pm1_cnt_value |= SLEEP_ENABLE;
 
 	outl(pm1_cnt_value, pm1_cnt_port);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block pmc_poweroff_nb = {
+	.notifier_call = pmc_power_off,
+	.priority = 64,
+};
+
 static void pmc_hw_reg_setup(struct pmc_dev *pmc)
 {
 	/*
@@ -247,8 +257,12 @@ static int pmc_setup_dev(struct pci_dev *pdev)
 	acpi_base_addr &= ACPI_BASE_ADDR_MASK;
 
 	/* Install power off function */
-	if (acpi_base_addr != 0 && pm_power_off == NULL)
-		pm_power_off = pmc_power_off;
+	if (acpi_base_addr != 0) {
+		ret = register_poweroff_handler(&pmc_poweroff_nb);
+		if (ret)
+			dev_err(&pdev->dev,
+				"Failed to install poweroff handler\n");
+	}
 
 	pci_read_config_dword(pdev, PMC_BASE_ADDR_OFFSET, &pmc->base_addr);
 	pmc->base_addr &= PMC_BASE_ADDR_MASK;
-- 
1.9.1
