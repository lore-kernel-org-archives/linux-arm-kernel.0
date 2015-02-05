From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 5 Feb 2015 18:24:54 +0100
Subject: [PATCH v4 0/7] clk: Add common clock support for Mediatek MT8135
 and MT8173.
In-Reply-To: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <CABuKBeJSH3WzG3QC=9OoPzXE6fd9W2U67V4c19NzWcPxWR7VDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henry,

2015-01-30 6:13 GMT+01:00 Henry Chen <henryc.chen@mediatek.com>:
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes and clock gates.
>
> This patchset also contains a basic clock support for Mediatek MT8135 and MT8173.
>
> This driver is based on 3.19-rc1 + MT8135 and MT8173 basic support.
>
> Changes in v2:
> - Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.
>
> Changes in v3:
> - Rebase to 3.19-rc1.
> - Refine code. Remove unneed functions, debug logs and comments, and fine tune error logs.
>
> Changes in v4:
> - Support MT8173 platform.
> - Re-ordered patchset. driver/clk/Makefile in 2nd patch.
> - Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
> - Refine code. Rmove unnessacary debug information and unsed defines, add prefix "mtk_" for static functions.
> - Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on gate/mux/fixed-factor.
> - Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
> - Example above include a node for the clock controller itself, followed by the i2c controller example above.

You use pericfg and infracfg which will be used by other drivers as
well. So please use syscon for this driver. As it is no longer a
platform device it is present early in boot.
The changes should look something like the patch beneath. Please
beware that it does only show the general concept and may not even
compile. I asked Sascha to implement the reset controller as part of
the clk driver, as the registers addresses are mixed between both,
clock and reset controller. Please coordinate with him to get them
integrated (even as one series or as incremental series).

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 76562ba..886a816 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -128,7 +128,7 @@
         infracfg: infracfg at 10001000 {
             #address-cells = <1>;
             #size-cells = <1>;
-            compatible = "mediatek,mt8135-infracfg";
+            compatible = "mediatek,mt8135-infracfg", "syscon";
             reg = <0 0x10001000 0 0x1000>;
             #clock-cells = <1>;
         };
@@ -136,7 +136,7 @@
         pericfg: pericfg at 10003000 {
             #address-cells = <1>;
             #size-cells = <1>;
-            compatible = "mediatek,mt8135-pericfg";
+            compatible = "mediatek,mt8135-pericfg", "syscon";
             reg = <0 0x10003000 0 0x1000>;
             #clock-cells = <1>;
         };
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index f05507a..8af91d9 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -28,11 +28,15 @@ static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
     struct mtk_clk_gate *cg = to_clk_gate(hw);
     u32 mask;
     u32 val;
+    int ret;

     mask = BIT(cg->bit);
-    val = mask & readl(cg->sta_addr);
+    ret = regmap_read(cg->base, cg->sta_addr, &val);

-    return val == 0;
+    if (ret < 0)
+        return ret;
+
+    return (val & mask) == 0;
 }

 static int mtk_cg_bit_is_set(struct clk_hw *hw)
@@ -40,25 +44,29 @@ static int mtk_cg_bit_is_set(struct clk_hw *hw)
     struct mtk_clk_gate *cg = to_clk_gate(hw);
     u32 mask;
     u32 val;
+    int ret;

     mask = BIT(cg->bit);
-    val = mask & readl(cg->sta_addr);
+    ret = regmap_read(cg->base, cg->sta_addr, &val);
+
+    if (ret < 0)
+        return ret;

-    return val != 0;
+    return (val & mask) != 0;
 }

 static void mtk_cg_set_bit(struct clk_hw *hw)
 {
     struct mtk_clk_gate *cg = to_clk_gate(hw);

-    writel_relaxed(BIT(cg->bit), cg->set_addr);
+    regmap_write(cg->base, cg->set_addr, BIT(cg->bit));
 }

 static void mtk_cg_clr_bit(struct clk_hw *hw)
 {
     struct mtk_clk_gate *cg = to_clk_gate(hw);

-    writel_relaxed(BIT(cg->bit), cg->clr_addr);
+    regmap_write(cg->base, cg->clr_addr, BIT(cg->bit));
 }

 static int mtk_cg_enable(struct clk_hw *hw)
@@ -100,9 +108,10 @@ const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 struct clk *mtk_clk_register_gate(
         const char *name,
         const char *parent_name,
-        void __iomem *set_addr,
-        void __iomem *clr_addr,
-        void __iomem *sta_addr,
+        struct regmap *base,
+        int set_addr,
+        int clr_addr,
+        int sta_addr,
         u8 bit,
         const struct clk_ops *ops,
         spinlock_t *lock)
@@ -124,6 +133,7 @@ struct clk *mtk_clk_register_gate(
     init.num_parents = parent_name ? 1 : 0;
     init.ops = ops;

+    cg->base = base;
     cg->set_addr = set_addr;
     cg->clr_addr = clr_addr;
     cg->sta_addr = sta_addr;
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index d67a574..75fcb6709 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -24,9 +24,10 @@

 struct mtk_clk_gate {
     struct clk_hw    hw;
-    void __iomem    *set_addr;
-    void __iomem    *clr_addr;
-    void __iomem    *sta_addr;
+    struct regmap *base;
+    int set_addr;
+    int clr_addr;
+    int sta_addr;
     u8        bit;
     spinlock_t    *lock;
 };
diff --git a/drivers/clk/mediatek/clk-mt8135.c
b/drivers/clk/mediatek/clk-mt8135.c
index e212bfd..d24dd3b 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -844,13 +844,13 @@ CLK_OF_DECLARE(mtk_infrasys,
"mediatek,mt8135-infracfg", mtk_infrasys_init);
 static void __init mtk_pericfg_init(struct device_node *node)
 {
     struct clk_onecell_data *clk_data;
-    void __iomem *base;
+    static struct regmap *base;
     int r;

-    base = of_iomap(node, 0);
-    if (!base) {
-        pr_err("%s(): ioremap failed\n", __func__);
-        return;
+    base = syscon_node_to_regmap(node);
+    if (IS_ERR(base)) {
+        pr_err("%s(): failed to retrieve gpbr regmap, aborting.\n", __func__);
+        return -ENOMEM;
     }

     clk_data = mtk_alloc_clk_data(PERI_NR_CLK);
@@ -862,5 +862,6 @@ static void __init mtk_pericfg_init(struct
device_node *node)
     if (r)
         pr_err("%s(): could not register clock provider: %d\n",
             __func__, r);
+    mtk_register_softrst(np, 12, base, RK3288_SOFTRST);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ce4f2ac..0923a3a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -46,7 +46,7 @@ void mtk_init_factors(struct mtk_fixed_factor *clks, int num,
     }
 }

-void mtk_init_clk_gates(void __iomem *reg_base,
+void mtk_init_clk_gates(struct regmap *base,
         struct mtk_gate *clks, int num,
         struct clk_onecell_data *clk_data, spinlock_t *lock)
 {
@@ -57,9 +57,10 @@ void mtk_init_clk_gates(void __iomem *reg_base,
         struct mtk_gate *gate = &clks[i];

         clk = mtk_clk_register_gate(gate->name, gate->parent_name,
-                reg_base + gate->regs->set_ofs,
-                reg_base + gate->regs->clr_ofs,
-                reg_base + gate->regs->sta_ofs,
+                base,
+                gate->regs->set_ofs,
+                gate->regs->clr_ofs,
+                gate->regs->sta_ofs,
                 gate->shift, gate->ops, lock);

         if (IS_ERR(clk)) {


>
> James Liao (7):
>   clk: dts: mediatek: add Mediatek MT8135 clock bindings
>   clk: mediatek: Add initial common clock support for Mediatek SoCs.
>   clk: mediatek: Add basic clocks for Mediatek MT8135.
>   dts: mediatek: Enable clock support for Mediatek MT8135.
>   clk: dts: mediatek: add Mediatek MT8173 clock bindings
>   clk: mediatek: Add basic clocks for Mediatek MT8173.
>   dts: mediatek: Enable clock support for Mediatek MT8173.
>
>  .../bindings/clock/mediatek,mt8135-clock.txt       |   44 +
>  .../bindings/clock/mediatek,mt8173-clock.txt       |   42 +
>  arch/arm/boot/dts/mt8135.dtsi                      |   47 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   46 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/mediatek/Makefile                      |    3 +
>  drivers/clk/mediatek/clk-gate.c                    |  140 +++
>  drivers/clk/mediatek/clk-gate.h                    |   49 +
>  drivers/clk/mediatek/clk-mt8135-pll.c              |  860 ++++++++++++++++
>  drivers/clk/mediatek/clk-mt8135-pll.h              |   28 +
>  drivers/clk/mediatek/clk-mt8135.c                  |  866 +++++++++++++++++
>  drivers/clk/mediatek/clk-mt8173-pll.c              |  807 +++++++++++++++
>  drivers/clk/mediatek/clk-mt8173-pll.h              |   14 +
>  drivers/clk/mediatek/clk-mt8173.c                  | 1028 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.c                     |  154 +++
>  drivers/clk/mediatek/clk-mtk.h                     |  132 +++
>  drivers/clk/mediatek/clk-pll.c                     |   63 ++
>  drivers/clk/mediatek/clk-pll.h                     |   52 +
>  include/dt-bindings/clock/mt8135-clk.h             |  190 ++++
>  include/dt-bindings/clock/mt8173-clk.h             |  214 ++++
>  20 files changed, 4780 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8173-clock.txt
>  create mode 100644 drivers/clk/mediatek/Makefile
>  create mode 100644 drivers/clk/mediatek/clk-gate.c
>  create mode 100644 drivers/clk/mediatek/clk-gate.h
>  create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.h
>  create mode 100644 drivers/clk/mediatek/clk-mt8135.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.h
>  create mode 100644 drivers/clk/mediatek/clk-mt8173.c
>  create mode 100644 drivers/clk/mediatek/clk-mtk.c
>  create mode 100644 drivers/clk/mediatek/clk-mtk.h
>  create mode 100644 drivers/clk/mediatek/clk-pll.c
>  create mode 100644 drivers/clk/mediatek/clk-pll.h
>  create mode 100644 include/dt-bindings/clock/mt8135-clk.h
>  create mode 100644 include/dt-bindings/clock/mt8173-clk.h
>
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
