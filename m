From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:43 +0100
Subject: [PATCH 7/7] ARM: zynq: Introduce zynq_slcr_unlock()
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <bf130aff62c16b98b2372c328ee593de92431c41.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call special function for unlocking SLCR.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/slcr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index f0f6a69..c1f1499 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -71,6 +71,18 @@ static int zynq_slcr_read(u32 *val, u32 offset)
 }

 /**
+ * zynq_slcr_unlock - Unlock SLCR registers
+ *
+ * return:	a negative value on error, 0 on success
+ */
+static inline int zynq_slcr_unlock(void)
+{
+	zynq_slcr_write(SLCR_UNLOCK_MAGIC, SLCR_UNLOCK_OFFSET);
+
+	return 0;
+}
+
+/**
  * zynq_slcr_system_reset - Reset the entire system.
  */
 void zynq_slcr_system_reset(void)
@@ -82,7 +94,7 @@ void zynq_slcr_system_reset(void)
 	 * Note that this seems to require raw i/o
 	 * functions or there's a lockup?
 	 */
-	writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK_OFFSET);
+	zynq_slcr_unlock();

 	/*
 	 * Clear 0x0F000000 bits of reboot status register to workaround
@@ -164,7 +176,7 @@ int __init zynq_early_slcr_init(void)
 	np->data = (__force void *)zynq_slcr_base;

 	/* unlock the SLCR so that registers can be changed */
-	writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK_OFFSET);
+	zynq_slcr_unlock();

 	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/38ae2957/attachment.sig>
