From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:39 +1300
Subject: [PATCH v3 5/6] ARM: mvebu: Add driver for mv98dx3236-soc-id
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-6-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DFX server on the 98dx3236 and compatible SoCs has an ID register
that provides revision information that the PCI based ID register
doesn't have. Use this if it's available.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - none
    Changes in v3:
    - split from dts changes

 arch/arm/mach-mvebu/mvebu-soc-id.c | 43 +++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index a99434bcee84..b4c94a57f358 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -34,6 +34,9 @@
 #define SOC_ID_MASK	    0xFFFF0000
 #define SOC_REV_MASK	    0xFF
 
+#define MV98DX3236_DEV_ID_MASK	0xFF00
+#define MV98DX3236_REV_MASK	0xF
+
 static u32 soc_dev_id;
 static u32 soc_rev;
 static bool is_id_valid;
@@ -45,6 +48,11 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{},
 };
 
+static const struct of_device_id mvebu_mv98dx3236_of_match_table[] = {
+	{ .compatible = "marvell,mv98dx3236-soc-id", },
+	{},
+};
+
 int mvebu_get_soc_id(u32 *dev, u32 *rev)
 {
 	if (is_id_valid) {
@@ -131,15 +139,44 @@ static int __init get_soc_id_by_pci(void)
 	return ret;
 }
 
+static int __init mvebu_dfx_get_soc_id(u32 *dev, u32 *rev)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_matching_node(NULL, mvebu_mv98dx3236_of_match_table);
+	if (!np)
+		return -ENODEV;
+
+	base = of_iomap(np, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* SoC ID */
+	*dev = (readl(base) >> 12) & MV98DX3236_DEV_ID_MASK;
+	/* SoC revision */
+	*rev = (readl(base) >> 28) & MV98DX3236_REV_MASK;
+
+	iounmap(base);
+	of_node_put(np);
+
+	return 0;
+}
+
 static int __init mvebu_soc_id_init(void)
 {
 
 	/*
-	 * First try to get the ID and the revision by the system
-	 * register and use PCI registers only if it is not possible
+	 * First try to get the ID and the revision by from system controller
+	 * register, then try the DFX register (if applicable), finally read it
+	 * from PCI registers.
 	 */
-	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev)) {
+	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev))
+		is_id_valid = true;
+	else if (!mvebu_dfx_get_soc_id(&soc_dev_id, &soc_rev))
 		is_id_valid = true;
+
+	if (is_id_valid) {
 		pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);
 		return 0;
 	}
-- 
2.11.0.24.ge6920cf
