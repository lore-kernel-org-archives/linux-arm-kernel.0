From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 6 Apr 2016 20:09:42 -0500
Subject: [PATCHv3 7/8] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
Message-ID: <1459991382-7859-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Enable ECC for Arria10 On-Chip RAM on machine startup. The ECC has to
be enabled and memory initialized before data is stored in memory
otherwise the ECC will fail on reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: Add iounmap() and make ecc functions static inline.
v2: Add Arria10 ECC block initialization locally.
---
 arch/arm/mach-socfpga/ocram.c |  133 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
index 60ec643..10d6732 100644
--- a/arch/arm/mach-socfpga/ocram.c
+++ b/arch/arm/mach-socfpga/ocram.c
@@ -13,12 +13,15 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/genalloc.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
+#include "core.h"
+
 #define ALTR_OCRAM_CLEAR_ECC          0x00000018
 #define ALTR_OCRAM_ECC_EN             0x00000019
 
@@ -47,3 +50,133 @@ void socfpga_init_ocram_ecc(void)
 
 	iounmap(mapped_ocr_edac_addr);
 }
+
+/* Arria10 OCRAM Section */
+#define ALTR_A10_ECC_CTRL_OFST          0x08
+#define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
+#define ALTR_A10_ECC_INITA              BIT(16)
+
+#define ALTR_A10_ECC_INITSTAT_OFST      0x0C
+#define ALTR_A10_ECC_INITCOMPLETEA      BIT(0)
+#define ALTR_A10_ECC_INITCOMPLETEB      BIT(8)
+
+#define ALTR_A10_ECC_ERRINTEN_OFST      0x10
+#define ALTR_A10_ECC_SERRINTEN          BIT(0)
+
+#define ALTR_A10_ECC_INTSTAT_OFST       0x20
+#define ALTR_A10_ECC_SERRPENA           BIT(0)
+#define ALTR_A10_ECC_DERRPENA           BIT(8)
+#define ALTR_A10_ECC_ERRPENA_MASK       (ALTR_A10_ECC_SERRPENA | \
+					 ALTR_A10_ECC_DERRPENA)
+/* ECC Manager Defines */
+#define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
+#define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
+#define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+
+#define ALTR_A10_ECC_INIT_WATCHDOG_10US   10000
+
+static inline void ecc_set_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	value |= bit_mask;
+	writel(value, ioaddr);
+}
+
+static inline void ecc_clear_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	value &= ~bit_mask;
+	writel(value, ioaddr);
+}
+
+static inline int ecc_test_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	return (value & bit_mask) ? 1 : 0;
+}
+
+/*
+ * This function uses the memory initialization block in the Arria10 ECC
+ * controller to initialize/clear the entire memory data and ECC data.
+ */
+static int altr_init_memory_port(void __iomem *ioaddr)
+{
+	int limit = ALTR_A10_ECC_INIT_WATCHDOG_10US;
+
+	ecc_set_bits(ALTR_A10_ECC_INITA, (ioaddr + ALTR_A10_ECC_CTRL_OFST));
+	while (limit--) {
+		if (ecc_test_bits(ALTR_A10_ECC_INITCOMPLETEA,
+				  (ioaddr + ALTR_A10_ECC_INITSTAT_OFST)))
+			break;
+		udelay(1);
+	}
+	if (limit < 0)
+		return -EBUSY;
+
+	/* Clear any pending ECC interrupts */
+	writel(ALTR_A10_ECC_ERRPENA_MASK,
+	       (ioaddr + ALTR_A10_ECC_INTSTAT_OFST));
+
+	return 0;
+}
+
+void socfpga_init_arria10_ocram_ecc(void)
+{
+	struct device_node *np;
+	int ret = 0;
+	void __iomem *ecc_block_base;
+
+	if (!sys_manager_base_addr) {
+		pr_err("SOCFPGA: sys-mgr is not initialized\n");
+		return;
+	}
+
+	/* Find the OCRAM EDAC device tree node */
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-a10-ocram-ecc");
+	if (!np) {
+		pr_err("Unable to find socfpga-a10-ocram-ecc\n");
+		return;
+	}
+
+	/* Map the ECC Block */
+	ecc_block_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!ecc_block_base) {
+		pr_err("Unable to map OCRAM ECC block\n");
+		return;
+	}
+
+	/* Disable ECC */
+	writel(ALTR_A10_OCRAM_ECC_EN_CTL,
+	       sys_manager_base_addr + A10_SYSMGR_ECC_INTMASK_SET_OFST);
+	ecc_clear_bits(ALTR_A10_ECC_SERRINTEN,
+		       (ecc_block_base + ALTR_A10_ECC_ERRINTEN_OFST));
+	ecc_clear_bits(ALTR_A10_OCRAM_ECC_EN_CTL,
+		       (ecc_block_base + ALTR_A10_ECC_CTRL_OFST));
+
+	/* Ensure all writes complete */
+	wmb();
+
+	/* Use HW initialization block to initialize memory for ECC */
+	ret = altr_init_memory_port(ecc_block_base);
+	if (ret) {
+		pr_err("ECC: cannot init OCRAM PORTA memory\n");
+		goto exit;
+	}
+
+	/* Enable ECC */
+	ecc_set_bits(ALTR_A10_OCRAM_ECC_EN_CTL,
+		     (ecc_block_base + ALTR_A10_ECC_CTRL_OFST));
+	ecc_set_bits(ALTR_A10_ECC_SERRINTEN,
+		     (ecc_block_base + ALTR_A10_ECC_ERRINTEN_OFST));
+	writel(ALTR_A10_OCRAM_ECC_EN_CTL,
+	       sys_manager_base_addr + A10_SYSMGR_ECC_INTMASK_CLR_OFST);
+
+	/* Ensure all writes complete */
+	wmb();
+exit:
+	iounmap(ecc_block_base);
+}
-- 
1.7.9.5
