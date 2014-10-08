From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 7 Oct 2014 22:27:00 -0700
Subject: [PATCH 1/6] ARM: cygnus: Initial support for Broadcom Cygnus SoC
In-Reply-To: <1412746025-11998-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1412746025-11998-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1412746025-11998-2-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathar@broadcom.com>

Adds initial support for the Cygnus SoC based on Broadcom?s iProc series.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Desmond Liu <desmondl@broadcom.com>
Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig      |   31 ++++++++
 arch/arm/mach-bcm/Makefile     |    3 +
 arch/arm/mach-bcm/bcm_cygnus.c |  166 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 arch/arm/mach-bcm/bcm_cygnus.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc93800..2dd3f78 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -5,6 +5,37 @@ menuconfig ARCH_BCM
 
 if ARCH_BCM
 
+config ARCH_BCM_IPROC
+	bool "Broadcom ARMv7 iProc boards" if ARCH_MULTI_V7
+	select ARM_GIC
+	select CACHE_L2X0
+	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_CLK
+	select CLKSRC_OF
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select ARM_GLOBAL_TIMER
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select PINCTRL
+	select DEBUG_UART_8250
+	help
+	  This enables support for systems based on Broadcom IPROC architected SoCs.
+	  The IPROC complex contains one or more ARM CPUs along with common
+	  core periperals. Application specific SoCs are created by adding a
+	  uArchitecture containing peripherals outside of the IPROC complex.
+	  Currently supported SoCs are Cygnus.
+
+menu "iProc SoC based Machine types"
+	depends on ARCH_BCM_IPROC
+
+	config ARCH_BCM_CYGNUS
+		bool "Support Broadcom Cygnus board"
+		select USB_ARCH_HAS_EHCI if USB_SUPPORT
+		help
+		  Support for Broadcom Cygnus SoC.
+endmenu
+
 config ARCH_BCM_MOBILE
 	bool "Broadcom Mobile SoC Support" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index b19a396..46e092a 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -10,6 +10,9 @@
 # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
+# Cygnus
+obj-$(CONFIG_ARCH_BCM_CYGNUS) +=  bcm_cygnus.o
+
 # BCM281XX
 obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
 
diff --git a/arch/arm/mach-bcm/bcm_cygnus.c b/arch/arm/mach-bcm/bcm_cygnus.c
new file mode 100644
index 0000000..8e430ed
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm_cygnus.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright 2014 Broadcom Corporation.  All rights reserved.
+ *
+ * Unless you and Broadcom execute a separate written software license
+ * agreement governing use of this software, this software is licensed to you
+ * under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/proc-fns.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#define CRMU_MAIL_BOX1      0x03024028
+#define CRMU_SOFT_RESET_CMD 0xFFFFFFFF
+
+/* CRU_RESET register */
+static void * __iomem crmu_mail_box1_reg;
+
+#ifdef CONFIG_NEON
+
+#define CRU_BASE                  0x1800e000
+#define CRU_SIZE                  0x34
+#define CRU_CONTROL_OFFSET        0x0
+#define CRU_PWRDWN_EN_OFFSET      0x4
+#define CRU_PWRDWN_STATUS_OFFSET  0x8
+#define CRU_NEON0_HW_RESET  6
+#define CRU_CLAMP_ON_NEON0  20
+#define CRU_PWRONIN_NEON0   21
+#define CRU_PWRONOUT_NEON0  21
+#define CRU_PWROKIN_NEON0   22
+#define CRU_PWROKOUT_NEON0  22
+#define CRU_STATUS_DELAY_NS 500
+#define CRU_MAX_RETRY_COUNT 10
+#define CRU_RETRY_INTVL_US  1
+
+/* Power up the NEON/VFPv3 block. */
+static void bcm_cygnus_powerup_neon(void)
+{
+	void * __iomem cru_base = ioremap(CRU_BASE, CRU_SIZE);
+	u32 reg, i;
+
+	if (WARN_ON(!cru_base))
+		return;
+
+	/* De-assert the neon hardware block reset */
+	reg = readl(cru_base + CRU_CONTROL_OFFSET);
+	reg &= ~(1 << CRU_NEON0_HW_RESET);
+	writel(reg, cru_base + CRU_CONTROL_OFFSET);
+
+	/* Assert the power ON register bit */
+	reg = readl(cru_base + CRU_PWRDWN_EN_OFFSET);
+	reg |= (1 << CRU_PWRONIN_NEON0);
+	writel(reg, cru_base + CRU_PWRDWN_EN_OFFSET);
+
+	/*
+	 * Wait up to 10 usec in 1 usec increments for the
+	 * status register to acknowledge the power ON assert
+	 */
+	for (i = 0; i < CRU_MAX_RETRY_COUNT; i++) {
+		reg = readl(cru_base + CRU_PWRDWN_STATUS_OFFSET);
+		if (reg & CRU_PWRONOUT_NEON0)
+			break;
+
+		udelay(CRU_RETRY_INTVL_US);
+	}
+
+	if (WARN_ON(i == CRU_MAX_RETRY_COUNT))
+		goto neon_unmap;
+
+	/* Wait 0.5 usec = 500 nsec */
+	ndelay(CRU_STATUS_DELAY_NS);
+
+	/* Assert the power OK register bit */
+	reg = readl(cru_base + CRU_PWRDWN_EN_OFFSET);
+	reg |= (1 << CRU_PWROKIN_NEON0);
+	writel(reg, cru_base + CRU_PWRDWN_EN_OFFSET);
+
+	/*
+	 * Wait up to 10 usec in 1 usec increments for the
+	 * status register to acknowledge the power OK assert
+	 */
+	for (i = 0; i < CRU_MAX_RETRY_COUNT; i++) {
+		reg = readl(cru_base + CRU_PWRDWN_STATUS_OFFSET);
+		if (reg & CRU_PWROKOUT_NEON0)
+			break;
+
+		udelay(CRU_RETRY_INTVL_US);
+	}
+
+	if (WARN_ON(i == CRU_MAX_RETRY_COUNT))
+		goto neon_unmap;
+
+	/* Wait 0.5 usec = 500 nsec */
+	ndelay(CRU_STATUS_DELAY_NS);
+
+	/* Set the logic clamp for the neon block */
+	reg = readl(cru_base + CRU_PWRDWN_EN_OFFSET);
+	reg &= ~(1 << CRU_CLAMP_ON_NEON0);
+	writel(reg, cru_base + CRU_PWRDWN_EN_OFFSET);
+
+	/* Wait 0.5 usec = 500 nsec */
+	ndelay(CRU_STATUS_DELAY_NS);
+
+	/* Reset the neon hardware block */
+	reg = readl(cru_base + CRU_CONTROL_OFFSET);
+	reg |= (1 << CRU_NEON0_HW_RESET);
+	writel(reg, cru_base + CRU_CONTROL_OFFSET);
+
+neon_unmap:
+	iounmap(cru_base);
+}
+#endif /* CONFIG_NEON */
+
+static void __init bcm_cygnus_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	l2x0_of_init(0, ~0UL);
+
+	crmu_mail_box1_reg = ioremap(CRMU_MAIL_BOX1, SZ_4);
+	WARN_ON(!crmu_mail_box1_reg);
+
+#ifdef CONFIG_NEON
+	bcm_cygnus_powerup_neon();
+#endif
+}
+
+/*
+ * Reset the system
+ */
+void bcm_cygnus_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Send reset command to M0 via Mailbox. */
+	if (crmu_mail_box1_reg) {
+		writel(CRMU_SOFT_RESET_CMD, crmu_mail_box1_reg);
+		iounmap(crmu_mail_box1_reg);
+	}
+
+	/* Wait for M0 to reset the chip. */
+	while (1)
+		cpu_do_idle();
+}
+
+static const char const *bcm_cygnus_dt_compat[] = {
+	"brcm,cygnus",
+	NULL,
+};
+
+DT_MACHINE_START(BCM_CYGNUS_DT, "Broadcom Cygnus SoC")
+	.init_machine = bcm_cygnus_init,
+	.map_io = debug_ll_io_init,
+	.dt_compat = bcm_cygnus_dt_compat,
+	.restart   = bcm_cygnus_restart
+MACHINE_END
-- 
1.7.9.5
