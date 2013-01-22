From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:22:06 +0800
Subject: [PATCH v3 5/9] ARM: PRIMA2: rstc: enable the support for Marco
Message-ID: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

marco has SET/CLEAR registers pair for rstc to avoid read-modify-write,
this patch detects the mach typer and access registers based on SoC.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rstc.c |   45 ++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 762adb7..435019c 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -19,6 +19,7 @@ static DEFINE_MUTEX(rstc_lock);
 
 static struct of_device_id rstc_ids[]  = {
 	{ .compatible = "sirf,prima2-rstc" },
+	{ .compatible = "sirf,marco-rstc" },
 	{},
 };
 
@@ -42,27 +43,37 @@ early_initcall(sirfsoc_of_rstc_init);
 
 int sirfsoc_reset_device(struct device *dev)
 {
-	const unsigned int *prop = of_get_property(dev->of_node, "reset-bit", NULL);
-	unsigned int reset_bit;
+	u32 reset_bit;
 
-	if (!prop)
-		return -ENODEV;
-
-	reset_bit = be32_to_cpup(prop);
+	if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
+		return -EINVAL;
 
 	mutex_lock(&rstc_lock);
 
-	/*
-	 * Writing 1 to this bit resets corresponding block. Writing 0 to this
-	 * bit de-asserts reset signal of the corresponding block.
-	 * datasheet doesn't require explicit delay between the set and clear
-	 * of reset bit. it could be shorter if tests pass.
-	 */
-	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
-		sirfsoc_rstc_base + (reset_bit / 32) * 4);
-	msleep(10);
-	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
-		sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	if (of_device_is_compatible(dev->of_node, "sirf,prima2-rstc")) {
+		/*
+		 * Writing 1 to this bit resets corresponding block. Writing 0 to this
+		 * bit de-asserts reset signal of the corresponding block.
+		 * datasheet doesn't require explicit delay between the set and clear
+		 * of reset bit. it could be shorter if tests pass.
+		 */
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 4);
+		msleep(10);
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	} else {
+		/*
+		 * For MARCO and POLO
+		 * Writing 1 to SET register resets corresponding block. Writing 1 to CLEAR
+		 * register de-asserts reset signal of the corresponding block.
+		 * datasheet doesn't require explicit delay between the set and clear
+		 * of reset bit. it could be shorter if tests pass.
+		 */
+		writel(reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8);
+		msleep(10);
+		writel(reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
+	}
 
 	mutex_unlock(&rstc_lock);
 
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
