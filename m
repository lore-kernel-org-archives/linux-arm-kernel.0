From: rajan.vaja@xilinx.com (Rajan Vaja)
Date: Wed, 17 Oct 2018 00:46:32 -0700
Subject: [PATCH] clk: zynqmp: handle fixed factor param query error
Message-ID: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return proper error code in case query for fixed factor
parameter fails. This also fixes build warning for set
but not used variable 'ret'.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 9d7d297..297f16a 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -279,6 +279,9 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 	qdata.arg1 = clk_id;
 
 	ret = eemi_ops->query_data(qdata, ret_payload);
+	if (ret)
+		return ERR_PTR(ret);
+
 	mult = ret_payload[1];
 	div = ret_payload[2];
 
-- 
2.7.4
