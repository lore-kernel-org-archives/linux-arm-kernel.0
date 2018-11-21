From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Wed, 21 Nov 2018 13:28:30 +0100
Subject: [PATCH V2] clk: zynq: do not allow kmalloc failure
Message-ID: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kmalloc here is small (< 16 bytes) and occurs during initialization
during system startup here (can not be built as module) thus if this
kmalloc failed it is an indication of something more serious going on
and it is fine to hang the system here rather than cause some harder
to understand error by dereferencing NULL.

Explicitly checking would not make that much sense here as the only
possible reaction would be would BUG() here anyway.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Acked-by: Michal Simek <michal.simek@xilinx.com>
---

V2: dropped leading spaces from commit message and moved the
    compile/tool info out of git history on request of
    Michal Simek <michal.simek@xilinx.com> - thanks !

Problem located with experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_ZYNQ=y)

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/clk/zynq/clkc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index d7b53ac..014d4a4 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -440,7 +440,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
 	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
+	clk_name = kmalloc(tmp, GFP_KERNEL | __GFP_NOFAIL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-- 
2.1.4
