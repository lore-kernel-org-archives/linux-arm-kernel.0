From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  4 Jan 2013 14:17:17 +0000
Subject: [PATCH v3 3/7] vexpress: Allow vexpress-sysreg to self-initialise
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1357309041-6192-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vexpress_sysreg_init() is a core_initcall() already and it can
trigger the early initialisation if a matching node is found. This patch
allows the SoC code to avoid calling vexpress_sysreg_of_early_init()
explicitly.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-sysreg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 733c06b..ff5d16c 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -318,8 +318,9 @@ void __init vexpress_sysreg_early_init(void __iomem *base)
 	struct device_node *node = of_find_compatible_node(NULL, NULL,
 			"arm,vexpress-sysreg");
 
-	if (node)
-		base = of_iomap(node, 0);
+	if (!node)
+		return;
+	base = of_iomap(node, 0);
 
 	if (WARN_ON(!base))
 		return;
@@ -338,6 +339,8 @@ void __init vexpress_sysreg_early_init(void __iomem *base)
 
 void __init vexpress_sysreg_of_early_init(void)
 {
+	if (vexpress_sysreg_base)
+		return;
 	vexpress_sysreg_early_init(NULL);
 }
 
@@ -470,6 +473,7 @@ static struct platform_driver vexpress_sysreg_driver = {
 
 static int __init vexpress_sysreg_init(void)
 {
+	vexpress_sysreg_of_early_init();
 	return platform_driver_register(&vexpress_sysreg_driver);
 }
 core_initcall(vexpress_sysreg_init);
