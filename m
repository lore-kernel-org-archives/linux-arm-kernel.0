From: rajan.vaja@xilinx.com (Rajan Vaja)
Date: Tue, 13 Nov 2018 23:46:49 -0800
Subject: [PATCH v2] clk: zynqmp: handle fixed factor param query error
In-Reply-To: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
References: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
Message-ID: <1542181609-12189-1-git-send-email-rajan.vaja@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return proper error code in case query for fixed factor
parameter fails. This also fixes build warning for set
but not used variable 'ret'.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Changes in v2:
  * Add Fixes tag
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
