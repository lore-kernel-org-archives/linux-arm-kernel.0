From: olof@lixom.net (Olof Johansson)
Date: Sun,  4 Aug 2013 21:09:52 -0700
Subject: [PATCH 2/3] ARM: vexpress: make spc code TC2-only
In-Reply-To: <1375675793-16492-1-git-send-email-olof@lixom.net>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
Message-ID: <1375675793-16492-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense to match this to the generic compatible value,
since the code is quite specific to TC2 as it is.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-vexpress/spc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 34e4bf4..30cfa9f 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -187,18 +187,14 @@ void ve_spc_powerdown(u32 cluster, bool enable)
 	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
 }
 
-static const struct of_device_id ve_spc_ids[] __initconst = {
-	{ .compatible = "arm,vexpress-spc,v2p-ca15_a7" },
-	{ .compatible = "arm,vexpress-spc" },
-	{},
-};
-
 static int __init ve_spc_probe(void)
 {
 	int ret;
-	struct device_node *node = of_find_matching_node(NULL, ve_spc_ids);
+	struct device_node *dn;
+
+	dn = of_find_compatible_node(NULL, "arm,vexpress-spc,v2p-ca15_a7");
 
-	if (!node)
+	if (!dn)
 		return -ENODEV;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -207,7 +203,7 @@ static int __init ve_spc_probe(void)
 		return -ENOMEM;
 	}
 
-	info->baseaddr = of_iomap(node, 0);
+	info->baseaddr = of_iomap(dn, 0);
 	if (!info->baseaddr) {
 		pr_err(SPCLOG "unable to ioremap memory\n");
 		ret = -ENXIO;
-- 
1.8.1.192.gc4361b8
