From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 Jan 2014 15:59:50 +0100
Subject: [PATCH] ARM: mvebu: Fix kernel hang in mvebu_soc_id_init() when
 of_iomap failed
Message-ID: <1390229990-26450-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pci_base is accessed whereas it has not been properly mapped by
of_iomap() the kernel hang. The check of this pointer made an improper
use of IS_ERR() instead of comparing to NULL. This patch fix this
issue.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Jason,

As this is a fix on a fix which should be ported to the stable branch, I
don't know how to handle the cc:stable flag

 arch/arm/mach-mvebu/mvebu-soc-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index fe4fc1cbdfaf..f3b325f6cbd4 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -88,7 +88,7 @@ static int __init mvebu_soc_id_init(void)
 	}
 
 	pci_base = of_iomap(child, 0);
-	if (IS_ERR(pci_base)) {
+	if (pci_base == NULL) {
 		pr_err("cannot map registers\n");
 		ret = -ENOMEM;
 		goto res_ioremap;
-- 
1.8.1.2
