From: mturquette@linaro.org (Daniel Drake)
Date: Mon, 05 Aug 2013 15:00:57 -0700
Subject: [PATCH RESEND 2/2] clk: mmp: add support for DT-defined clocks
Message-ID: <20130805220057.5348.98721@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to the existing mmp clock drivers for clocks to be defined
in the device tree. This will be used on OLPC MMP2/MMP3-based laptops.

If clock info cannot be found in the device tree, we fall back to the
static clock initialization already present.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 .../devicetree/bindings/clock/mmp-apbc.txt         | 30 ++++++++++
 .../devicetree/bindings/clock/mmp-apmu.txt         | 30 ++++++++++
 drivers/clk/mmp/clk-apbc.c                         | 66 +++++++++++++++++++++-
 drivers/clk/mmp/clk-apmu.c                         | 37 +++++++++++-
 drivers/clk/mmp/clk-mmp2.c                         | 19 ++++++-
 5 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mmp-apbc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mmp-apmu.txt

Resending after a month without review.

diff --git a/Documentation/devicetree/bindings/clock/mmp-apbc.txt b/Documentation/devicetree/bindings/clock/mmp-apbc.txt
new file mode 100644
index 0000000..88e1253
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mmp-apbc.txt
@@ -0,0 +1,30 @@
+* Clock bindings for Marvell MMP Advanced Peripheral Bus clock
+
+Parent apb-clock node
+=====================
+Required properties:
+- reg: Address and length of the APB clock unit registers
+
+
+Child peripheral clock nodes
+============================
+Required properties:
+- compatible : shall be "marvell,mmp-apb-clock"
+- #clock-cells : from common clock binding; shall be set to 1
+- clocks : parent clock, from common clock binding
+- clock-output-names : Array of clock names, from common clock binding
+- reg : Array of control register offsets into APB clock unit register space
+
+
+Example:
+apbc: apb-clock {
+       reg = <0xd4015000 0x1000>;
+
+       twsi-clocks {
+               compatible = "marvell,mmp-apb-clock";
+               #clock-cells = <1>;
+               clocks = <&vctvxo-clock>;
+               clock-output-names = "TWSI0", "TWSI1";
+               reg = <0x04 0x08>;
+       };
+};
diff --git a/Documentation/devicetree/bindings/clock/mmp-apmu.txt b/Documentation/devicetree/bindings/clock/mmp-apmu.txt
new file mode 100644
index 0000000..18bb0f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mmp-apmu.txt
@@ -0,0 +1,30 @@
+* Clock bindings for Marvell MMP Application Subsystem Power Management Unit
+
+Parent apmu-clock node
+=====================
+Required properties:
+- reg: Address and length of the CPU Subsystem PMU registers
+
+
+Child peripheral clock nodes
+============================
+Required properties:
+- compatible : shall be "marvell,mmp-apmu-clock"
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : parent clock, from common clock binding
+- reg : Control register offsets into parent register space
+- enable-mask : The bits to be set in the register to enable the clock, or
+                cleared to disable.
+
+Example:
+apmu-clock {
+       reg = <0xd4282800 0x1000>;
+
+       usb-clock {
+               compatible = "marvell,mmp-apmu-clock";
+               #clock-cells = <0>;
+               clocks = <&usb_pll>;
+               reg = <0x5c>;
+               enable-mask = <0x09>;
+       };
+};
diff --git a/drivers/clk/mmp/clk-apbc.c b/drivers/clk/mmp/clk-apbc.c
index 89a146a..d53bc79 100644
--- a/drivers/clk/mmp/clk-apbc.c
+++ b/drivers/clk/mmp/clk-apbc.c
@@ -15,6 +15,8 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "clk.h"
 
@@ -129,8 +131,70 @@ struct clk *mmp_clk_register_apbc(const char *name, const char *parent_name,
        apbc->hw.init = &init;
 
        clk = clk_register(NULL, &apbc->hw);
-       if (IS_ERR(clk))
+       if (WARN_ON(IS_ERR(clk)))
                kfree(apbc);
 
        return clk;
 }
+
+static void __init mmp_apbc_dt_init(struct device_node *node)
+{
+       struct device_node *parent = of_get_parent(node);
+       const __be32 *regs;
+       struct clk *clk;
+       int rc;
+       int len;
+       int num_clocks;
+       int clock_num;
+       void __iomem *baseaddr;
+       const char *clock_name;
+       const char *parent_name;
+       struct clk **clks;
+       struct clk_onecell_data *clk_data;
+
+       regs = of_get_property(node, "reg", &len);
+       if (WARN_ON(!regs || (len % sizeof(__be32) != 0)))
+               return;
+       num_clocks = len / sizeof(__be32);
+
+       baseaddr = of_iomap(parent, 0);
+       of_node_put(parent);
+       if (WARN_ON(!baseaddr))
+               return;
+
+       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+       if (WARN_ON(!clk_data))
+               goto err_clk_data;
+
+       clks = kzalloc(num_clocks * sizeof(*clks), GFP_KERNEL);
+       if (WARN_ON(!clks))
+               goto err_clks;
+
+       clock_name = of_get_property(node, "clock-output-names", NULL);
+       parent_name = of_clk_get_parent_name(node, 0);
+
+       for (clock_num = 0; clock_num < num_clocks; clock_num++) {
+               void __iomem *clock_addr;
+               clock_addr = baseaddr + be32_to_cpup(regs + clock_num);
+
+               clk = mmp_clk_register_apbc(clock_name, parent_name,
+                                           clock_addr, 10, 0);

Looks like mmp_clk_register_apbc is missing an argument for the
spinlock. I'm getting the following:

drivers/clk/mmp/clk-apbc.c: In function ?mmp_apbc_dt_init?:
drivers/clk/mmp/clk-apbc.c|197 col 10| error: too few arguments to
function ?mmp_clk_register_apbc?

Regards,
Mike

+               if (IS_ERR(clk))
+                       return;
+               clock_name += strlen(clock_name) + 1;
+               clks[clock_num] = clk;
+       }
+
+       clk_data->clk_num = num_clocks;
+       clk_data->clks = clks;
+       rc = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+       WARN_ON(rc);
+       return;
+
+err_clks:
+       kfree(clk_data);
+err_clk_data:
+       iounmap(baseaddr);
+
+}
+CLK_OF_DECLARE(mmp2_apbc, "marvell,mmp-apb-clock", mmp_apbc_dt_init);
diff --git a/drivers/clk/mmp/clk-apmu.c b/drivers/clk/mmp/clk-apmu.c
index 4f4d8c5..dfcecc9 100644
--- a/drivers/clk/mmp/clk-apmu.c
+++ b/drivers/clk/mmp/clk-apmu.c
@@ -15,6 +15,8 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "clk.h"
 
@@ -22,7 +24,6 @@
 struct clk_apmu {
        struct clk_hw   hw;
        void __iomem    *base;
-       u32             rst_mask;
        u32             enable_mask;
 };
 
@@ -85,3 +86,37 @@ struct clk *mmp_clk_register_apmu(const char *name, const char *parent_name,
 
        return clk;
 }
+
+static void __init mmp_apmu_dt_init(struct device_node *node)
+{
+       struct device_node *parent = of_get_parent(node);
+       const char *clk_name = node->name;
+       void __iomem *baseaddr;
+       struct clk *clk;
+       u32 reg;
+       u32 enable_mask;
+       int rc;
+
+       rc = of_property_read_u32(node, "reg", &reg);
+       if (WARN_ON(rc))
+               return;
+
+       rc = of_property_read_u32(node, "enable-mask", &enable_mask);
+       if (WARN_ON(rc))
+               return;
+
+       baseaddr = of_iomap(parent, 0);
+       of_node_put(parent);
+       if (WARN_ON(!baseaddr))
+               return;
+
+       of_property_read_string(node, "clock-output-names", &clk_name);
+       clk = mmp_clk_register_apmu(clk_name, of_clk_get_parent_name(node, 0),
+                                   baseaddr + reg, enable_mask);
+       if (WARN_ON(IS_ERR(clk)))
+               return;
+
+       rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+       WARN_ON(rc);
+}
+CLK_OF_DECLARE(mmp2_apmu, "marvell,mmp-apmu-clock", mmp_apmu_dt_init);
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index cb1b0b6..774193b 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <mach/addr-map.h>
 
@@ -73,7 +74,7 @@ static const char *sdh_parent[] = {"pll1_4", "pll2", "usb_pll", "pll1"};
 static const char *disp_parent[] = {"pll1", "pll1_16", "pll2", "vctcxo"};
 static const char *ccic_parent[] = {"pll1_2", "pll1_16", "vctcxo"};
 
-void __init mmp2_clk_init(void)
+static void __init mmp2_clk_init_static(void)
 {
        struct clk *clk;
        struct clk *vctcxo;
@@ -445,3 +446,19 @@ void __init mmp2_clk_init(void)
                                apmu_base + APMU_CCIC1, 0x300);
        clk_register_clkdev(clk, "sphyclk", "mmp-ccic.1");
 }
+
+void __init mmp2_clk_init(void)
+{
+       struct device_node *node;
+
+       /* The presence of the ABP clock node in the device tree indicates
+        * that we should use the DT for clock setup. */
+       node = of_find_compatible_node(NULL, NULL, "marvell,mmp-apb-clock");
+       if (node) {
+               of_node_put(node);
+               of_clk_init(NULL);
+       } else {
+               /* Fallback to static setup */
+               mmp2_clk_init_static();
+       }
+}
-- 
1.8.1.4
