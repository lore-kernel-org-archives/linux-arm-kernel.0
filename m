From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  4 Feb 2013 18:08:02 +0000
Subject: [PATCH] vexpress: Allow vexpress-sysreg to self-initialise
Message-ID: <1360001282-25554-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vexpress_sysreg_init() is a core_initcall() already and it can
trigger the early initialisation if a matching node is found. This patch
allows the SoC code to avoid calling vexpress_sysreg_of_early_init()
explicitly.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---

Samuel, could you please merge this patch for 3.9 (based on 3.8-rc6)? It is
needed for arm64 support (which shares the same mfd files with the 32-bit arm
port). Thanks.

 drivers/mfd/vexpress-sysreg.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 77048b1..0c7c05b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -336,14 +336,15 @@ void __init vexpress_sysreg_early_init(void __iomem *base)
 
 void __init vexpress_sysreg_of_early_init(void)
 {
-	struct device_node *node = of_find_compatible_node(NULL, NULL,
-			"arm,vexpress-sysreg");
+	struct device_node *node;
 
+	if (vexpress_sysreg_base)
+		return;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
 	if (node) {
 		vexpress_sysreg_base = of_iomap(node, 0);
 		vexpress_sysreg_setup(node);
-	} else {
-		pr_info("vexpress-sysreg: No Device Tree node found.");
 	}
 }
 
@@ -478,6 +479,7 @@ static struct platform_driver vexpress_sysreg_driver = {
 
 static int __init vexpress_sysreg_init(void)
 {
+	vexpress_sysreg_of_early_init();
 	return platform_driver_register(&vexpress_sysreg_driver);
 }
 core_initcall(vexpress_sysreg_init);
