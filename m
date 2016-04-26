From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:36 +1000
Subject: [PATCH 01/11] soc: renesas: Move pm-rcar to
 drivers/soc/renesas/rcar-sysc
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <be32bcbbd18213803ff24e480340d4d2cca1df4f.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Move the pm-rcar driver from arch/arm/mach-shmobile/ to
drivers/soc/renesas/, and its header file to include/linux/soc/renesas/,
so it can be shared between arm32 (R-Car H1 and Gen2) and arm64 (R-Car
Gen3). Rename it to rcar-sysc as it's really a driver for the R-Car
System Controller (SYSC).

Kill the intermediate PM_RCAR config symbol, as it's not user
configurable anymore, and to prepare for SoC-specific make rules.

Add the missing #include <linux/types.h> to rcar-sysc.h, which was
exposed by different include order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS                           |   4 +
 arch/arm/mach-shmobile/Kconfig        |  11 +--
 arch/arm/mach-shmobile/Makefile       |   1 -
 arch/arm/mach-shmobile/pm-r8a7779.c   |   3 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c |   2 +-
 arch/arm/mach-shmobile/pm-rcar.c      | 164 ----------------------------------
 arch/arm/mach-shmobile/pm-rcar.h      |  15 ----
 arch/arm/mach-shmobile/smp-r8a7779.c  |   2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c  |   2 +-
 drivers/soc/Makefile                  |   3 +-
 drivers/soc/renesas/Makefile          |   5 ++
 drivers/soc/renesas/rcar-sysc.c       | 164 ++++++++++++++++++++++++++++++++++
 include/linux/soc/renesas/rcar-sysc.h |  17 ++++
 13 files changed, 201 insertions(+), 192 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.c
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.h
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/rcar-sysc.c
 create mode 100644 include/linux/soc/renesas/rcar-sysc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7c88eb..a0e23922a90b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1491,6 +1491,8 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
+F:	drivers/soc/renesas/
+F:	include/linux/soc/renesas/
 
 ARM/RISCPC ARCHITECTURE
 M:	Russell King <linux@arm.linux.org.uk>
@@ -1604,6 +1606,8 @@ F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
+F:	drivers/soc/renesas/
+F:	include/linux/soc/renesas/
 
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f2bc5c353119..fe4ccb52f921 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,11 +4,6 @@ config ARCH_SHMOBILE
 config ARCH_SHMOBILE_MULTI
 	bool
 
-config PM_RCAR
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -16,13 +11,15 @@ config PM_RMOBILE
 
 config ARCH_RCAR_GEN1
 	bool
-	select PM_RCAR
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
-	select PM_RCAR
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index a65c80ac9009..ebb909c55b85 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,7 +39,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 14c42a1bdf1e..4174cbcbc467 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -9,9 +9,10 @@
  * for more details.
  */
 
+#include <linux/soc/renesas/rcar-sysc.h>
+
 #include <asm/io.h>
 
-#include "pm-rcar.h"
 #include "r8a7779.h"
 
 /* SYSC */
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 6815781ad116..691ac166a277 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
 #include "common.h"
-#include "pm-rcar.h"
 #include "rcar-gen2.h"
 
 /* RST */
diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
deleted file mode 100644
index 0af05d288b09..000000000000
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- * R-Car SYSC Power management support
- *
- * Copyright (C) 2014  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include "pm-rcar.h"
-
-/* SYSC Common */
-#define SYSCSR			0x00	/* SYSC Status Register */
-#define SYSCISR			0x04	/* Interrupt Status Register */
-#define SYSCISCR		0x08	/* Interrupt Status Clear Register */
-#define SYSCIER			0x0c	/* Interrupt Enable Register */
-#define SYSCIMR			0x10	/* Interrupt Mask Register */
-
-/* SYSC Status Register */
-#define SYSCSR_PONENB		1	/* Ready for power resume requests */
-#define SYSCSR_POFFENB		0	/* Ready for power shutoff requests */
-
-/*
- * Power Control Register Offsets inside the register block for each domain
- * Note: The "CR" registers for ARM cores exist on H1 only
- *       Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
- */
-#define PWRSR_OFFS		0x00	/* Power Status Register */
-#define PWROFFCR_OFFS		0x04	/* Power Shutoff Control Register */
-#define PWROFFSR_OFFS		0x08	/* Power Shutoff Status Register */
-#define PWRONCR_OFFS		0x0c	/* Power Resume Control Register */
-#define PWRONSR_OFFS		0x10	/* Power Resume Status Register */
-#define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
-
-
-#define SYSCSR_RETRIES		100
-#define SYSCSR_DELAY_US		1
-
-#define PWRER_RETRIES		100
-#define PWRER_DELAY_US		1
-
-#define SYSCISR_RETRIES		1000
-#define SYSCISR_DELAY_US	1
-
-static void __iomem *rcar_sysc_base;
-static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
-
-static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
-{
-	unsigned int sr_bit, reg_offs;
-	int k;
-
-	if (on) {
-		sr_bit = SYSCSR_PONENB;
-		reg_offs = PWRONCR_OFFS;
-	} else {
-		sr_bit = SYSCSR_POFFENB;
-		reg_offs = PWROFFCR_OFFS;
-	}
-
-	/* Wait until SYSC is ready to accept a power request */
-	for (k = 0; k < SYSCSR_RETRIES; k++) {
-		if (ioread32(rcar_sysc_base + SYSCSR) & BIT(sr_bit))
-			break;
-		udelay(SYSCSR_DELAY_US);
-	}
-
-	if (k == SYSCSR_RETRIES)
-		return -EAGAIN;
-
-	/* Submit power shutoff or power resume request */
-	iowrite32(BIT(sysc_ch->chan_bit),
-		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
-
-	return 0;
-}
-
-static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
-{
-	unsigned int isr_mask = BIT(sysc_ch->isr_bit);
-	unsigned int chan_mask = BIT(sysc_ch->chan_bit);
-	unsigned int status;
-	unsigned long flags;
-	int ret = 0;
-	int k;
-
-	spin_lock_irqsave(&rcar_sysc_lock, flags);
-
-	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
-
-	/* Submit power shutoff or resume request until it was accepted */
-	for (k = 0; k < PWRER_RETRIES; k++) {
-		ret = rcar_sysc_pwr_on_off(sysc_ch, on);
-		if (ret)
-			goto out;
-
-		status = ioread32(rcar_sysc_base +
-				  sysc_ch->chan_offs + PWRER_OFFS);
-		if (!(status & chan_mask))
-			break;
-
-		udelay(PWRER_DELAY_US);
-	}
-
-	if (k == PWRER_RETRIES) {
-		ret = -EIO;
-		goto out;
-	}
-
-	/* Wait until the power shutoff or resume request has completed * */
-	for (k = 0; k < SYSCISR_RETRIES; k++) {
-		if (ioread32(rcar_sysc_base + SYSCISR) & isr_mask)
-			break;
-		udelay(SYSCISR_DELAY_US);
-	}
-
-	if (k == SYSCISR_RETRIES)
-		ret = -EIO;
-
-	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
-
- out:
-	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
-
-	pr_debug("sysc power domain %d: %08x -> %d\n",
-		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
-	return ret;
-}
-
-int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, false);
-}
-
-int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, true);
-}
-
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
-{
-	unsigned int st;
-
-	st = ioread32(rcar_sysc_base + sysc_ch->chan_offs + PWRSR_OFFS);
-	if (st & BIT(sysc_ch->chan_bit))
-		return true;
-
-	return false;
-}
-
-void __iomem *rcar_sysc_init(phys_addr_t base)
-{
-	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
-	if (!rcar_sysc_base)
-		panic("unable to ioremap R-Car SYSC hardware block\n");
-
-	return rcar_sysc_base;
-}
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
deleted file mode 100644
index 1b901db4a24c..000000000000
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef PM_RCAR_H
-#define PM_RCAR_H
-
-struct rcar_sysc_ch {
-	u16 chan_offs;
-	u8 chan_bit;
-	u8 isr_bit;
-};
-
-int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
-int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
-void __iomem *rcar_sysc_init(phys_addr_t base);
-
-#endif /* PM_RCAR_H */
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index f5c31fbc10b2..c6951ee24588 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -19,13 +19,13 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
 #include "common.h"
-#include "pm-rcar.h"
 #include "r8a7779.h"
 
 #define AVECR IOMEM(0xfe700040)
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index f6426c6fdefc..28f26d5362d8 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -17,12 +17,12 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 
 #include <asm/smp_plat.h>
 
 #include "common.h"
 #include "platsmp-apmu.h"
-#include "pm-rcar.h"
 #include "rcar-gen2.h"
 #include "r8a7790.h"
 
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ade71306ee1..380230f03874 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
-obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
+obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
+obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
new file mode 100644
index 000000000000..2b64f6c94681
--- /dev/null
+++ b/drivers/soc/renesas/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
new file mode 100644
index 000000000000..d59bcdf78f0b
--- /dev/null
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -0,0 +1,164 @@
+/*
+ * R-Car SYSC Power management support
+ *
+ * Copyright (C) 2014  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/soc/renesas/rcar-sysc.h>
+
+/* SYSC Common */
+#define SYSCSR			0x00	/* SYSC Status Register */
+#define SYSCISR			0x04	/* Interrupt Status Register */
+#define SYSCISCR		0x08	/* Interrupt Status Clear Register */
+#define SYSCIER			0x0c	/* Interrupt Enable Register */
+#define SYSCIMR			0x10	/* Interrupt Mask Register */
+
+/* SYSC Status Register */
+#define SYSCSR_PONENB		1	/* Ready for power resume requests */
+#define SYSCSR_POFFENB		0	/* Ready for power shutoff requests */
+
+/*
+ * Power Control Register Offsets inside the register block for each domain
+ * Note: The "CR" registers for ARM cores exist on H1 only
+ *       Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
+ */
+#define PWRSR_OFFS		0x00	/* Power Status Register */
+#define PWROFFCR_OFFS		0x04	/* Power Shutoff Control Register */
+#define PWROFFSR_OFFS		0x08	/* Power Shutoff Status Register */
+#define PWRONCR_OFFS		0x0c	/* Power Resume Control Register */
+#define PWRONSR_OFFS		0x10	/* Power Resume Status Register */
+#define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
+
+
+#define SYSCSR_RETRIES		100
+#define SYSCSR_DELAY_US		1
+
+#define PWRER_RETRIES		100
+#define PWRER_DELAY_US		1
+
+#define SYSCISR_RETRIES		1000
+#define SYSCISR_DELAY_US	1
+
+static void __iomem *rcar_sysc_base;
+static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
+
+static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
+{
+	unsigned int sr_bit, reg_offs;
+	int k;
+
+	if (on) {
+		sr_bit = SYSCSR_PONENB;
+		reg_offs = PWRONCR_OFFS;
+	} else {
+		sr_bit = SYSCSR_POFFENB;
+		reg_offs = PWROFFCR_OFFS;
+	}
+
+	/* Wait until SYSC is ready to accept a power request */
+	for (k = 0; k < SYSCSR_RETRIES; k++) {
+		if (ioread32(rcar_sysc_base + SYSCSR) & BIT(sr_bit))
+			break;
+		udelay(SYSCSR_DELAY_US);
+	}
+
+	if (k == SYSCSR_RETRIES)
+		return -EAGAIN;
+
+	/* Submit power shutoff or power resume request */
+	iowrite32(BIT(sysc_ch->chan_bit),
+		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
+
+	return 0;
+}
+
+static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
+{
+	unsigned int isr_mask = BIT(sysc_ch->isr_bit);
+	unsigned int chan_mask = BIT(sysc_ch->chan_bit);
+	unsigned int status;
+	unsigned long flags;
+	int ret = 0;
+	int k;
+
+	spin_lock_irqsave(&rcar_sysc_lock, flags);
+
+	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
+
+	/* Submit power shutoff or resume request until it was accepted */
+	for (k = 0; k < PWRER_RETRIES; k++) {
+		ret = rcar_sysc_pwr_on_off(sysc_ch, on);
+		if (ret)
+			goto out;
+
+		status = ioread32(rcar_sysc_base +
+				  sysc_ch->chan_offs + PWRER_OFFS);
+		if (!(status & chan_mask))
+			break;
+
+		udelay(PWRER_DELAY_US);
+	}
+
+	if (k == PWRER_RETRIES) {
+		ret = -EIO;
+		goto out;
+	}
+
+	/* Wait until the power shutoff or resume request has completed * */
+	for (k = 0; k < SYSCISR_RETRIES; k++) {
+		if (ioread32(rcar_sysc_base + SYSCISR) & isr_mask)
+			break;
+		udelay(SYSCISR_DELAY_US);
+	}
+
+	if (k == SYSCISR_RETRIES)
+		ret = -EIO;
+
+	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
+
+ out:
+	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
+
+	pr_debug("sysc power domain %d: %08x -> %d\n",
+		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
+	return ret;
+}
+
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_power(sysc_ch, false);
+}
+
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_power(sysc_ch, true);
+}
+
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
+{
+	unsigned int st;
+
+	st = ioread32(rcar_sysc_base + sysc_ch->chan_offs + PWRSR_OFFS);
+	if (st & BIT(sysc_ch->chan_bit))
+		return true;
+
+	return false;
+}
+
+void __iomem *rcar_sysc_init(phys_addr_t base)
+{
+	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+	if (!rcar_sysc_base)
+		panic("unable to ioremap R-Car SYSC hardware block\n");
+
+	return rcar_sysc_base;
+}
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
new file mode 100644
index 000000000000..96f30c288388
--- /dev/null
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -0,0 +1,17 @@
+#ifndef __LINUX_SOC_RENESAS_RCAR_SYSC_H__
+#define __LINUX_SOC_RENESAS_RCAR_SYSC_H__
+
+#include <linux/types.h>
+
+struct rcar_sysc_ch {
+	u16 chan_offs;
+	u8 chan_bit;
+	u8 isr_bit;
+};
+
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
+void __iomem *rcar_sysc_init(phys_addr_t base);
+
+#endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
