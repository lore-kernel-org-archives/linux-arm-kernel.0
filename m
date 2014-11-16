From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 16 Nov 2014 13:56:57 +0100
Subject: [PATCH] clk: sunxi: gmac-tx-clk mux is not a CLK_MUX_INDEX_BIT mux
Message-ID: <1416142617-4094-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A CLK_MUX_INDEX_BIT mux has one bit per parent, but the sun7i-a20-gmac-clk
has 2 bits selecting between 3 possible parents using values of 0, 1, 2,
which makes it a regular mux which should not have CLK_MUX_INDEX_BIT set in
its flag.

However we do not support parent 1 (an external clock), so use a table to
select parent 0 or 2, which are the 2 parents we support.

Note this has not been causing any issues sofar, because we start with a
parent setting of parent 0, and only ever re-parent to parent 2 (for which
we use an index of 1 as we skip parent 1) and with CLK_MUX_INDEX_BIT set
we write a value of 2 for index 1.

Tested on both a cubietruck (which uses rgmii mode) as well as a cs908
(an a31s board which uses mii mode).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/clk/sunxi/clk-a20-gmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
index 5296fd6..0dcf4f2 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -53,6 +53,11 @@ static DEFINE_SPINLOCK(gmac_lock);
 #define SUN7I_A20_GMAC_MASK	0x3
 #define SUN7I_A20_GMAC_PARENTS	2
 
+static u32 sun7i_a20_gmac_mux_table[SUN7I_A20_GMAC_PARENTS] = {
+	0x00, /* Select mii_phy_tx_clk */
+	0x02, /* Select gmac_int_tx_clk */
+};
+
 static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
@@ -90,7 +95,7 @@ static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 	gate->lock = &gmac_lock;
 	mux->reg = reg;
 	mux->mask = SUN7I_A20_GMAC_MASK;
-	mux->flags = CLK_MUX_INDEX_BIT;
+	mux->table = sun7i_a20_gmac_mux_table;
 	mux->lock = &gmac_lock;
 
 	clk = clk_register_composite(NULL, clk_name,
-- 
2.1.0
