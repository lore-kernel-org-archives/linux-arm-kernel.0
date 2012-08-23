From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 14:09:52 +0800
Subject: [PATCH] ARM: PRIMA2: rstc: use of_property_read_u32 to replace
 of_get_property and be32_to_cpup
Message-ID: <1345702192-1153-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rstc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 762adb7..d03ff19 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -42,13 +42,10 @@ early_initcall(sirfsoc_of_rstc_init);
 
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
 
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
