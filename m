From: chris.brandt@renesas.com (Chris Brandt)
Date: Tue,  7 Feb 2017 12:09:27 -0500
Subject: [PATCH v2 1/3] ARM: l2c: add pl310-no-sideband option
In-Reply-To: <20170207170929.29525-1-chris.brandt@renesas.com>
References: <20170207170929.29525-1-chris.brandt@renesas.com>
Message-ID: <20170207170929.29525-2-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a PL310 is added to a system, but the sideband signals are not
connected, some Cortex A9 optimizations cannot be used. In particular,
enabling Full Line Zeros in the CA9 without sidebands connected will
crash the system since the CA9 will expect the L2C to perform operations,
yet the L2C never gets the commands.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
 arch/arm/mm/cache-l2x0.c                         | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index 917199f..85046d2 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -90,6 +90,8 @@ Optional properties:
 - arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
   <1> (forcibly enable), property absent (OS specific behavior,
   preferably retain firmware settings)
+- arm,pl310-no-sideband : disable all features that require sideband signals to
+  be connected between the CPU and L2 (PL310 only).
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2290be3..c744ac4 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -57,6 +57,8 @@ static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 
 struct l2x0_regs l2x0_saved_regs;
 
+static bool l2x0_no_sideband;
+
 /*
  * Common code for all cache controllers.
  */
@@ -620,7 +622,7 @@ static void __init l2c310_enable(void __iomem *base, unsigned num_lock)
 	u32 aux = l2x0_saved_regs.aux_ctrl;
 
 	if (rev >= L310_CACHE_ID_RTL_R2P0) {
-		if (cortex_a9) {
+		if (cortex_a9 && !l2x0_no_sideband) {
 			aux |= L310_AUX_CTRL_EARLY_BRESP;
 			pr_info("L2C-310 enabling early BRESP for Cortex-A9\n");
 		} else if (aux & L310_AUX_CTRL_EARLY_BRESP) {
@@ -629,7 +631,7 @@ static void __init l2c310_enable(void __iomem *base, unsigned num_lock)
 		}
 	}
 
-	if (cortex_a9) {
+	if (cortex_a9 && !l2x0_no_sideband) {
 		u32 aux_cur = readl_relaxed(base + L2X0_AUX_CTRL);
 		u32 acr = get_auxcr();
 
@@ -1200,6 +1202,9 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		*aux_mask &= ~L2C_AUX_CTRL_PARITY_ENABLE;
 	}
 
+	if (of_property_read_bool(np, "arm,pl310-no-sideband"))
+		l2x0_no_sideband = true;
+
 	prefetch = l2x0_saved_regs.prefetch_ctrl;
 
 	ret = of_property_read_u32(np, "arm,double-linefill", &val);
-- 
2.10.1
