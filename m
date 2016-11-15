From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Tue, 15 Nov 2016 15:09:54 +0800
Subject: [PATCH] reset: hisilicon: add a polarity cell for reset line specifier
Message-ID: <1479193794-18350-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a polarity cell for reset line specifier. If the reset line
is asserted when the register bit is 1, the polarity is
normal. Otherwise, it is inverted.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
 .../devicetree/bindings/clock/hisi-crg.txt         | 11 ++++---
 arch/arm/boot/dts/hi3519.dtsi                      |  2 +-
 drivers/clk/hisilicon/reset.c                      | 36 ++++++++++++++++------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
index e3919b6..fcbb4f3 100644
--- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
+++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
@@ -25,19 +25,20 @@ to specify the clock which they consume.
 
 All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
 
-- #reset-cells: should be 2.
+- #reset-cells: should be 3.
 
 A reset signal can be controlled by writing a bit register in the CRG module.
-The reset specifier consists of two cells. The first cell represents the
+The reset specifier consists of three cells. The first cell represents the
 register offset relative to the base address. The second cell represents the
-bit index in the register.
+bit index in the register. The third cell represents the polarity of the reset
+line (0 for normal, 1 for inverted).
 
 Example: CRG nodes
 CRG: clock-reset-controller at 12010000 {
 	compatible = "hisilicon,hi3519-crg";
 	reg = <0x12010000 0x10000>;
 	#clock-cells = <1>;
-	#reset-cells = <2>;
+	#reset-cells = <3>;
 };
 
 Example: consumer nodes
@@ -45,5 +46,5 @@ i2c0: i2c at 12110000 {
 	compatible = "hisilicon,hi3519-i2c";
 	reg = <0x12110000 0x1000>;
 	clocks = <&CRG HI3519_I2C0_RST>;
-	resets = <&CRG 0xe4 0>;
+	resets = <&CRG 0xe4 0 0>;
 };
diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
index 5729ecf..b7cb182 100644
--- a/arch/arm/boot/dts/hi3519.dtsi
+++ b/arch/arm/boot/dts/hi3519.dtsi
@@ -50,7 +50,7 @@
 	crg: clock-reset-controller at 12010000 {
 		compatible = "hisilicon,hi3519-crg";
 		#clock-cells = <1>;
-		#reset-cells = <2>;
+		#reset-cells = <3>;
 		reg = <0x12010000 0x10000>;
 	};
 
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 2a5015c..c0ab0b6 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -17,6 +17,7 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -25,9 +26,11 @@
 #include <linux/spinlock.h>
 #include "reset.h"
 
-#define	HISI_RESET_BIT_MASK	0x1f
-#define	HISI_RESET_OFFSET_SHIFT	8
-#define	HISI_RESET_OFFSET_MASK	0xffff00
+#define HISI_RESET_POLARITY_MASK	BIT(0)
+#define HISI_RESET_BIT_SHIFT	1
+#define HISI_RESET_BIT_MASK	GENMASK(6, 1)
+#define HISI_RESET_OFFSET_SHIFT	8
+#define HISI_RESET_OFFSET_MASK	GENMASK(23, 8)
 
 struct hisi_reset_controller {
 	spinlock_t	lock;
@@ -44,12 +47,15 @@ static int hisi_reset_of_xlate(struct reset_controller_dev *rcdev,
 {
 	u32 offset;
 	u8 bit;
+	bool polarity;
 
 	offset = (reset_spec->args[0] << HISI_RESET_OFFSET_SHIFT)
 		& HISI_RESET_OFFSET_MASK;
-	bit = reset_spec->args[1] & HISI_RESET_BIT_MASK;
+	bit = (reset_spec->args[1] << HISI_RESET_BIT_SHIFT)
+		& HISI_RESET_BIT_MASK;
+	polarity = reset_spec->args[2] & HISI_RESET_POLARITY_MASK;
 
-	return (offset | bit);
+	return (offset | bit | polarity);
 }
 
 static int hisi_reset_assert(struct reset_controller_dev *rcdev,
@@ -59,14 +65,19 @@ static int hisi_reset_assert(struct reset_controller_dev *rcdev,
 	unsigned long flags;
 	u32 offset, reg;
 	u8 bit;
+	bool polarity;
 
 	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
-	bit = id & HISI_RESET_BIT_MASK;
+	bit = (id & HISI_RESET_BIT_MASK) >> HISI_RESET_BIT_SHIFT;
+	polarity = id & HISI_RESET_POLARITY_MASK;
 
 	spin_lock_irqsave(&rstc->lock, flags);
 
 	reg = readl(rstc->membase + offset);
-	writel(reg | BIT(bit), rstc->membase + offset);
+	if (polarity)
+		writel(reg & ~BIT(bit), rstc->membase + offset);
+	else
+		writel(reg | BIT(bit), rstc->membase + offset);
 
 	spin_unlock_irqrestore(&rstc->lock, flags);
 
@@ -80,14 +91,19 @@ static int hisi_reset_deassert(struct reset_controller_dev *rcdev,
 	unsigned long flags;
 	u32 offset, reg;
 	u8 bit;
+	bool polarity;
 
 	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
-	bit = id & HISI_RESET_BIT_MASK;
+	bit = (id & HISI_RESET_BIT_MASK) >> HISI_RESET_BIT_SHIFT;
+	polarity = id & HISI_RESET_POLARITY_MASK;
 
 	spin_lock_irqsave(&rstc->lock, flags);
 
 	reg = readl(rstc->membase + offset);
-	writel(reg & ~BIT(bit), rstc->membase + offset);
+	if (polarity)
+		writel(reg | BIT(bit), rstc->membase + offset);
+	else
+		writel(reg & ~BIT(bit), rstc->membase + offset);
 
 	spin_unlock_irqrestore(&rstc->lock, flags);
 
@@ -118,7 +134,7 @@ struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
 	rstc->rcdev.owner = THIS_MODULE;
 	rstc->rcdev.ops = &hisi_reset_ops;
 	rstc->rcdev.of_node = pdev->dev.of_node;
-	rstc->rcdev.of_reset_n_cells = 2;
+	rstc->rcdev.of_reset_n_cells = 3;
 	rstc->rcdev.of_xlate = hisi_reset_of_xlate;
 	reset_controller_register(&rstc->rcdev);
 
-- 
1.9.1
