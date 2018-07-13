From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Fri, 13 Jul 2018 18:40:04 +0200
Subject: [PATCH] clk: imx6sll: fix missing of_node_put()
Message-ID: <1531500004-23175-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_compatible_node() is returning a device node with refcount
incremented and must be explicitly decremented after the last use
which is right after the us in of_iomap() here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 4a5f720b6542 ("clk: imx: add clock driver for imx6sll")
---

Problem located with experimental coccinelle script

looks like cut&past error from imx6ul (or vice versa)

Patch was compile tested with: imx_v6_v7_defconfig (implies
CONFIG_SOC_IMX6SLL=y)

Patch is against 4.18-rc4 (localversion-next is next-20180713)

 drivers/clk/imx/clk-imx6sll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 6270645..52379ee 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -92,6 +92,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sll-anatop");
 	base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!base);
 
 	/* Do not bypass PLLs initially */
-- 
2.1.4
