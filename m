From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:09:58 -0700
Subject: [PATCH v2 5/9] ARM: BCM63xx: Add Broadcom BCM63xx PMB controller
 helpers
In-Reply-To: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
References: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830602-10988-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds both common register definitions and helper functions
used to issue read/write commands to the Broadcom BCM63xx PMB controller
which is used to power on and release from reset internal on-chip
peripherals such as the integrated Ethernet switch, AHCI, USB, as well
as the secondary CPU core.

This is going to be utilized by the BCM63138 SMP code, as well as by the
BCM63138 reset controller later.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/bcm63xx_pmb.h | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 include/linux/bcm63xx_pmb.h

diff --git a/include/linux/bcm63xx_pmb.h b/include/linux/bcm63xx_pmb.h
new file mode 100644
index 000000000000..2a2ea1bfb6cf
--- /dev/null
+++ b/include/linux/bcm63xx_pmb.h
@@ -0,0 +1,76 @@
+#ifndef __BCM63XX_PMB_H
+#define __BCM63XX_PMB_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+/* PMB Master controller register */
+#define PMB_CTRL		0x00
+#define  PMC_PMBM_START		(1 << 31)
+#define  PMC_PMBM_TIMEOUT	(1 << 30)
+#define  PMC_PMBM_SLAVE_ERR	(1 << 29)
+#define  PMC_PMBM_BUSY		(1 << 28)
+#define  PMC_PMBM_READ		(0 << 20)
+#define  PMC_PMBM_WRITE		(1 << 20)
+#define PMB_WR_DATA		0x04
+#define PMB_TIMEOUT		0x08
+#define PMB_RD_DATA		0x0C
+
+#define PMB_BUS_ID_SHIFT	8
+
+/* Perform the low-level PMB master operation, shared between reads and
+ * writes, caller must hold the spinlock
+ */
+static inline int __bpcm_do_op(void __iomem *master, unsigned int addr,
+			       u32 off, u32 op)
+{
+	unsigned int timeout = 1000;
+	u32 cmd;
+
+	cmd = (PMC_PMBM_START | op | (addr & 0xff) << 12 | off);
+	__raw_writel(cmd, master + PMB_CTRL);
+	do {
+		cmd = __raw_readl(master + PMB_CTRL);
+		if (!(cmd & PMC_PMBM_START))
+			return 0;
+
+		if (cmd & PMC_PMBM_SLAVE_ERR)
+			return -EIO;
+
+		if (cmd & PMC_PMBM_TIMEOUT)
+			return -ETIMEDOUT;
+
+		udelay(1);
+	} while (timeout-- > 0);
+
+	return -ETIMEDOUT;
+}
+
+static inline int bpcm_rd(void __iomem *master, unsigned int addr,
+			  u32 off, u32 *val)
+{
+	int ret = 0;
+
+	ret = __bpcm_do_op(master, addr, off >> 2, PMC_PMBM_READ);
+	*val = __raw_readl(master + PMB_RD_DATA);
+
+	return ret;
+}
+
+static inline int bpcm_wr(void __iomem *master, unsigned int addr,
+			  u32 off, u32 val)
+{
+	int ret = 0;
+
+	__raw_writel(val, master + PMB_WR_DATA);
+	/* Ensure that writes to the PMB_WR_DATA registers are taken
+	 * into account before attempting to start the PMB transaction
+	 */
+	mb();
+	ret = __bpcm_do_op(master, addr, off >> 2, PMC_PMBM_WRITE);
+
+	return ret;
+}
+
+#endif /* __BCM63XX_PMB_H */
-- 
2.1.0
