From: felipensp@gmail.com (Felipe Pena)
Date: Mon,  7 Oct 2013 23:25:44 -0300
Subject: =?UTF-8?q?=5BPATCHv2=201/1=5D=20clk/zynq=3A=20Fix=20possible=20memory=20leak?=
Message-ID: <1381199144-5827-1-git-send-email-felipensp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq_clk_register_fclk function can leak memory (fclk_lock) when unable
to alloc memory for fclk_gate_lock

Signed-off-by: Felipe Pena <felipensp@gmail.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/clkc.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index cc40fe6..10772aa 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -117,13 +117,19 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 		goto err;
 	fclk_gate_lock = kmalloc(sizeof(*fclk_gate_lock), GFP_KERNEL);
 	if (!fclk_gate_lock)
-		goto err;
+		goto err_fclk_gate_lock;
 	spin_lock_init(fclk_lock);
 	spin_lock_init(fclk_gate_lock);

 	mux_name = kasprintf(GFP_KERNEL, "%s_mux", clk_name);
+	if (!mux_name)
+		goto err_mux_name;
 	div0_name = kasprintf(GFP_KERNEL, "%s_div0", clk_name);
+	if (!div0_name)
+		goto err_div0_name;
 	div1_name = kasprintf(GFP_KERNEL, "%s_div1", clk_name);
+	if (!div1_name)
+		goto err_div1_name;

 	clk = clk_register_mux(NULL, mux_name, parents, 4,
 			CLK_SET_RATE_NO_REPARENT, fclk_ctrl_reg, 4, 2, 0,
@@ -147,6 +153,14 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,

 	return;

+err_div1_name:
+	kfree(div0_name);
+err_div0_name:
+	kfree(mux_name);
+err_mux_name:
+	kfree(fclk_gate_lock);
+err_fclk_gate_lock:
+	kfree(fclk_lock);
 err:
 	clks[fclk] = ERR_PTR(-ENOMEM);
 }
--
1.7.10.4
