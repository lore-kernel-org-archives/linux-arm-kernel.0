From: hs@denx.de (Heiko Schocher)
Date: Wed, 22 Feb 2012 07:50:06 +0100
Subject: [PATCH v2 3/7] ARM: davinci: mux: add OF support
In-Reply-To: <1329893410-24413-1-git-send-email-hs@denx.de>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
Message-ID: <1329893410-24413-4-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add support for configuring the pinmux on davinci SoC
through OF.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>

---
This patch is just a RFC, as I want to get rid of the pin
setup code in board code ... This patch introduces a
davinci_cfg_reg_of() function, which davinci drivers can call,
if they found a pinmux-handle, so used in the following
drivers in this patchserie:

drivers/net/ethernet/ti/davinci_emac
drivers/i2c/busses/i2c-davinci.c
drivers/mtd/nand/davinci_nand.c

Comments are welcome.

 .../devicetree/bindings/arm/davinci/mux.txt        |   40 +++++++++++
 arch/arm/mach-davinci/include/mach/mux.h           |    2 +
 arch/arm/mach-davinci/mux.c                        |   73 +++++++++++++++++++-
 3 files changed, 114 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/mux.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/mux.txt b/Documentation/devicetree/bindings/arm/davinci/mux.txt
new file mode 100644
index 0000000..ecb026a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/mux.txt
@@ -0,0 +1,40 @@
+* Texas Instruments Davinci pinmux
+
+This file provides information, what the device node for the
+davinci pinmux interface contain.
+
+Required properties:
+- compatible: "ti,davinci-pinmux";
+- pins : contains a table with the following colums:
+   mux register: pinmux register
+   register offset: offset in register, which to change
+   mode mask: mode mask
+   mode value: mode value
+
+Optional properties:
+- none
+
+Example (enbw_cmc board):
+	emac_pins: pinmux at 1c14120 {
+		compatible = "ti,davinci-pinmux";
+		reg = <0x14120 0x1000>;
+		pins = < /*	muxreg	maskoff	modemsk muxmode */
+				2	4	15	8 /* MII TXEN */
+				2	8	15	8 /* MII TXCLK */
+				2	12	15	8 /* MII COL */
+				2	16	15	8 /* MII TXD_3 */
+				2	20	15	8 /* MII TXD_2 */
+				2	24	15	8 /* MII TXD_1 */
+				2	28	15	8 /* MII TXD_0 */
+				3	8	15	8 /* MII RXER */
+				3	12	15	8 /* MII CRS */
+				3	0	15	8 /* MII RXCLK */
+				3	4	15	8 /* MII RXDV */
+				3	16	15	8 /* MII RXD_3 */
+				3	20	15	8 /* MII RXD_2 */
+				3	24	15	8 /* MII RXD_1 */
+				3	28	15	8 /* MII RXD_0 */
+				4	0	15	8 /* MDIO CLK */
+				4	4	15	8 /* MDIO D */
+			>;
+	};
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index a7e92fc..3a62857 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -1205,6 +1205,7 @@ enum davinci_tnetv107x_index {
 /* setup pin muxing */
 extern int davinci_cfg_reg(unsigned long reg_cfg);
 extern int davinci_cfg_reg_list(const short pins[]);
+extern int davinci_cfg_reg_of(struct device_node *);
 #else
 /* boot loader does it all (no warnings from CONFIG_DAVINCI_MUX_WARNINGS) */
 static inline int davinci_cfg_reg(unsigned long reg_cfg) { return 0; }
@@ -1212,6 +1213,7 @@ static inline int davinci_cfg_reg_list(const short pins[])
 {
 	return 0;
 }
+static int davinci_cfg_reg_of(struct device_node *) { return 0; };
 #endif
 
 #endif /* __INC_MACH_MUX_H */
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index f34a8dc..6b38072 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -18,18 +18,21 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
 
 #include <mach/mux.h>
 #include <mach/common.h>
 
 static void __iomem *pinmux_base;
+static DEFINE_SPINLOCK(mux_spin_lock);
 
 /*
  * Sets the DAVINCI MUX register based on the table
  */
 int __init_or_module davinci_cfg_reg(const unsigned long index)
 {
-	static DEFINE_SPINLOCK(mux_spin_lock);
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	unsigned long flags;
 	const struct mux_config *cfg;
@@ -98,6 +101,74 @@ int __init_or_module davinci_cfg_reg(const unsigned long index)
 }
 EXPORT_SYMBOL(davinci_cfg_reg);
 
+#ifdef CONFIG_OF
+int davinci_cfg_reg_of(struct device_node *np)
+{
+	unsigned long flags;
+	int pinmux_map_len;
+	const unsigned int *pinmux_map;
+	u32 muxreg, maskoff, modemsk, muxmode;
+	unsigned int reg_orig = 0, reg = 0;
+	unsigned int mask, warn = 0;
+
+	pinmux_map = of_get_property(np, "pins", &pinmux_map_len);
+	if (pinmux_map == NULL) {
+		printk(KERN_ERR "pins is not set!\n");
+		return -EINVAL;
+	}
+
+	pinmux_map_len /= sizeof(unsigned int);
+	if ((pinmux_map_len % 4) != 0) {
+		printk(KERN_ERR "pins format wrong!\n");
+		return -EINVAL;
+	}
+
+	if (!pinmux_base) {
+		pinmux_base = of_iomap(np, 0);
+		if (WARN_ON(!pinmux_base))
+			return -ENOMEM;
+	}
+
+	while (pinmux_map_len > 0) {
+		muxreg = be32_to_cpu(pinmux_map[0]);
+		maskoff = be32_to_cpu(pinmux_map[1]);
+		modemsk = be32_to_cpu(pinmux_map[2]);
+		muxmode = be32_to_cpu(pinmux_map[3]);
+
+		/* Update the mux register in question */
+		if (modemsk) {
+			unsigned	tmp1, tmp2;
+
+			spin_lock_irqsave(&mux_spin_lock, flags);
+			reg_orig = __raw_readl(pinmux_base + muxreg);
+
+			mask = (modemsk << maskoff);
+			tmp1 = reg_orig & mask;
+			reg = reg_orig & ~mask;
+
+			tmp2 = (muxmode << maskoff);
+			reg |= tmp2;
+
+			if (tmp1 != tmp2)
+				warn = 1;
+
+			__raw_writel(reg, pinmux_base + muxreg);
+			spin_unlock_irqrestore(&mux_spin_lock, flags);
+		}
+		pinmux_map += 4;
+		pinmux_map_len -= 4;
+	}
+
+	return 0;
+}
+#else
+int davinci_cfg_reg_of(struct device_node *np)
+{
+	return 0;
+}
+#endif
+EXPORT_SYMBOL(davinci_cfg_reg_of);
+
 int __init_or_module davinci_cfg_reg_list(const short pins[])
 {
 	int i, error = -EINVAL;
-- 
1.7.7.6
